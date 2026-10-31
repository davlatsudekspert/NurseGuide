import React from 'react';
import {AbsoluteFill, Img, interpolate, spring, staticFile, useCurrentFrame, useVideoConfig, Sequence} from 'remotion';
import type {Lang, Scene} from './content';

const C = {
  deep: '#0B3B46', brand: '#0F6B73', mint: '#8FD6BF', soft: '#E6F4EE', ink: '#0E2A30', white: '#FFFFFF',
};
const FONT = '"Inter","Helvetica Neue",Arial,sans-serif';

export interface VideoProps {
  scenes: Scene[];
  durations: number[]; // soniya
  lang: Lang | 'all';
  vertical: boolean;
}

const LANG_FRAME: Record<Lang, Lang> = {uz: 'uz', ru: 'ru', en: 'en'};

/** Yakinlashtirilgan ko'rinish: kadrning qaysi qismi (yuqoridan ulushi) katta kartada ko'rsatiladi. */
const ZOOM_Y: Record<string, number> = {
  '01_home': 0.22, '11_daily': 0.2, '02_hub': 0.4, '03_test_setup': 0.22, '04_question': 0.13,
  '06_oral_plan': 0.26, '07_procedure': 0.22, '08_workplace': 0.26, '10_group_results': 0.22, '09_sources': 0.33,
};

const ZoomCard: React.FC<{src: string; y: number}> = ({src, y}) => {
  const f = useCurrentFrame();
  const {fps} = useVideoConfig();
  const s = spring({frame: f - 14, fps, config: {damping: 18}});
  const W = 860; const H = 400; const imgH = W / 0.4616;
  return (
    <div style={{width: W, height: H, borderRadius: 28, overflow: 'hidden', position: 'relative', background: C.soft,
      transform: `translateX(${(1 - s) * -80}px)`, opacity: s, boxShadow: '0 30px 70px rgba(0,0,0,0.4)', border: '3px solid rgba(255,255,255,0.35)'}}>
      <Img src={src} style={{position: 'absolute', left: 0, top: -y * imgH, width: W, height: imgH}} />
    </div>
  );
};

const Background: React.FC = () => {
  const f = useCurrentFrame();
  const t = f / 30;
  return (
    <AbsoluteFill style={{background: `linear-gradient(160deg, ${C.deep} 0%, ${C.brand} 55%, #14899A 100%)`}}>
      {[0, 1, 2].map((i) => (
        <div
          key={i}
          style={{
            position: 'absolute',
            width: 700 + i * 160,
            height: 700 + i * 160,
            borderRadius: '50%',
            background: `radial-gradient(circle, rgba(143,214,191,${0.22 - i * 0.05}) 0%, rgba(143,214,191,0) 70%)`,
            left: `${[5, 55, 30][i] + Math.sin(t / 3 + i) * 6}%`,
            top: `${[60, 10, 35][i] + Math.cos(t / 4 + i) * 6}%`,
          }}
        />
      ))}
    </AbsoluteFill>
  );
};

const Phone: React.FC<{src: string; height: number; delay?: number; tilt?: number}> = ({src, height, delay = 0, tilt = 0}) => {
  const f = useCurrentFrame();
  const {fps} = useVideoConfig();
  const s = spring({frame: f - delay, fps, config: {damping: 16, stiffness: 90}});
  const w = height * 0.4616;
  const float = Math.sin(f / 28) * 6;
  return (
    <div
      style={{
        width: w,
        height,
        transform: `translateY(${(1 - s) * 140 + float}px) rotateY(${tilt * s}deg) scale(${0.9 + 0.1 * s})`,
        opacity: s,
        borderRadius: w * 0.14,
        background: '#0A1E22',
        padding: w * 0.022,
        boxShadow: '0 40px 90px rgba(0,0,0,0.45), 0 0 0 2px rgba(255,255,255,0.12) inset',
      }}
    >
      <div style={{width: '100%', height: '100%', borderRadius: w * 0.12, overflow: 'hidden', background: C.soft}}>
        <Img src={src} style={{width: '100%', height: '100%', objectFit: 'cover', objectPosition: 'top'}} />
      </div>
    </div>
  );
};

const Subtitle: React.FC<{lines: string[]; size: number; vertical: boolean}> = ({lines, size, vertical}) => {
  const f = useCurrentFrame();
  const o = interpolate(f, [0, 10], [0, 1], {extrapolateRight: 'clamp'});
  return (
    <div
      style={{
        opacity: o,
        background: 'rgba(8,28,33,0.72)',
        borderRadius: 22,
        padding: vertical ? '18px 26px' : '16px 28px',
        color: C.white,
        fontFamily: FONT,
        textAlign: vertical ? 'center' : 'left',
        lineHeight: 1.22,
      }}
    >
      {lines.map((l, i) => (
        <div key={i} style={{fontSize: i === 0 ? size : size * 0.66, fontWeight: i === 0 ? 700 : 500, opacity: i === 0 ? 1 : 0.88, marginTop: i ? 8 : 0}}>
          {l}
        </div>
      ))}
    </div>
  );
};

