import sys, re, json, collections
import pymupdf
src, out = sys.argv[1], sys.argv[2]
d = pymupdf.open(src)
qs = []; expect = 1; cur = None; opt = None; stray = []
def clean(t): return re.sub(r'\s+', ' ', t).strip()
for pn, p in enumerate(d):
    for b in p.get_text('dict')['blocks']:
        for l in b.get('lines', []):
            raw = ''.join(s['text'] for s in l['spans']).replace(' ', ' ')
            t = clean(raw); x0 = l['bbox'][0]
            if x0 < 110 and re.fullmatch(r'\d{1,4}', t) and int(t) == expect:
                cur = {'n': expect, 'stem': '', 'options': [], 'page': pn + 1}; qs.append(cur); expect += 1; opt = None; continue
            mi = re.match(r'^(\d{1,4})\s+(\S.*)$', t)
            if x0 < 110 and mi and int(mi.group(1)) == expect:
                cur = {'n': expect, 'stem': mi.group(2), 'options': [], 'page': pn + 1}; qs.append(cur); expect += 1; opt = None; continue
            if cur is None:
                if t: stray.append(t)
                continue
            if x0 < 110 and t == '':
                if cur['stem']: cur['options'].append(''); opt = len(cur['options']) - 1  # option bullet marker
                continue
            if not t: continue
            if opt is None: cur['stem'] = clean(cur['stem'] + ' ' + t)
            else: cur['options'][opt] = clean(cur['options'][opt] + ' ' + t)
for q in qs: q['options'] = [o for o in q['options'] if o]
dist = collections.Counter(len(q['options']) for q in qs)
json.dump({'source_file': src.split('/')[-1], 'questions': qs}, open(out, 'w'), ensure_ascii=False, indent=0)
print(src.split('/')[-1][:30], 'questions', len(qs), 'option-count dist', dict(sorted(dist.items())), 'stray', stray[:3])
