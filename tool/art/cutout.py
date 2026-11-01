"""Oq fonli rasmdan shaffof PNG: python3 tool/art/cutout.py <kirish.png> <chiqish.png>
Chekkadan boshlab oq/och-kulrang fon olib tashlanadi; fondagi yumshoq soya — yarim shaffof qora soya bo'lib qoladi."""
import sys
from collections import deque
import numpy as np
from PIL import Image, ImageFilter

src, dst = sys.argv[1], sys.argv[2]
a = np.array(Image.open(src).convert('RGB')).astype(int)
H, W, _ = a.shape
mn, sat = a.min(2), a.max(2) - a.min(2)
cand = (mn >= 175) & (sat <= 18)  # fon yoki fon soyasi
mask = np.zeros((H, W), bool)
q = deque()
for x in range(W):
    for y in (0, H - 1):
        if cand[y, x]: mask[y, x] = True; q.append((y, x))
for y in range(H):
    for x in (0, W - 1):
        if cand[y, x] and not mask[y, x]: mask[y, x] = True; q.append((y, x))
while q:
    y, x = q.popleft()
    for dy, dx in ((1, 0), (-1, 0), (0, 1), (0, -1)):
        ny, nx = y + dy, x + dx
        if 0 <= ny < H and 0 <= nx < W and cand[ny, nx] and not mask[ny, nx]:
            mask[ny, nx] = True; q.append((ny, nx))
# Yopiq ichki "teshiklar" (masalan, halqa ichidagi oq fon): katta sof-oq bo'laklar
pure = (mn >= 244) & (sat <= 8) & ~mask
seen = np.zeros((H, W), bool)
for sy in range(0, H, 2):
    for sx in range(0, W, 2):
        if not pure[sy, sx] or seen[sy, sx]:
            continue
        comp, q = [], deque([(sy, sx)])
        seen[sy, sx] = True
        while q:
            y, x = q.popleft(); comp.append((y, x))
            for dy, dx in ((1, 0), (-1, 0), (0, 1), (0, -1)):
                ny, nx = y + dy, x + dx
                if 0 <= ny < H and 0 <= nx < W and pure[ny, nx] and not seen[ny, nx]:
                    seen[ny, nx] = True; q.append((ny, nx))
        if len(comp) > 4000:
            for y, x in comp: mask[y, x] = True
alpha = np.full((H, W), 255, np.uint8)
# fon: shaffof; soya: qora, alpha = qorayish miqdori
shade = np.clip((255 - mn) / 255.0 * 1.35, 0, 1)
alpha[mask] = (np.where(shade[mask] < 0.06, 0, shade[mask]) * 255).astype(np.uint8)
rgb = a.astype(np.uint8)
rgb[mask] = 0
# obyekt chekkasini yumshatish
obj = (~mask).astype(np.uint8) * 255
soft = np.array(Image.fromarray(obj).filter(ImageFilter.GaussianBlur(0.9)))
alpha = np.where(~mask, np.where(soft < 110, 0, soft), alpha).astype(np.uint8)
Image.fromarray(np.dstack([rgb, alpha]), 'RGBA').save(dst)
print('tayyor', dst, 'fon ulushi', round(mask.mean(), 3))