const Title: React.FC<{text: string; size: number; align: 'left' | 'center'}> = ({text, size, align}) => {
  const f = useCurrentFrame();
  const o = interpolate(f, [4, 18], [0, 1], {extrapolateRight: 'clamp'});
  const y = interpolate(f, [4, 18], [30, 0], {extrapolateRight: 'clamp'});
  return (
    <div style={{opacity: o, transform: `translateY(${y}px)`, color: C.white, fontFamily: FONT, fontWeight: 800, fontSize: size, lineHeight: 1.05, textAlign: align, letterSpacing: -1}}>
      {text}
    </div>
  );
};

const EndCard: React.FC<{scene: Scene; lang: Lang | 'all'; vertical: boolean}> = ({scene, lang, vertical}) => {
  const f = useCurrentFrame();
  const {fps} = useVideoConfig();
  const s = spring({frame: f, fps, config: {damping: 14}});
  const L: Lang[] = lang === 'all' ? ['uz', 'ru', 'en'] : [lang];
  return (
    <AbsoluteFill style={{alignItems: 'center', justifyContent: 'center', fontFamily: FONT, color: C.white, textAlign: 'center'}}>
      <div style={{transform: `scale(${0.8 + 0.2 * s})`, opacity: s}}>
        <div style={{fontSize: vertical ? 130 : 120, fontWeight: 800, letterSpacing: -3}}>NurseGuide</div>
        <div style={{marginTop: 10, fontSize: vertical ? 48 : 44, color: C.mint, fontWeight: 600}}>Hamshiralar uchun · Для медсестёр · For nurses</div>
        <div style={{marginTop: 50, fontSize: vertical ? 64 : 58, fontWeight: 700}}>
          {L.map((l) => (<div key={l} style={{marginTop: 8}}>{scene.title[l]}</div>))}
        </div>
        <div style={{marginTop: 40, fontSize: 38, opacity: 0.85}}>{scene.line.uz}</div>
      </div>
    </AbsoluteFill>
  );
};

const SceneView: React.FC<{scene: Scene; lang: Lang | 'all'; vertical: boolean; dur: number}> = ({scene, lang, vertical, dur}) => {
  const f = useCurrentFrame();
  const fadeOut = interpolate(f, [dur - 8, dur], [1, 0], {extrapolateLeft: 'clamp'});
  const fadeIn = interpolate(f, [0, 8], [0, 1], {extrapolateRight: 'clamp'});
  const op = Math.min(fadeIn, fadeOut);
  if (scene.end) return <AbsoluteFill style={{opacity: op}}><EndCard scene={scene} lang={lang} vertical={vertical} /></AbsoluteFill>;
  const L: Lang[] = lang === 'all' ? ['uz', 'ru', 'en'] : [lang];
  const frameLang: Lang = lang === 'all' ? 'uz' : lang;
  const idx = scene.frames.length > 1 ? Math.min(scene.frames.length - 1, Math.floor((f / dur) * scene.frames.length)) : 0;
  const imgSrc = (n: string, l: Lang) => staticFile(`frames/${LANG_FRAME[l]}/${n}.png`);
  const phones = scene.triple
    ? (['uz', 'ru', 'en'] as Lang[]).map((l, i) => (
        <Phone key={l} src={imgSrc(scene.frames[0], l)} height={vertical ? 760 : 640} delay={i * 6} tilt={(i - 1) * -10} />
      ))
    : [<Phone key={idx} src={imgSrc(scene.frames[idx], frameLang)} height={vertical ? 1040 : 940} tilt={-8} />];
  const subLines = L.map((l) => scene.line[l]);
  const title = L.length === 1 ? scene.title[L[0]] : scene.title.uz;
  if (vertical) {
    return (
      <AbsoluteFill style={{opacity: op}}>
        <div style={{position: 'absolute', top: 232, left: 60, right: 60}}><Title text={title} size={78} align="center" /></div>
        <div style={{position: 'absolute', top: 360, left: 0, right: 0, display: 'flex', justifyContent: 'center', gap: 20, perspective: 1600}}>{phones}</div>
        <div style={{position: 'absolute', left: 48, right: 48, bottom: 360}}><Subtitle lines={subLines} size={lang === 'all' ? 46 : 44} vertical /></div>
      </AbsoluteFill>
    );
  }
  return (
    <AbsoluteFill style={{opacity: op}}>
      <div style={{position: 'absolute', left: 110, top: 90, width: 860}}>
        <Title text={title} size={98} align="left" />
        <div style={{marginTop: 40, maxWidth: 800}}><Subtitle lines={subLines} size={46} vertical={false} /></div>
        {!scene.triple && ZOOM_Y[scene.frames[idx]] !== undefined && (
          <div style={{marginTop: 36}}><ZoomCard key={idx} src={imgSrc(scene.frames[idx], frameLang)} y={ZOOM_Y[scene.frames[idx]]} /></div>
        )}
      </div>
      <div style={{position: 'absolute', right: 120, top: 70, display: 'flex', gap: 24, perspective: 1800}}>{phones}</div>
    </AbsoluteFill>
  );
};

export const NurseVideo: React.FC<VideoProps> = ({scenes, durations, lang, vertical}) => {
  let start = 0;
  return (
    <AbsoluteFill style={{background: C.deep}}>
      <Background />
      {scenes.map((sc, i) => {
        const d = Math.round(durations[i] * 30);
        const from = start;
        start += d;
        return (
          <Sequence key={sc.id} from={from} durationInFrames={d}>
            <SceneView scene={sc} lang={lang} vertical={vertical} dur={d} />
          </Sequence>
        );
      })}
    </AbsoluteFill>
  );
};
