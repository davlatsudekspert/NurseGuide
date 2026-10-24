"""Kalitli (to'g'ri javobi belgilangan) test to'plamlarini assets/toifa/tests.json ga
qo'shadi. Har to'plam o'z id-prefiksi bilan yoziladi; qayta ishga tushirish xavfsiz
(shu skript qo'shgan savollar har safar qayta yoziladi).

Manba JSON: {"items":[{"n","q","options":[…],"answerIndex": int|null}]} — kalit PDF dagi
sariq belgilardan (Highlight) tiklangan. Kalitsiz / bir nechta javobli savollar tashlanadi.
Mavjud savollar bilan (matn o'xshashligi >= 0.9) takrorlari qo'shilmaydi.

Ishlatilishi: python3 -I content_src/tools/ingest_mcq.py
"""
import difflib
import json
import random
import re

TESTS = 'assets/toifa/tests.json'
CHECKED = '2026-10-24'

CONFIGS = [
    {
        'src': 'content_src/akusherlik/akusherlik-ishi.json',
        'prefix': 'ng-ak-',
        'bank': 'akusherlik',
        'topic': 'obstetrics',
        'topic_names': {'uz': 'Akusherlik', 'ru': 'Акушерство', 'en': 'Obstetrics'},
        'source': (
            "Manba: «Akusherlik ishi mutaxassisligi bo'yicha test savollari» ro'yxati "
            "(o'rta tibbiyot xodimlari uchun norasmiy to'plam); to'g'ri javob fayldagi "
            "belgi bo'yicha, tibbiy mutaxassis tekshiruvidan o'tmagan"
        ),
    },
    {
        'src': 'content_src/rentgen/rentgen-laborant.json',
        'prefix': 'ng-rl-',
        'bank': 'rentgen_laborant',
        'topic': 'radiology',
        'topic_names': {'uz': 'Rentgenologiya', 'ru': 'Рентгенология', 'en': 'Radiology'},
        'source': (
            "Manba: «Rentgen laboranti» test savollari ro'yxati (o'rta tibbiyot xodimlari "
            "uchun norasmiy to'plam); to'g'ri javob fayldagi belgi bo'yicha, tibbiy "
            "mutaxassis tekshiruvidan o'tmagan"
        ),
    },
    {
        'src': 'content_src/patronaj/patronajlar.json',
        'prefix': 'ng-pc-',
        'bank': 'patronaj',
        'topic': 'general',
        'topic_names': None,
        'source': (
            "Manba: «Hamshiralik ishi (patronaj hamshiralari)» test savollari ro'yxati "
            "(Patronajlar, norasmiy to'plam); to'g'ri javob fayldagi belgi bo'yicha, "
            "tibbiy mutaxassis tekshiruvidan o'tmagan"
        ),
    },
]

# Kirillcha harf shakli bir xil lotin harflari (matnda adashib tushgan).
HOMO = str.maketrans('аоесрхумАВЕНКМОРСТ', 'aoecpxymABEHKMOPCT')
FIXED_OPT = re.compile(
    r"(hammasi|barcha|hech biri|to'g'ri javob yo'q|yuqoridagi|ham .* ham)", re.I)


def clean(s):
    s = re.sub(r'\s*\([^)]*[Ѐ-ӿ][^)]*\)', '', s)  # ruscha izoh (qavs ichida) tashlanadi
    s = s.translate(HOMO)
    s = re.sub(r'(?<=[A-Za-z])[ийы]\b', '', s)  # lotin so'z oxiriga yopishgan kirill harf (nusxa xatosi)
    for ch in '’ʼʻ‘`´':
        s = s.replace(ch, "'")
    s = s.replace(' ', ' ')
    return re.sub(r'\s+', ' ', s).strip()


def key(s):
    return ' '.join(re.sub(r"[^a-z0-9' ]+", ' ', clean(s).lower()).split())


def main():
    tests = json.load(open(TESTS, encoding='utf-8'))
    prefixes = tuple(c['prefix'] for c in CONFIGS)
    keep = [q for q in tests['questions'] if not q['id'].startswith(prefixes)]
    seen = [(q['id'], key(q['q'])) for q in keep]
    base = max(q['n'] for q in keep)  # test n lari butun bank bo'yicha takrorlanmaydi
    out = list(keep)
    for cfg in CONFIGS:
        src = json.load(open(cfg['src'], encoding='utf-8'))['items']
        added = nokey = dup = 0
        for it in src:
            if it.get('answerIndex') is None:
                nokey += 1
                continue
            q = clean(it['q'])
            opts = [clean(o) for o in it['options']]
            k = key(q)
            if any(abs(len(p) - len(k)) < 30
                   and difflib.SequenceMatcher(None, k, p).ratio() >= 0.9
                   for _, p in seen):
                dup += 1
                continue
            seen.append((f'{cfg["prefix"]}{it["n"]}', k))
            order = list(range(len(opts)))
            # Javob o'rni A ga yig'ilib qolmasin: variantlarni qat'iy urug' bilan
            # aralashtiramiz («hammasi/hech biri» turidagilarni joyida qoldiramiz).
            if not any(FIXED_OPT.search(o) for o in opts):
                random.Random(f'{cfg["prefix"]}{it["n"]}').shuffle(order)
            base += 1
            added += 1
            out.append({
                'id': f'{cfg["prefix"]}{it["n"]:03d}',
                'n': base,
                'q': q,
                'options': [opts[i] for i in order],
                'key': [order.index(it['answerIndex'])],
                'topic': cfg['topic'],
                'verdict': 'ok',
                'checked': CHECKED,
                'source': cfg['source'],
                'bank': cfg['bank'],
                # Tarjimasi yo'q: inglizcha interfeysda ko'rinmaydi (ru uchun rasmiy
                # ruscha fayllar keyin qo'shiladi).
                'langs': ['uz', 'ru'],
            })
        if cfg['topic'] not in tests['topics']:
            tests['topics'].append(cfg['topic'])
        if cfg['topic_names']:
            tests['topic_names'][cfg['topic']] = cfg['topic_names']
        print(f"{cfg['bank']}: qo'shildi {added}, kalitsiz {nokey}, takror {dup}")
    tests['questions'] = out
    json.dump(tests, open(TESTS, 'w', encoding='utf-8'), ensure_ascii=False, indent=1)
    open(TESTS, 'a').write('\n')


if __name__ == '__main__':
    main()
