import json, re, collections, sys
sys.path.insert(0, 'tools')
from topics import topics_of
fs = json.load(open('content/final_status.json'))
BANKNAME = {'141': 'hamshiralik', '138': 'oliy_hamshiralik', '142': 'patronaj'}
OFFICIAL_SRC = "Manba: Sog'liqni saqlash vazirligi test savollar bazasi (TMBM, tmbm.ssv.uz); kalit — tayyorgarlik fayli bo'yicha, manbalar bilan tanlab tekshirilgan"
def norm(s): return re.sub(r'[^a-z0-9]+', ' ', s.lower().replace("'", '')).strip()
def sig(r): return norm(r['q']) + '||' + '|'.join(sorted(norm(o) for o in r['options']))
ready = [r for r in fs if r['status'] in ('official', 'verified')]
ready.sort(key=lambda r: (0 if r['status'] == 'verified' else 1, r['bank'], r['n']))   # prefer verified copies
seen = {}; out = []; dups = []
TOPIC_UZ = {'infection_control': 'Infeksion nazorat', 'patronage': 'Patronaj', 'iv_access': "Tomir ichiga va infuziya", 'injection': 'Inyeksiyalar', 'vital_signs': "Hayotiy ko'rsatkichlar", 'general': 'Umumiy hamshiralik ishi'}
for r in ready:
    k = sig(r)
    if k in seen:
        seen[k]['also_in'].append({'bank': BANKNAME[r['bank']], 'n': r['n']}); dups.append(r['id']); continue
    ts = topics_of(r) or ['general']
    q = {'id': r['id'], 'n': r['n'], 'bank': BANKNAME[r['bank']], 'q': r['q'], 'options': r['options'], 'key': [r['key']], 'topic': ts[0],
         'status': r['status'], 'source': r['source'] if r['status'] == 'verified' else OFFICIAL_SRC,
         'source_ref': r.get('source_ref'), 'explanation': (r.get('explanation_uz') or '') if r['status'] == 'verified' else '', 'also_in': []}
    seen[k] = q; out.append(q)
out.sort(key=lambda q: (q['bank'], q['n']))
doc = {'version': 1, 'topics': TOPIC_UZ, 'questions': out}
json.dump(doc, open('content/final/nurse_tests.json', 'w'), ensure_ascii=False, indent=1)
c = collections.Counter(q['bank'] for q in out); st = collections.Counter(q['status'] for q in out)
print('questions after de-dup', len(out), 'removed duplicates', len(dups), dict(c), dict(st))
T = json.load(open('content/tickets_final.json'))
tk = {'version': 1, 'categories': {'2': 'Ikkinchi toifa', '1': 'Birinchi toifa', 'oliy': 'Oliy toifa'}, 'tickets': []}
for key, t in T.items():
    tk['tickets'].append({'id': f"bl-h-{t['cat']}-{t['number']:02d}", 'cat': t['cat'], 'number': t['number'], 'items': [
        {'id': it['id'], 'q': it['question'], 'points': it['points'], 'source': it['source'], 'source_ref': it['source_ref'], 'review': 'needs_review', 'flags': it['flags']} for it in t['items']]})
json.dump(tk, open('content/final/tickets_hamshiralik.json', 'w'), ensure_ascii=False, indent=1)
print('tickets', len(tk['tickets']), 'items', sum(len(t['items']) for t in tk['tickets']))
