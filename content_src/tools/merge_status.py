"""Merge all batch results into content/question_status.json (latest result per id wins; re-source results override batch1)."""
import json, glob, os
qs = {}
for f in sorted(glob.glob('content/batch*_questions.json')):
    for q in json.load(open(f)): qs[q['id']] = q
res = {}
def load_jsonl(p):
    return [json.loads(l) for l in open(p) if l.strip()] if os.path.exists(p) else []
for r in json.load(open('content/batch1_final.json')): res[r['id']] = r
for p in ('content/batch1_resource_results.jsonl', 'content/batch2_results.jsonl', 'content/batch3_results.jsonl'):
    for r in load_jsonl(p): res[r['id']] = {**res.get(r['id'], {}), **r}
if os.path.exists('content/expert_results.json'):
    for r in json.load(open('content/expert_results.json')): res[r['id']] = {**res.get(r['id'], {}), **r}
out = []
for i, q in qs.items():
    r = res.get(i)
    out.append({'id': i, 'bank': q['bank'], 'n': q['n'], 'q': q['q'], 'options': (r or {}).get('options') or q['options'],
                'status': (r or {}).get('status', 'pending'), **{k: v for k, v in (r or {}).items() if k not in ('id', 'options', 'status')}})
json.dump(out, open('content/question_status.json', 'w'), ensure_ascii=False, indent=0)
import collections
print(collections.Counter(o['status'] for o in out))
