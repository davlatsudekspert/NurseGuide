"""Og'zaki savol javoblarini (content_src/oral/answers/bNN.json) yig'ib
assets/toifa/oral.json ga qo'shadi. Qayta ishga tushirish xavfsiz: shu
yig'uvchi qo'shgan savollar (id `or-…`) har safar qayta yoziladi.

Ishlatilishi: python3 -I content_src/tools/build_oral.py
"""
import glob
import json
import re

ROOT = 'assets/toifa/oral.json'
ANS = 'content_src/oral/answers/b*.json'
ROWS = 'content_src/oral/rows.json'
HELD = 'content_src/oral/held.json'

CYR = re.compile('[Ѐ-ӿ]')


def main():
    oral = json.load(open(ROOT, encoding='utf-8'))
    rows = {r['id']: r for r in json.load(open(ROWS, encoding='utf-8'))}
    keep = [q for q in oral['questions'] if not q['id'].startswith('or-')]
    # Eski savollarga ham "Adabiyotlar" (manba matnidan).
    for q in keep:
        if 'literature' not in q and q.get('source'):
            q['literature'] = [re.sub(r'^Manba:\s*', '', q['source'])]
    added, held = [], []
    for f in sorted(glob.glob(ANS)):
        for a in json.load(open(f, encoding='utf-8')):
            row = rows[a['id']]
            if a.get('held') or not a.get('plan'):
                held.append({'id': a['id'], 'q': row['q'], 'cat': row['cat'],
                             'held': a.get('held', 'reja yo\'q')})
                continue
            assert a['literature'], a['id']
            assert not CYR.search(json.dumps(a, ensure_ascii=False)), a['id']
            cat = '3-2' if row['cat'] == '2' else row['cat']
            q = {
                'id': a['id'],
                'q': row['q'],
                'categories': [cat],
                'topic': a['topic'] if a['topic'] in oral['topics'] else 'general',
                'plan': a['plan'],
                'literature': a['literature'],
                'source': 'Manba: ' + '; '.join(a['literature']),
            }
            if a.get('note'):
                q['note'] = a['note']
            added.append(q)
    oral['questions'] = keep + added
    json.dump(oral, open(ROOT, 'w', encoding='utf-8'), ensure_ascii=False,
              indent=1)
    open(ROOT, 'a').write('\n')
    json.dump(held, open(HELD, 'w', encoding='utf-8'), ensure_ascii=False,
              indent=1)
    print('qo\'shildi', len(added), 'ushlab turildi', len(held),
          'jami', len(oral['questions']))


if __name__ == '__main__':
    main()
