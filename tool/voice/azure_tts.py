"""Azure Speech (rasmiy) bilan o'zbekcha diktor ovozi: uz-UZ-MadinaNeural.
Kalit: AZURE_SPEECH_KEY, hudud: AZURE_SPEECH_REGION (GitHub secrets). Kalit chop etilmaydi.
  python3 tool/voice/azure_tts.py <chiqish_papka> [--test]
"""
import html, json, os, sys, time, urllib.error, urllib.request

KEY = os.environ.get('AZURE_SPEECH_KEY', '')
REGION = os.environ.get('AZURE_SPEECH_REGION', '').strip().lower()
VOICE = os.environ.get('AZURE_VOICE', 'uz-UZ-MadinaNeural')


def synth(text):
    ssml = f"<speak version='1.0' xml:lang='uz-UZ'><voice name='{VOICE}'>{html.escape(text)}</voice></speak>"
    url = f'https://{REGION}.tts.speech.microsoft.com/cognitiveservices/v1'
    last = None
    for attempt in range(3):
        req = urllib.request.Request(url, data=ssml.encode('utf-8'), method='POST', headers={
            'Ocp-Apim-Subscription-Key': KEY, 'Content-Type': 'application/ssml+xml',
            'X-Microsoft-OutputFormat': 'riff-24khz-16bit-mono-pcm', 'User-Agent': 'nurseguide-video'})
        try:
            with urllib.request.urlopen(req, timeout=60) as r:
                return r.read()
        except urllib.error.HTTPError as e:
            last = f'HTTP {e.code}'
            if e.code in (429, 500, 502, 503, 504):
                time.sleep(2 ** attempt * 2)
                continue
            raise RuntimeError(last)
        except Exception as e:
            last = type(e).__name__
            time.sleep(2 ** attempt)
    raise RuntimeError(last or 'xato')


def main():
    if not KEY or not REGION:
        sys.exit('AZURE_SPEECH_KEY / AZURE_SPEECH_REGION berilmagan')
    out = sys.argv[1]
    os.makedirs(out, exist_ok=True)
    lines = json.load(open(os.path.join(os.path.dirname(__file__), 'lines_uz.json'), encoding='utf-8'))
    if '--test' in sys.argv:
        lines = dict(list(lines.items())[:1])
    for sid, text in lines.items():
        wav = synth(text)
        open(os.path.join(out, f'{sid}.wav'), 'wb').write(wav)
        print(sid, len(wav) // 1024, 'KB')
    json.dump({'used': [VOICE]}, open(os.path.join(out, 'used.json'), 'w'))
    print('tayyor:', VOICE)


if __name__ == '__main__':
    main()
