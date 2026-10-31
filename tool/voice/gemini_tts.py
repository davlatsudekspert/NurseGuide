"""Gemini TTS: o'zbekcha diktor ovozi (video roliklar uchun). Kalit faqat GEMINI_API_KEY muhit
o'zgaruvchisida (GitHub secret); hech qachon chop etilmaydi. Faqat standart kutubxona.

  python3 tool/voice/gemini_tts.py <chiqish_papka> [--test]

--test: faqat birinchi gap + uzbekcha ovozlar ro'yxati (arzon sinov).
Muhit: GEMINI_MODEL (standart gemini-3.8-flash-tts), GEMINI_VOICE (standart Fola),
GEMINI_FALLBACK_MODEL / GEMINI_FALLBACK_VOICE (hujjatlashtirilgan generateContent API).
"""
import base64, json, os, struct, sys, time, urllib.error, urllib.request

KEY = os.environ.get('GEMINI_API_KEY', '')
BASE = 'https://generativelanguage.googleapis.com/v1beta'
MODEL = os.environ.get('GEMINI_MODEL', 'gemini-3.8-flash-tts')
VOICE = os.environ.get('GEMINI_VOICE', 'Fola')
FB_MODEL = os.environ.get('GEMINI_FALLBACK_MODEL', 'gemini-2.5-flash-preview-tts')
FB_VOICE = os.environ.get('GEMINI_FALLBACK_VOICE', 'Kore')


def call(url, body=None, method='POST'):
    last = None
    for attempt in range(3):
        req = urllib.request.Request(url, data=None if body is None else json.dumps(body).encode(), method=method,
                                     headers={'x-goog-api-key': KEY, 'Content-Type': 'application/json'})
        try:
            with urllib.request.urlopen(req, timeout=60) as r:
                return json.loads(r.read())
        except urllib.error.HTTPError as e:
            msg = e.read().decode('utf-8', 'replace')[:300].replace(KEY, '***') if KEY else ''
            last = f'HTTP {e.code}: {msg}'
            if e.code in (429, 500, 502, 503, 504):
                time.sleep(2 ** attempt * 2)
                continue
            raise RuntimeError(last)
        except Exception as e:  # tarmoq
            last = f'{type(e).__name__}'
            time.sleep(2 ** attempt)
    raise RuntimeError(last or 'xato')


def wav_from_pcm(pcm, rate=24000):
    hdr = b'RIFF' + struct.pack('<I', 36 + len(pcm)) + b'WAVEfmt ' + struct.pack('<IHHIIHH', 16, 1, 1, rate, rate * 2, 2, 16) + b'data' + struct.pack('<I', len(pcm))
    return hdr + pcm


def via_interactions(text):
    body = {
        'model': MODEL,
        'input': [{'type': 'user_input', 'content': [{'type': 'text', 'text': text,
                                                        'annotations': [{'type': 'speech_metadata', 'style': ''}]}]}],
        'response_format': {'type': 'audio'},
        'generation_config': {'speech_config': [{'voice': VOICE}]},
    }
    d = call(f'{BASE}/interactions', body)
    audios = [c for s in d.get('steps', []) if s.get('type') == 'model_output' for c in s.get('content', []) if c.get('type') == 'audio']
    if not audios:
        raise RuntimeError('javobda audio yo‘q')
    return base64.b64decode(audios[-1]['data'])  # tayyor WAV


def via_generate_content(text):
    body = {
        'contents': [{'parts': [{'text': text}]}],
        'generationConfig': {'responseModalities': ['AUDIO'],
                             'speechConfig': {'voiceConfig': {'prebuiltVoiceConfig': {'voiceName': FB_VOICE}}}},
    }
    d = call(f'{BASE}/models/{FB_MODEL}:generateContent', body)
    part = d['candidates'][0]['content']['parts'][0]['inlineData']
    return wav_from_pcm(base64.b64decode(part['data']))


def synth(text):
    try:
        return via_interactions(text), f'{MODEL}/{VOICE}'
    except Exception as e:
        print(f'  asosiy usul ishlamadi ({e}); zaxira: {FB_MODEL}/{FB_VOICE}')
        return via_generate_content(text), f'{FB_MODEL}/{FB_VOICE}'


def main():
    if not KEY:
        sys.exit('GEMINI_API_KEY berilmagan')
    out = sys.argv[1]
    test = '--test' in sys.argv
    os.makedirs(out, exist_ok=True)
    lines = json.load(open(os.path.join(os.path.dirname(__file__), 'lines_uz.json'), encoding='utf-8'))
    if test:
        try:
            v = call(f'{BASE}/voices?language_code=uz&page_size=50', method='GET')
            names = [x.get('name') or x.get('voice') for x in v.get('voices', [])][:30]
            print('uz ovozlar:', names)
        except Exception as e:
            print('ovozlar ro‘yxati olinmadi:', e)
        lines = dict(list(lines.items())[:1])
    used = set()
    for sid, text in lines.items():
        wav, used_model = synth(text)
        open(os.path.join(out, f'{sid}.wav'), 'wb').write(wav)
        used.add(used_model)
        print(sid, len(wav) // 1024, 'KB')
    json.dump({'used': sorted(used)}, open(os.path.join(out, 'used.json'), 'w'))
    print('tayyor:', sorted(used))


if __name__ == '__main__':
    main()
