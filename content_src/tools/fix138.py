"""Transliterate raw 138 (Cyrillic) to Latin and repair plain-letter confusions (x/h, k/q, g/g', o/o') using
the vocabulary of the Latin banks 141/142 + SSV oral lists as ground truth."""
import json, re, sys, collections, itertools, glob, os
sys.path.insert(0, 'tools')
from uz_translit import cyr_to_lat, normalize_uz_latin
import docx

def toks(s): return re.findall(r"[A-Za-z'][A-Za-z']*", s.lower())
vocab = collections.Counter()
for f in ('content/raw_141.json', 'content/raw_142.json'):
    for q in json.load(open(f))['questions']:
        for t in [q['stem']] + q['options']:
            vocab.update(toks(normalize_uz_latin(t)))
for f in glob.glob('ssv/SSV/14[0-2]-*.docx') + glob.glob('ssv/SSV/138-*.docx'):
    for p in docx.Document(f).paragraphs: vocab.update(toks(normalize_uz_latin(p.text)))
SUBS = [('x', 'h'), ('h', 'x'), ('k', 'q'), ('q', 'k'), ("g'", 'g'), ('g', "g'"), ("o'", 'o'), ('o', "o'"), ('ye', 'e'), ('e', 'ye')]
def variants(w):
    idx = []
    for a, b in SUBS:
        for m in re.finditer(re.escape(a), w):
            idx.append((m.start(), a, b))
    out = {}
    for n in (1, 2):
        for comb in itertools.combinations(idx, n):
            starts = [c[0] for c in comb]
            if any(abs(starts[i] - starts[j]) < 2 for i in range(n) for j in range(i + 1, n)): continue
            s = w
            for st, a, b in sorted(comb, reverse=True): s = s[:st] + b + s[st + len(a):]
            if s in vocab: out[s] = vocab[s]
    return out
BLOCK = {"ro'yxatga", "to'sh", 'xonada', 'xonani', 'yetilishi', 'yetilgan', 'yetishi', 'olim', "o'ladi", "bo'r", 'qayerga'}  # reviewed: variant wrong
def fix_word(w):
    lw = w.lower()
    if lw in BLOCK: return w, None
    if lw in vocab or len(lw) < 4: return w, None
    v = variants(lw)
    if not v: return w, None
    best = max(v, key=lambda x: v[x])
    if v[best] < 2: return w, None
    r = best.capitalize() if w[:1].isupper() and not w.isupper() else (best.upper() if w.isupper() and len(w) > 1 else best)
    return r, best
changes = collections.Counter()
def fix_text(t):
    lat = cyr_to_lat(t)
    def rep(m):
        w2, b = fix_word(m.group(0))
        if b: changes[(m.group(0).lower(), b)] += 1
        return w2
    return re.sub(r"[A-Za-z][A-Za-z']*", rep, lat)
raw = json.load(open('content/raw_138.json'))
qs = raw['questions']
for q in qs:
    q['stem_cyr'] = q['stem']; q['options_cyr'] = list(q['options'])
    q['stem'] = fix_text(q['stem_cyr']); q['options'] = [fix_text(o) for o in q['options_cyr']]
json.dump({'source_file': raw['source_file'], 'questions': qs}, open('content/lat_138.json', 'w'), ensure_ascii=False, indent=0)
open('content/138_autofix_log.tsv', 'w').write('\n'.join(f'{a}\t{b}\t{n}' for (a, b), n in sorted(changes.items(), key=lambda x: -x[1])))
# remaining unknown words (not in vocab) after fixing
unk = collections.Counter()
for q in qs:
    for t in [q['stem']] + q['options']:
        for w in toks(t):
            if w not in vocab and len(w) > 3: unk[w] += 1
open('content/138_unknown_words.txt', 'w').write('\n'.join(f'{w}\t{n}' for w, n in sorted(unk.items())))
print('vocab', len(vocab), 'autofix pairs', len(changes), 'total repl', sum(changes.values()), 'unknown words left', len(unk))
