import sys, re, json, collections
import pymupdf
src, out = sys.argv[1], sys.argv[2]
d = pymupdf.open(src)
lines = []  # (page, x0, x1, y0, text)
for pn, p in enumerate(d):
    for b in p.get_text('dict')['blocks']:
        for l in b.get('lines', []):
            t = ''.join(s['text'] for s in l['spans']).replace(' ', ' ').strip()
            if t: lines.append((pn + 1, l['bbox'][0], l['bbox'][2], l['bbox'][1], t))
xs = sorted(x[2] for x in lines)
margin = xs[int(len(xs) * 0.997)]  # right text margin
numre = re.compile(r'^(\d{1,4})(?:\s*[.)]\s*|\s+)(\S.*)$')
CW = 6.4  # approx char width at 14pt
def fits(x1, nxt):
    w = nxt.split(' ', 1)[0]
    return x1 + 3.5 + CW * len(w) <= margin + 6
logical = []
for i, (pn, x0, x1, y0, t) in enumerate(lines):
    prev = lines[i - 1] if i else None
    if prev is not None and logical and not numre.match(t) and not fits(prev[2], t) and prev[0] == pn and (y0 - prev[3]) < 20 and abs(x0 - prev[1]) < 2:
        logical[-1]['text'] += ' ' + t
    else:
        logical.append({'page': pn, 'text': t})
qs = []; expect = 1; curq = None; stray = []
for L in logical:
    m = numre.match(L['text'])
    if m and int(m.group(1)) == expect:
        curq = {'n': expect, 'stem': m.group(2).strip(), 'options': [], 'page': L['page']}
        qs.append(curq); expect += 1
    elif curq is not None:
        curq['options'].append(L['text'])
    else:
        stray.append(L['text'])
dist = collections.Counter(len(q['options']) for q in qs)
json.dump({'source_file': src.split('/')[-1], 'margin': margin, 'questions': qs}, open(out, 'w'), ensure_ascii=False, indent=0)
print(src.split('/')[-1][:30], 'questions', len(qs), 'option-count dist', dict(sorted(dist.items())), 'stray', stray[:2])
