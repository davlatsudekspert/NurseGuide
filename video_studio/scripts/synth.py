"""Inglizcha diktor ovozi (Kokoro, ochiq, bepul): sahna matnlaridan wav va timings.json.
Ishlatilishi: python3 scripts/synth.py <kokoro-dir> (ichida kokoro-v1.0.int8.onnx va voices-v1.0.bin)
"""
import json, re, sys, os, subprocess
import numpy as np, soundfile as sf
from kokoro_onnx import Kokoro

kdir = sys.argv[1]
src = open('src/content.ts', encoding='utf-8').read()
m = re.search(r"export const OVERVIEW: Scene\[\] = \[(.*?)\n\];", src, re.S)
scenes = re.findall(r"id: '([^']+)'.*?min: ([0-9.]+),.*?voice: '([^']*)'", m.group(1), re.S)
k = Kokoro(os.path.join(kdir, 'kokoro-v1.0.int8.onnx'), os.path.join(kdir, 'voices-v1.0.bin'))
os.makedirs('public/audio', exist_ok=True)
SR = 24000
out = {}
for sid, mn, text in scenes:
    samples, sr = k.create(text, voice='af_heart', speed=0.95, lang='en-us')
    sf.write(f'public/audio/{sid}.wav', samples, sr)
    dur = len(samples) / sr
    out[sid] = {'audio': round(dur, 2), 'dur': round(max(float(mn), dur + 1.0), 2)}
    print(sid, out[sid])
json.dump(out, open('public/audio/timings.json', 'w'), indent=1)
