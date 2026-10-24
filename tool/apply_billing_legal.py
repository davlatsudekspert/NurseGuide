"""Obuna yoqilganda: shartlar va maxfiylik matnlarini (ilova + sayt) qo'llaydi.
Ishlatilishi: python3 -I tool/apply_billing_legal.py   (so'ng flutter gen-l10n)
Manba: docs/legal_billing/ (obuna, bepul sinov va qurilma identifikatori matnlari)."""
import json
import shutil

src = json.load(open('docs/legal_billing/arb_texts.json', encoding='utf-8'))
for lang, texts in src.items():
    p = f'lib/l10n/app_{lang}.arb'
    d = json.load(open(p, encoding='utf-8'))
    d.update(texts)
    open(p, 'w', encoding='utf-8').write(json.dumps(d, ensure_ascii=False, indent=2) + '\n')
for name in ('privacy', 'terms'):
    shutil.copy(f'docs/legal_billing/site/{name}.html', f'site/{name}/index.html')
print('Qo\'llandi. Endi: flutter gen-l10n va testlar.')
