"""content_src/literature/accepted.jsonl dagi (adabiyot bilan isbotlangan) javoblarni
assets/toifa/tests.json ga qo'shadi. Savollar — rasmiy ro'yxatdan (id: ng-h-/ng-o-/ng-p-),
avval kalitsiz bo'lgani uchun bankda yo'q edi. Qayta ishga tushirish xavfsiz.

Ishlatilishi: python3 -I content_src/tools/ingest_literature.py
"""
import difflib
import json
import re

TESTS = 'assets/toifa/tests.json'
ACC = 'content_src/literature/accepted.jsonl'
BANK = {'141': 'hamshiralik', '138': 'oliy_hamshiralik', '142': 'patronaj'}
CHECKED = '2026-10-24'


HOMO = {'А': 'A', 'а': 'a', 'В': 'B', 'Е': 'E', 'е': 'e', 'К': 'K', 'М': 'M', 'Н': 'H',
        'О': 'O', 'о': 'o', 'Р': 'P', 'р': 'p', 'С': 'C', 'с': 'c', 'Т': 'T', 'Х': 'X', 'х': 'x'}


def clean(s):
    """Lotin matnga adashib tushgan kirill harflar: o'xshashi almashtiriladi, boshqasi olib tashlanadi."""
    return re.sub('[Ѐ-ӿ]', lambda m: HOMO.get(m.group(0), ''), s)


def key(s):
    s = s.lower().replace('’', "'").replace('ʻ', "'").replace('‘', "'").replace('`', "'")
    return ' '.join(re.sub(r"[^a-z0-9' ]+", ' ', s).split())


def similar(a, b, thr=0.9):
    sm = difflib.SequenceMatcher(None, a, b)
    return (sm.real_quick_ratio() >= thr and sm.quick_ratio() >= thr
            and sm.ratio() >= thr)


def main():
    tests = json.load(open(TESTS, encoding='utf-8'))
    by_id = {q['id']: q for q in tests['questions']}
    base = max(q['n'] for q in tests['questions'])
    added = dup = 0
    seen = [key(q['q']) for q in tests['questions']]
    for line in open(ACC, encoding='utf-8'):
        if not line.strip():
            continue
        r = json.loads(line)
        if r['id'] in by_id:
            continue
        k = key(r['q'])
        if any(abs(len(p) - len(k)) < 30 and similar(k, p) for p in seen):
            dup += 1  # bankda allaqachon (kalitli) bor
            continue
        seen.append(k)
        base += 1
        added += 1
        tests['questions'].append({
            'id': r['id'],
            'n': base,
            'q': clean(r['q']),
            'options': [clean(o) for o in r['options']],
            'key': [r['key']],
            'topic': 'general',
            'verdict': 'ok',
            'checked': CHECKED,
            'status': 'verified',
            'source': f"Manba: {r['source']} ({r['url']})",
            'explanation': r['uz'],
            'bank': BANK.get(r['bank'], r['bank']),
        })
    json.dump(tests, open(TESTS, 'w', encoding='utf-8'), ensure_ascii=False, indent=1)
    open(TESTS, 'a').write('\n')
    print('qo\'shildi', added, 'takror', dup, 'jami', len(tests['questions']))


if __name__ == '__main__':
    main()
