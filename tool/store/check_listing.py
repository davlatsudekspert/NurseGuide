#!/usr/bin/env python3
"""docs/store/APP_STORE_LISTING.md: App Store Connect belgi chegaralari va
rasm o'lchamlarini tekshiradi (CI: python tool/store/check_listing.py)."""
import re
import sys
from pathlib import Path

from PIL import Image

ROOT = Path(__file__).resolve().parents[2]
text = (ROOT / 'docs/store/APP_STORE_LISTING.md').read_text(encoding='utf-8')
blocks = re.findall(r'```\n(.*?)```', text, re.S)
promo, desc, keywords = (b.strip() for b in blocks[:3])
errors = []


def field(name):
    m = re.search(r'\| %s \| `(.*?)` \|' % re.escape(name), text)
    return m.group(1) if m else ''


limits = [
    ('Name', field('Name'), 30),
    ('Subtitle', field('Subtitle'), 30),
    ('Promotional text', promo, 170),
    ('Description', desc, 4000),
    ('Keywords', keywords, 100),
]
for name, value, mx in limits:
    n = len(value)
    print(f'{name}: {n}/{mx}')
    if not value or n > mx:
        errors.append(f'{name}: {n} (limit {mx})')
if ' ' in keywords:
    errors.append('Keywords: bo\'shliq bor')
for url in re.findall(r'https://nurseguide\.nfcstore\.uz/\S*?(?=[`\s)|]|$)', text):
    if not url.endswith('/') and '.' not in url.rsplit('/', 1)[-1]:
        errors.append(f'URL oxirida / yo\'q: {url}')
if re.search(r'(secret|token|password)\s*[:=]\s*\S{12,}', text, re.I):
    errors.append('matnda sir qiymati bo\'lishi mumkin')

sizes = {'iphone_6_9': (1290, 2796), 'ipad_13': (2064, 2752)}
for d, size in sizes.items():
    files = sorted((ROOT / 'docs/store/screenshots' / d).glob('*.png'))
    print(f'{d}: {len(files)} ta')
    if len(files) != 7:
        errors.append(f'{d}: 7 ta emas ({len(files)})')
    for f in files:
        im = Image.open(f)
        if im.size != size:
            errors.append(f'{f.name}: {im.size} != {size}')
        if im.mode in ('RGBA', 'LA'):
            alpha = im.getchannel('A').getextrema()
            if alpha != (255, 255):
                errors.append(f'{f.name}: shaffoflik bor')
if errors:
    print('XATO:\n' + '\n'.join(errors))
    sys.exit(1)
print('store: hammasi joyida')
