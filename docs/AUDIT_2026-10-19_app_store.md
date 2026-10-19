# NurseGuide — do‘konga yuborishdan oldingi to‘liq audit (2026-10-19)

**Usul.** 3 qatlam: (1) avtomatik aylanish — 12 konfiguratsiya (uz/ru/en × yorug‘/qorong‘i × iPhone 390×844 /
Android 360×640 shrift 1.3x) × ~70 yo‘nalish: istisno/overflow, “0 ta”, va’da-so‘z, xom kalit, kirill/o‘zbekcha
aralashma (`test/audit/audit_sweep_test.dart`); (2) **Auditor A** — matn, tarjima, siyosat, Apple talablari (ARB, assetlar,
sayt, do‘kon matnlari); (3) **Auditor B** — haqiqiy ekran rasmlarini ko‘zdan kechirish (87 rasm; B 87 tadan ~60 tasini ko‘ra
oldi — qolgan ekranlar uchun avtomatik aylanish va men tomondan tekshiruv ishlatildi).

**Natija (avtomatik aylanish).** Hech bir konfiguratsiyada istisno/overflow yo‘q; “tez orada/keyingi yangilanish” yo‘q;
xom kalit yo‘q. Topilgan yagona “0 ta” — `/learn/exam` (bo‘sh kontent paketi) — bo‘lim yashirildi.

## Jadval

