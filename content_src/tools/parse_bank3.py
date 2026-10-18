import sys, re, json, collections
import pymupdf
src, out = sys.argv[1], sys.argv[2]
d = pymupdf.open(src)
def clean(t): return re.sub(r'\s+', ' ', t).strip()
blocks = []; cur = []; expect = 1
numre = re.compile(r'^(\d{1,4})\s*[.)]?\s+(\S.*)$')
for pn, p in enumerate(d):
    for b in p.get_text('dict')['blocks']:
        for l in b.get('lines', []):
            t = clean(''.join(s['text'] for s in l['spans']).replace(' ', ' '))
            if not t:
                if cur: blocks.append(cur); cur = []
                continue
            m = numre.match(t)
            if m and int(m.group(1)) == expect:
                if cur: blocks.append(cur)
                cur = []; expect += 1
            cur.append({'t': t, 'x1': l['bbox'][2], 'page': pn + 1})
if cur: blocks.append(cur)
margin = sorted(x['x1'] for bl in blocks for x in bl)[int(0.997 * sum(len(b) for b in blocks))]
qs = []; stats = collections.Counter()
for bl in blocks:
    m = numre.match(bl[0]['t'])
    if not m: continue  # title block
    n = int(m.group(1)); lines = [dict(x) for x in bl]; lines[0]['t'] = m.group(2)
    k = len(lines); flag = ''
    if k == 5: groups = [[i] for i in range(5)]
    elif k > 5:
        gaps = sorted(range(k - 1), key=lambda i: (-lines[i]['x1'], lines[i + 1]['t'][:1].isupper()))[:k - 5]
        merge = set(gaps); groups = []; g = [0]
        for i in range(1, k):
            if (i - 1) in merge: g.append(i)
            else: groups.append(g); g = [i]
        groups.append(g); flag = 'merge_guess'
    else:
        groups = [[i] for i in range(k)]; flag = 'few_lines'
    parts = [clean(' '.join(lines[i]['t'] for i in g)) for g in groups]
    qs.append({'n': n, 'stem': parts[0], 'options': parts[1:], 'page': lines[0]['page'], 'parse_flag': flag})
    stats[flag or 'clean'] += 1
nums = [q['n'] for q in qs]
json.dump({'source_file': src.split('/')[-1], 'questions': qs}, open(out, 'w'), ensure_ascii=False, indent=0)
print(src.split('/')[-1][:30], 'questions', len(qs), 'seq-ok', nums == list(range(1, len(qs) + 1)), dict(stats))
