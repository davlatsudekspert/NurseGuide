# QA hisoboti (rolik tayyorlash)

## Tekshirilgan (avtomatik)
- Subtitr tezligi (belgi/soniya, chegara 17): umumiy rolik {'uz': [], 'ru': [], 'en': []} ; reel {'uz': [], 'ru': [], 'en': []} (bo‘sh ro‘yxat = hammasi chegara ichida).
- Taqiqlangan so‘zlar (toifa, bank, банк): subtitr, tavsif, sahna matnlari va ilova kadrlarining matn manbalari (l10n) bo‘yicha grep — natija QA oxirida.
- Video: ffprobe (o‘lcham, 30 fps, H.264 yuv420p, AAC), ovoz -16 LUFS / -2,4 dBTP (ffmpeg loudnorm).
- Kadrlar ilovaning haqiqiy widget-test ekranlari (test/video_walk), interfeys chizilmagan.

## Ko‘rilgan
- Har format uchun asosiy sahnalardan kadrlar kontakt varag‘i (16:9 va 9:16): yozuv kesilmaganligi, ustma-ustlik.

## Tekshirilmagan (halol)
- Ovoz tinglab ko‘rilmagan (diktorni odam eshitmagan; faqat uzunlik/balandlik o‘lchangan).
- O‘zbekcha va ruscha subtitrlar ona tilida so‘zlashuvchi tomonidan o‘qilmagan (NEEDS_NATIVE_REVIEW).
- Mazmun ekspert (tibbiyot) tomonidan ko‘rilmagan (EXPERT_REVIEW_REQUIRED).
- Video har qurilmada o‘ynatilmagan; Instagram/YouTube yuklash tekshirilmagan.
