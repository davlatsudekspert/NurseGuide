#!/usr/bin/env python3
"""site/ qorovuli (CI `tests` job): statik sayt qoidalari buzilmasin.

* taqiqlangan so'zlar (qoralama/draft, eski brend) yo'q;
* tashqi resurs yo'q (faqat mailto: va nurseguide: havolalar; <script> faqat j/);
* ichki havolalar va #bo'limlar mavjud;
* huquqiy sahifalarda uz/ru/en bo'limlari, kuchga kirgan sana va aloqa emaili bor.
Ishlatish: python3 .github/scripts/check_site.py
"""
import re
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2] / 'site'
FORBIDDEN = re.compile(r'draft|qoralama|черновик|labguide|lab guide', re.I)
EMAIL = 'nurseguide@nfcstore.uz'
DATE = '2026-10-18'
LEGAL = {'privacy/index.html', 'terms/index.html', 'delete-account/index.html'}

errors: list[str] = []
pages = sorted(ROOT.rglob('*.html'))
if not pages:
    errors.append('site/ ichida HTML yo\'q')
ids = {p: set(re.findall(r'\sid="([^"]+)"', p.read_text(encoding='utf-8'))) for p in pages}

for p in pages:
    rel = p.relative_to(ROOT).as_posix()
    s = p.read_text(encoding='utf-8')
    for m in FORBIDDEN.finditer(s):
        errors.append(f'{rel}: taqiqlangan so\'z "{m.group(0)}"')
    if '<script' in s and rel != 'j/index.html':
        errors.append(f'{rel}: <script> faqat j/ sahifasida mumkin')
    if re.search(r'(src|href)="https?://', s) or 'url(http' in s:
        errors.append(f'{rel}: tashqi resurs/havola')
    if rel != 'j/index.html' and 'noindex' in s:
        errors.append(f'{rel}: noindex faqat j/ uchun')
    for h in re.findall(r'href="([^"]+)"', s):
        if h.startswith(('mailto:', 'nurseguide:')):
            continue
        path, _, frag = h.partition('#')
        tgt = p if path == '' else (p.parent / path).resolve()
        if tgt.is_dir():
            tgt = tgt / 'index.html'
        if not tgt.exists():
            errors.append(f'{rel}: havola ishlamaydi {h}')
        elif frag and tgt in ids and frag not in ids[tgt]:
            errors.append(f'{rel}: bo\'lim topilmadi {h}')
    if rel in LEGAL or rel == 'index.html':
        for lang in ('uz', 'ru', 'en'):
            if f'id="{lang}"' not in s:
                errors.append(f'{rel}: "{lang}" bo\'limi yo\'q')
    if rel in ('privacy/index.html', 'terms/index.html'):
        if DATE not in s:
            errors.append(f'{rel}: kuchga kirgan sana {DATE} yo\'q')
    if rel in LEGAL and EMAIL not in s:
        errors.append(f'{rel}: aloqa emaili {EMAIL} yo\'q')

for need in ('index.html', 'privacy/index.html', 'terms/index.html', 'delete-account/index.html', 'j/index.html',
             'style.css', 'logo.png', 'robots.txt'):
    if not (ROOT / need).exists():
        errors.append(f'site/{need} yo\'q')
css = (ROOT / 'style.css').read_text(encoding='utf-8') if (ROOT / 'style.css').exists() else ''
if 'http' in css and re.search(r'url\(\s*["\']?https?:', css):
    errors.append('style.css: tashqi resurs')

if errors:
    print('\n'.join(errors))
    sys.exit(1)
print(f'site: {len(pages)} sahifa, xato yo\'q')
