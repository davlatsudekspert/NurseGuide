"""Agentlar topgan adabiyot javoblarini tekshiradi va qabul qilinganlarini
content_src/literature/accepted.jsonl ga yozadi.

Qabul qilish shartlari:
* iqtibos (quote) keshlangan manba matnida so'zma-so'z mavjud (bo'shliqlar farqi hisobga olinmaydi);
* kalit variantlar doirasida;
* manba NCBI Bookshelf EMAS (bot-himoyani aylanib o'tib olingan — qabul qilinmaydi);
* agent o'zi «zaif» deb belgilagan javoblar (WEAK) chiqarib tashlanadi.

Ishlatilishi: python3 -I content_src/tools/verify_literature.py <out_dir> <cache_dir>
"""
import glob
import json
import re
import sys

WEAK = {
    'ng-h-371', 'ng-h-393', 'ng-h-466', 'ng-p-379', 'ng-h-402', 'ng-o-058',
    'ng-h-412', 'ng-h-368', 'ng-p-196', 'ng-h-324', 'ng-h-309', 'ng-h-223',
    'ng-h-383', 'ng-h-224', 'ng-h-294', 'ng-h-340',
    'ng-p-071', 'ng-h-183', 'ng-h-401', 'ng-h-350', 'ng-h-315', 'ng-h-380',
    'ng-h-008', 'ng-h-447', 'ng-h-104', 'ng-h-394',
    'ng-h-237', 'ng-h-278', 'ng-h-344', 'ng-h-379', 'ng-h-400', 'ng-h-414', 'ng-h-442',
    'ng-h-439', 'ng-p-063',
}


ALLOWED = ('MedlinePlus', 'NLM', 'OpenStax', 'WHO', 'CDC', 'StatPearls', 'NIDDK',
           'National Cancer Institute', 'MSD Manual')


def norm(s):
    return re.sub(r'\s+', ' ', s).strip().lower()


def main(out_dir, cache_dir):
    inputs = {}
    for f in glob.glob(out_dir.replace('/out', '/in') + '/chunk*.json'):
        for x in json.load(open(f, encoding='utf-8')):
            inputs[x['id']] = x
    ok, rej = [], {}
    for f in sorted(glob.glob(out_dir + '/chunk*.jsonl')):
        for line in open(f, encoding='utf-8'):
            if not line.strip():
                continue
            r = json.loads(line)
            if 'key' not in r:
                continue
            i = r['id']
            q = inputs.get(i)
            why = None
            if q is None:
                why = 'no input'
            elif i in WEAK:
                why = 'weak'
            elif not any(a in r.get('source', '') for a in ALLOWED):
                why = 'source not in registry'
            elif 'ncbi.nlm.nih.gov/books' in r.get('url', ''):
                why = 'ncbi-books'
            elif not (0 <= r['key'] < len(q['options'])):
                why = 'key range'
            else:
                try:
                    txt = norm(open(f"{cache_dir}/{r['cache']}", encoding='utf-8', errors='ignore').read())
                except OSError:
                    txt = ''
                if norm(r['quote']) not in txt:
                    why = 'quote not in cache'
            if why:
                rej[i] = why
                continue
            ok.append({**r, 'q': q['q'], 'options': q['options'], 'bank': q['bank']})
    with open('content_src/literature/accepted.jsonl', 'w', encoding='utf-8') as w:
        for r in ok:
            w.write(json.dumps(r, ensure_ascii=False) + '\n')
    import collections
    print('accepted', len(ok), 'rejected', collections.Counter(rej.values()))


if __name__ == '__main__':
    main(sys.argv[1], sys.argv[2])
