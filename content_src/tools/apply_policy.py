"""Final status assignment per the user's key policy (2026-10-18, A1-A4). Writes content/final_status.json + prints a summary."""
import json, glob, os, collections, sys
THR = 0.90
def jl(p): return [json.loads(l) for l in open(p) if l.strip()] if os.path.exists(p) else []
subprocess_ok = os.system('python3 -I tools/merge_status.py > /dev/null') == 0
S = {s['id']: s for s in json.load(open('content/question_status.json'))}
CODE = {'141': 'h', '142': 'p', '138': 'o'}
banks = {b: json.load(open(f'content/bank_{b}.json')) for b in CODE}
fk = json.load(open('content/file_keys.json'))
sample = {r['id']: r for r in jl('content/sample_keycheck_results.jsonl') + jl('content/sample141_results.jsonl')}
conf = {r['id']: r for r in jl('content/conflict142_results.jsonl')}
for _p in sorted(glob.glob('content/tranche*_results.jsonl')):
    for _r in jl(_p): conf[_r['id']] = _r
sample_q = {q['id']: q for q in json.load(open('content/sample_keycheck_questions.json')) + json.load(open('content/sample141_questions.json'))}
def rate(bank, pred=lambda q: True):
    c = d = 0
    for i, r in sample.items():
        q = sample_q[i]
        if q['bank'] != bank or not pred(q): continue
        if r['verdict'] == 'confirms': c += 1
        elif r['verdict'] == 'contradicts': d += 1
    return c, d, (c / (c + d) if c + d else None)
r141 = rate('141'); ok141 = r141[2] is not None and r141[2] >= THR
r138 = rate('138'); r142_all = rate('142'); r142_both = rate('142', lambda q: q.get('old_yellow_key') is not None and q['old_yellow_key'] == q['file_key'])
ok138 = r138[2] is not None and r138[2] >= THR
ok142 = r142_both[2] is not None and r142_both[2] >= THR
print('sample agreement 141:', r141, 'ok' if ok141 else 'NOT ok'); print('sample agreement 138:', r138, 'ok' if ok138 else 'NOT ok'); print('sample 142 all:', r142_all, ' both-files-agree subset:', r142_both, 'ok' if ok142 else 'NOT ok')
out = []
for b, rows in banks.items():
    for r in rows:
        i = f"ng-{CODE[b]}-{r['n']:03d}"; s = S.get(i, {})
        rec = {'id': i, 'bank': b, 'n': r['n'], 'q': r['q'], 'options': s.get('options') or r['options'], 'status': s.get('status', 'pending'),
               'key': s.get('key'), 'key_candidate': s.get('key_candidate'), 'source': s.get('source'), 'source_ref': s.get('source_ref'),
               'explanation_uz': s.get('explanation_uz'), 'notes': s.get('notes', ''), 'priority': i in S}
        f = fk.get(b, {}).get(str(r['n']))
        fkey = f['key'] if f else None
        if b == '142' and f: both = f.get('old_yellow') is not None and f['old_yellow'] == f['key']
        else: both = None
        sm, cf = sample.get(i), conf.get(i)
        # 1) source results from sample / conflict checks override file-only reasoning
        for src in (sm, cf):
            if src and src['verdict'] in ('confirms', 'contradicts') if src and 'verdict' in src else False:
                if src['verdict'] == 'confirms': rec.update(status='verified', key=fkey if fkey is not None else src.get('correct_key'), source=src['source'], source_ref=src.get('source_ref'), explanation_uz=src.get('explanation_uz'))
                else: rec.update(status='disputed', key=None, key_candidate=src.get('correct_key'), notes=(rec['notes'] + ' | fayl kaliti manbaga zid: ' + str(fkey)).strip(), file_key=fkey)
        if cf and cf.get('status') in ('verified', 'disputed', 'no_source'):
            rec.update({k: cf.get(k, rec.get(k)) for k in ('status', 'key', 'source', 'source_ref', 'explanation_uz', 'notes')})
        # 2) file-key policy
        if rec['status'] == 'verified' and fkey is not None and rec['key'] != fkey and rec['key'] is not None and i not in conf:
            rec.update(status='disputed', key_candidate=rec['key'], key=None, file_key=fkey, notes=(rec['notes'] + ' | fayl kaliti manba kaliti bilan farq qiladi').strip())
        elif rec['status'] in ('no_source', 'pending') and fkey is not None:
            cand = rec.get('key_candidate')
            pol = (b == '138' and ok138) or (b == '141' and ok141) or (b == '142' and ok142 and both)
            if cand is not None and cand != fkey: rec.update(status='disputed', file_key=fkey, notes=(rec['notes'] + ' | nomzod va fayl kaliti farq qiladi').strip())
            elif pol: rec.update(status='official', key=fkey, source='Fayl kaliti (' + f['src'] + ')', file_key=fkey)
            else: rec.update(status='no_source', key_candidate=fkey, file_key=fkey)
        elif rec['status'] == 'pending': rec['status'] = 'no_source'
        out.append(rec)
json.dump(out, open('content/final_status.json', 'w'), ensure_ascii=False, indent=0)
for b in CODE:
    c = collections.Counter(r['status'] for r in out if r['bank'] == b); print(b, len(banks[b]), dict(c), 'app-ready', c['official'] + c['verified'] + c['expert'])
