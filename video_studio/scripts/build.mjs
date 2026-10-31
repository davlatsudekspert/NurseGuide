// node scripts/build.mjs [only=<id-lang>]  — roliklarni render qiladi, ovoz qo'shadi, srt/vtt va muqova yasaydi.
import {bundle} from '@remotion/bundler';
import {renderMedia, renderStill, selectComposition} from '@remotion/renderer';
import {execFileSync} from 'node:child_process';
import fs from 'node:fs';
import path from 'node:path';
import {createRequire} from 'node:module';

const BROWSER = process.env.REMOTION_BROWSER ?? '/opt/pw-browsers/chromium_headless_shell-1194/chrome-linux/headless_shell';
const only = (process.argv.find((a) => a.startsWith('only=')) ?? '').slice(5);
fs.mkdirSync('out', {recursive: true});
fs.mkdirSync('build', {recursive: true});

// content.ts dan sahnalar (tsx kerak emas: Remotion bundler o'qiydi, bu yerda oddiy parser)
const ts = fs.readFileSync('src/content.ts', 'utf8');
const grab = (name) => {
  const body = ts.split(`export const ${name}: Scene[] = [`)[1].split('\n];')[0];
  // eval qilinadigan JS obyektlari
  return (0, eval)(`[${body}\n]`);
};
const OVERVIEW = grab('OVERVIEW');
const REEL = grab('REEL');
const timings = JSON.parse(fs.readFileSync('public/audio/timings.json', 'utf8'));
const ovDur = OVERVIEW.map((s) => timings[s.id].dur);
const reelDur = REEL.map((s) => s.min);

const jobs = [];
for (const lang of ['uz', 'ru', 'en']) {
  jobs.push({key: `overview-16x9-${lang}`, comp: 'overview-16x9', scenes: OVERVIEW, durs: ovDur, lang, vertical: false, voice: true});
  jobs.push({key: `overview-9x16-${lang}`, comp: 'overview-9x16', scenes: OVERVIEW, durs: ovDur, lang, vertical: true, voice: true});
}
jobs.push({key: 'reel-9x16-all', comp: 'reel-9x16', scenes: REEL, durs: reelDur, lang: 'all', vertical: true, voice: false});

const ff = (args) => execFileSync('ffmpeg', ['-y', '-loglevel', 'error', ...args], {stdio: 'inherit'});
const ts2 = (sec, vtt) => {
  const ms = Math.round(sec * 1000);
  const h = String(Math.floor(ms / 3600000)).padStart(2, '0');
  const m = String(Math.floor(ms / 60000) % 60).padStart(2, '0');
  const s = String(Math.floor(ms / 1000) % 60).padStart(2, '0');
  const x = String(ms % 1000).padStart(3, '0');
  return `${h}:${m}:${s}${vtt ? '.' : ','}${x}`;
};

const serveUrl = await bundle({entryPoint: path.resolve('src/index.ts'), publicDir: path.resolve('public')});

for (const j of jobs) {
  if (only && !j.key.includes(only)) continue;
  const silent = `build/${j.key}.silent.mp4`;
  const final = `out/${j.key}.mp4`;
  const inputProps = {scenes: j.scenes, durations: j.durs, lang: j.lang, vertical: j.vertical};
  const comp = await selectComposition({serveUrl, id: j.comp, inputProps, browserExecutable: BROWSER});
  console.log(`render ${j.key}: ${comp.durationInFrames} kadr`);
  await renderMedia({composition: comp, serveUrl, codec: 'h264', pixelFormat: 'yuv420p', crf: 20, outputLocation: silent, inputProps, browserExecutable: BROWSER, concurrency: 3});
  if (j.voice) {
    const inputs = j.scenes.flatMap((s) => ['-i', `public/audio/${s.id}.wav`]);
    const chain = j.scenes.map((s, i) => `[${i}:a]aresample=48000,apad=whole_dur=${j.durs[i]}[a${i}]`).join(';');
    const cat = j.scenes.map((_, i) => `[a${i}]`).join('') + `concat=n=${j.scenes.length}:v=0:a=1[c];[c]loudnorm=I=-16:TP=-2.4:LRA=7[out]`;
    ff([...inputs, '-filter_complex', `${chain};${cat}`, '-map', '[out]', '-c:a', 'aac', '-b:a', '192k', `build/${j.key}.m4a`]);
    ff(['-i', silent, '-i', `build/${j.key}.m4a`, '-c:v', 'copy', '-c:a', 'copy', '-shortest', '-movflags', '+faststart', final]);
  } else {
    ff(['-i', silent, '-c:v', 'copy', '-movflags', '+faststart', final]);
  }
  fs.rmSync(silent, {force: true});
  // srt / vtt
  const langs = j.lang === 'all' ? ['uz', 'ru', 'en'] : [j.lang];
  for (const l of langs) {
    let t = 0; let n = 1; let srt = ''; let vtt = 'WEBVTT\n\n';
    j.scenes.forEach((s, i) => {
      const a = t; const b = t + j.durs[i] - 0.1; t += j.durs[i];
      if (s.end) return;
      srt += `${n}\n${ts2(a + 0.2, false)} --> ${ts2(b, false)}\n${s.line[l]}\n\n`;
      vtt += `${ts2(a + 0.2, true)} --> ${ts2(b, true)}\n${s.line[l]}\n\n`;
      n++;
    });
    fs.writeFileSync(`out/${j.key.replace(/-(uz|ru|en|all)$/, '')}-${l}.srt`, srt);
    fs.writeFileSync(`out/${j.key.replace(/-(uz|ru|en|all)$/, '')}-${l}.vtt`, vtt);
  }
  // muqova: "hub" (yoki reel uchun 1-sahna) sahnasidan
  const si = j.scenes.findIndex((s) => s.id === 'hub' || s.id === 'r-hook');
  const at = j.durs.slice(0, si).reduce((a, b) => a + b, 0) + 3;
  const still = `build/${j.key}.jpg`;
  await renderStill({composition: comp, serveUrl, output: still, frame: Math.round(at * 30), inputProps, browserExecutable: BROWSER, imageFormat: 'jpeg', jpegQuality: 92});
  const out = j.vertical ? `out/${j.key}-cover_1080x1920.jpg` : `out/${j.key}-thumb_1280x720.jpg`;
  ff(['-i', still, '-vf', j.vertical ? 'scale=1080:1920' : 'scale=1280:720', out]);
}
console.log('tayyor');