| № | Ekran / joy | Muammo | Og‘irligi | Holat |
|---|---|---|---|---|
| 1 | Profil → Maxfiylik → Shartlar qatori | “Yakuniy matn tayyorlanadi” (qoralama ohangi) | Yuqori | Tuzatildi (matn + ilovada saytdagi to‘liq shartlarga havola) |
| 2 | Savollar (kunlik, mashq, test tahlili, guruh testi) | Har savolning o‘z manbasi/izohi ko‘rsatilmasdi (faqat umumiy “Rasmiy ro‘yxat”) | Yuqori | Tuzatildi: har javob ostida savolning “Manba:” qatori va (bor bo‘lsa) izoh |
| 3 | O‘rganish: Izohli test, Imtihon, Ma’ruza, bosh sahifa kartalari | Bo‘sh kontent paketi: “0 savol”, ochilmaydigan bo‘limlar | Yuqori | Tuzatildi: bo‘sh bo‘limlar yashirin (kod qoldi); talaba/ustoz bosh sahifa kartalari almashtirildi |
| 4 | Toifa bo‘limi ingliz/rus interfeysida | Faqat UZ foydalanuvchiga ochiq edi — boshqa mamlakatdagi tekshiruvchi bo‘sh “O‘rganish”ni ko‘rardi | Yuqori | Tuzatildi: hamma tilda ochiq (“Rasmiy matn — o‘zbekcha” belgisi bilan); kunlik savollar hamma rolga |
| 5 | Maxfiylik / Info.plist | “Foto kutubxona o‘qilmaydi” va ilovadagi “skrinshot biriktirish”; kamera matni | Yuqori | Tuzatildi: biriktirish serverda yo‘q va yashirin, Info.plist matni aniqlashtirildi |
| 6 | Og‘zaki javoblar (bilet) | 4 ta reja xavfli/eskirgan: cho‘kish, spirt surrogati (tuzli suv bilan qusdirish), yot jism, it tishlashi | Yuqori | Yashirildi (4 bilet ham chiqmaydi); **ochiq:** mutaxassis yangilaguncha qaytmaydi |
| 7 | Test ng-o-143 (xlorgeksidin) | Rasmiy kalit tibbiy jihatdan shubhali | O‘rta | Testdan chiqarildi (held) |
| 8 | Manipulyatsiya “Me’dani yuvish” | Darslik “kislotadan zaharlanishda yuvish shart” deydi (eskirgan) | O‘rta | Yashirildi; **ochiq:** toksikolog ko‘rigi |
| 9 | Manipulyatsiyalar: kateterlash, vena/mushak ichiga, teri ichiga | Eskirgan amaliyot (qaynatiladigan kateter, simobli antiseptik, sterillanadigan shpris, igna kesim burchagi 40–45°, Mantu 24–48 soat) | O‘rta | Tuzatildi (bir martalik steril shpris/kateter, Mantu 72 soat); ochiq qismi `docs/PROCEDURES_REVIEW.md` da |
| 10 | Manipulyatsiyalar (en/ru) | Nomlar, bo‘lim sarlavhalari, kategoriyalar o‘zbekcha — chala tarjima | Yuqori | Tuzatildi: 10 manipulyatsiya × uz/ru/en nomi, 4 bo‘lim; ruscha: 169 qadam, maqsad, jihoz, tekshiruv, xavflar; inglizcha: o‘zbekcha qadam + bitta qisqa eslatma |
| 11 | Manipulyatsiya eslatmalari | Ikkita yashil eslatma | Past | Tuzatildi: bitta qisqa qator |
| 12 | Manba qatori (ru/en) | “стр. 2007, 304” — yil bet raqami bo‘lib qolgan | Yuqori | Tuzatildi + test |
| 13 | Adabiyot sahifasi, DMED chiplari (ru/en) | Manipulyatsiya nomlari, mavzu nomlari, DMED guruhlari o‘zbekcha | O‘rta | Tuzatildi |
| 14 | Pastki menyu (ru) | “Рабочее место” kesilgan | Yuqori | Tuzatildi: “Работа” |
| 15 | Shartlar / Maxfiylik / Sayt | Hisob talablari, server joyi, og‘zaki baholar, kirish usullari bir-biriga zid | O‘rta | Tuzatildi (ilova + sayt, 3 til) |
| 16 | Sayt: bosh sahifa, /j/ | “Qisqa o‘quv materiallari”, noto‘g‘ri yo‘l nomi | O‘rta | Tuzatildi |
| 17 | Ilova va sayt matni | “Manipulyatsiya/Muolaja” aralash; “Domla/Ustoz”; “build”; ASCII apostrof; “Ivory”; “Rivojlanish”; “O‘quvchi” | Past | Tuzatildi |
| 18 | Shikoyat/aloqa | “24 soat ichida” va “muddat va’da qilinmaydi” zid | O‘rta | Tuzatildi |
| 19 | Admin | “Sotuvlar: 0 (hozircha to‘lov yo‘q)” | Past | Olib tashlandi |
| 20 | Test: 3 ta “tasdiqlangan” savol manbasi mavzuga mos emas | Manba haqiqatga to‘g‘ri kelmasdi | Past | Tuzatildi: umumiy rasmiy manba, izoh olib tashlandi |
| 21 | Do‘kon matni | Haqiqatga mos kelmagan da’volar; kalit so‘zlar chegarada | O‘rta | Tuzatildi |
| 22 | Email bilan kirish (TestFlight, telefonda) | “Nimadir xato ketdi” — Resend noto‘g‘ri jo‘natuvchi manzilni rad etgan | Yuqori | Tuzatildi va deploy qilindi (server `sent` qaytaradi); diagnostika qo‘shildi |
| 23 | Google bilan kirish (iOS) | `invalid_client` — iOS OAuth klient | Yuqori | Klient/Team ID tuzatildi, tugma yoqildi; **telefonda tekshirish kerak** |
| 24 | Pulsning me’yori (Ish joyi) | 60–80 (Inomov 2007); hozirgi tavsiya 60–100 | Past | **Ochiq** (mutaxassis) |
| 25 | Sayt shartlari | Aniq litsenziya bandi yo‘q | Past | **Ochiq** |
| 26 | Bir qancha past darajali tavsiyalar (yangi foydalanuvchiga 0% ko‘rsatkichlar, ikki yashil eslatma boshqa sahifalarda, uz apostroflar, Android 1.3x siqiq sarlavha) | Dizayn/ohang | Past | **Ochiq** (yuborishga to‘sqinlik qilmaydi) |
| 27 | “Guruhlar” sahifasi (audit rasmida “sessiya tugagan”) | Sinov muhiti artefakti: real sessiyada kuzatilmaydi | — | Artefakt (to‘g‘ridan marshrutga o‘tilgan), yopildi |

## Qo‘yilgan qorovul testlar
`no_unfinished_wording_guard_test` (ARB + assetlarda va’da-so‘z), `procedure_i18n_guard_test` (nom/sarlavha/ruscha qadam),
`oral_literature_guard_test` (javob → adabiyotlar, kirill, doza), `hidden_unfinished_test` (bo‘sh bo‘limlar yashirin, javobsiz og‘zaki
savol yo‘q), `qa_sweep_test` ("0 ta" tekshiruvi), `literature_guard_test` (DMED manbalari), `toifa_scope_test`,
`test/audit/*` (qo‘lda ishga tushiriladigan to‘liq aylanish) va `tool/store/check_listing.py` (do‘kon matni/rasm o‘lchamlari).

## Ochiq (mutaxassis uchun)
Oltita tibbiy band ochiq: 4 ta yashirin og‘zaki reja (cho‘kish, spirt surrogati, yot jism, it tishlashi) yangidan yoziladi;
me’dani yuvish va kateterlash qo‘llanmalari ko‘rib chiqiladi; puls me’yori; ng-o-143 kaliti. Ularning hammasi ilovada **ko‘rinmaydi**
yoki muassasa ko‘rsatmasi bilan solishtirish eslatmasi bilan beriladi.
