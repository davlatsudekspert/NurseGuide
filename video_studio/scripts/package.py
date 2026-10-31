"""ZIP bo'laklari (har biri < 450 MB, oraliq nusxasiz): python3 scripts/package.py"""
import os, zipfile, hashlib, glob, shutil
OUT = 'out'; Z = 'out/zip'; D = '../docs/video'
os.makedirs(Z, exist_ok=True)
for f in glob.glob(f'{Z}/*'): os.remove(f)
def add(zf, path, arc):
    zf.write(path, arc, compress_type=zipfile.ZIP_STORED)
def pack(name, items, docs):
    p = f'{Z}/{name}.zip'
    with zipfile.ZipFile(p, 'w') as zf:
        for path in items: add(zf, path, os.path.basename(path))
        for path, arc in docs: add(zf, path, arc)
        add(zf, 'scripts/YORDAMCHI_JOYLASH.md', 'YORDAMCHI_JOYLASH.md')
    mb = os.path.getsize(p) / 1e6
    assert mb < 450, (name, mb)
    print(f'{name}.zip  {mb:.1f} MB')
    return p
ov_docs = [(f'{D}/overview/DESCRIPTION.md', 'docs/overview/DESCRIPTION.md'), (f'{D}/overview/CLAIMS_AND_EVIDENCE.md', 'docs/overview/CLAIMS_AND_EVIDENCE.md'), (f'{D}/QA.md', 'docs/QA.md')]
rl_docs = [(f'{D}/reel/DESCRIPTION.md', 'docs/reel/DESCRIPTION.md'), (f'{D}/reel/CLAIMS_AND_EVIDENCE.md', 'docs/reel/CLAIMS_AND_EVIDENCE.md'), (f'{D}/QA.md', 'docs/QA.md')]
g = lambda pat: sorted(glob.glob(f'{OUT}/{pat}'))
pack('NurseGuide_YOUTUBE_FINAL_PART1', g('overview-16x9-*'), ov_docs)
pack('NurseGuide_INSTAGRAM_FINAL_PART1', g('overview-9x16-*') + g('reel-9x16-*'), ov_docs + rl_docs[:2])
pack('NurseGuide_UMUMIY_ROLIK', g('overview-*'), ov_docs)
pack('NurseGuide_REEL', g('reel-*'), rl_docs)
sums = []
for z in sorted(glob.glob(f'{Z}/*.zip')):
    h = hashlib.sha256(open(z, 'rb').read()).hexdigest(); sums.append(f'{h}  {os.path.basename(z)}')
open(f'{Z}/SHA256SUMS.txt', 'w').write('\n'.join(sums) + '\n')
