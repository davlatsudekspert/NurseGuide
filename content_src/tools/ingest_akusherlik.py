"""Akusherlik ishi (o'rta tibbiyot xodimlari) test savollarini assets/toifa/tests.json
ga `akusherlik` banki sifatida qo'shadi. Qayta ishga tushirish xavfsiz: shu skript
qo'shgan savollar (id `ng-ak-…`) har safar qayta yoziladi.

Manba: content_src/akusherlik/akusherlik-ishi.json — PDF'dagi sariq belgilar
(Highlight) bo'yicha tiklangan kalit (549/550). Kalitsiz savol (70) tashlanadi.

Ishlatilishi: python3 -I content_src/tools/ingest_akusherlik.py
"""
import difflib
import json
import random
import re

SRC = 'content_src/akusherlik/akusherlik-ishi.json'
TESTS = 'assets/toifa/tests.json'
BANK = 'akusherlik'
TOPIC = 'obstetrics'
CHECKED = '2026-10-24'
SOURCE = (
    "Manba: «Akusherlik ishi mutaxassisligi bo'yicha test savollari» ro'yxati "
    "(o'rta tibbiyot xodimlari uchun norasmiy to'plam); to'g'ri javob fayldagi "
    "belgi bo'yicha, tibbiy mutaxassis tekshiruvidan o'tmagan"
)

# Kirillcha harf shakli bir xil lotin harflari (matnda adashib tushgan).
HOMO = str.maketrans('аоеНО', 'aoeHO')
FIXED_OPT = re.compile(
    r"(hammasi|barcha|hech biri|to'g'ri javob yo'q|yuqoridagi|ham .* ham)", re.I)


def clean(s):
    s = s.translate(HOMO)
    for ch in '’ʼʻ‘`´':
        s = s.replace(ch, "'")
    s = s.replace(' ', ' ')
    return re.sub(r'\s+', ' ', s).strip()


def key(s):
    return ' '.join(re.sub(r"[^a-z0-9' ]+", ' ', clean(s).lower()).split())


def main():
    src = json.load(open(SRC, encoding='utf-8'))['items']
    tests = json.load(open(TESTS, encoding='utf-8'))
    keep = [q for q in tests['questions'] if not q['id'].startswith('ng-ak-')]
    seen = [(q['id'], key(q['q'])) for q in keep]
    base = max(q['n'] for q in keep)  # test n lari butun bank bo'yicha takrorlanmaydi
    added, skipped_nokey, skipped_dup = [], [], []
    for it in src:
        if it.get('answerIndex') is None:
            skipped_nokey.append(it['n'])
            continue
        q = clean(it['q'])
        opts = [clean(o) for o in it['options']]
        k = key(q)
        dup = next((i for i, p in seen
                    if abs(len(p) - len(k)) < 30
                    and difflib.SequenceMatcher(None, k, p).ratio() >= 0.9), None)
        if dup:
            skipped_dup.append((it['n'], dup))
            continue
        seen.append((f'ak-{it["n"]}', k))
        ans = it['answerIndex']
        order = list(range(len(opts)))
        # Javob o'rni A ga yig'ilib qolmasin (43%): variantlarni tasodifiy aralashtiramiz
        # (qat'iy urug' bilan), «hammasi/hech biri» turidagilarni joyida qoldiramiz.
        if not any(FIXED_OPT.search(o) for o in opts):
            random.Random(f'ak-{it["n"]}').shuffle(order)
        opts2 = [opts[i] for i in order]
        ans2 = order.index(ans)
        added.append({
            'id': f'ng-ak-{it["n"]:03d}',
            'n': base + len(added) + 1,
            'q': q,
            'options': opts2,
            'key': [ans2],
            'topic': TOPIC,
            'verdict': 'ok',
            'checked': CHECKED,
            'source': SOURCE,
            'bank': BANK,
        })
    tests['questions'] = keep + added
    if TOPIC not in tests['topics']:
        tests['topics'].append(TOPIC)
    tests['topic_names'][TOPIC] = {
        'uz': 'Akusherlik', 'ru': 'Акушерство', 'en': 'Obstetrics'}
    json.dump(tests, open(TESTS, 'w', encoding='utf-8'), ensure_ascii=False, indent=1)
    open(TESTS, 'a').write('\n')
    print(f"qo'shildi {len(added)}; kalitsiz {skipped_nokey}; takror {len(skipped_dup)}")


if __name__ == '__main__':
    main()
