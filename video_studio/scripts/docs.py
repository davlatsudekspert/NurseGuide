"""content.ts + timings.json dan docs/video/{overview,reel}/ hujjatlarini yasaydi (SCRIPT, CLAIMS, QA, DESCRIPTION, lines.*.json)."""
import json, re, os, subprocess

src = open('src/content.ts', encoding='utf-8').read()
def grab(name):
    body = src.split(f'export const {name}: Scene[] = [')[1].split('\n];')[0]
    body = re.sub(r"//[^\n]*", "", body)
    # JS obyektlarini JSON ga: oddiy kalitlar va ' -> "
    node = "const x=[" + body + "\n];console.log(JSON.stringify(x))"
    return json.loads(subprocess.check_output(['node', '-e', node], text=True))
OV, REEL = grab('OVERVIEW'), grab('REEL')
T = json.load(open('public/audio/timings.json'))
ov_d = [T[s['id']]['dur'] for s in OV]
reel_d = [s['min'] for s in REEL]

EVID = {
 'hook': ('Savol shaklidagi hook; da’vo yo‘q.', '—'),
 'intro': ('NurseGuide — hamshiralar va o‘rta tibbiyot xodimlari uchun o‘quv ilovasi.', 'docs/store/APP_STORE_LISTING.md (tavsif); kadr 01_home (“Hamshiralar uchun”)'),
 'daily': ('Har kuni 5 ta savol; javobdan keyin izoh va manba.', 'Bosh sahifa kartasi “Bugungi 5 ta savol … javobdan keyin izoh va manba” (l10n homeDailyBody); lib/features/daily; kadr 11_daily'),
 'hub': ('Bo‘limda testlar, og‘zaki biletlar va xatolar ustida ishlash bor.', 'l10n toifaTitle/toifaEntryBody; lib/features/toifa; kadr 02_hub'),
 'test': ('Imtihon rejimida vaqt bor; mashq rejimida javob darhol ko‘rinadi; yo‘nalish tanlanadi.', 'Ekran 03_test_setup: “Imtihon rejimi — Vaqt bilan; ball va xatolar oxirida”, “Mashq rejimi — xato darhol ko‘rinadi”, yo‘nalish chiplari; l10n toifaMode*'),
 'oral': ('Og‘zaki bilet tortiladi, javob rejasi bilan o‘zini tekshiradi.', 'Ekran 06_oral_plan (“Og‘zaki bilet”, “Javob rejasi”); lib/features/toifa; reja “NurseGuide tayyorlagan” deb belgilangan'),
 'procedures': ('Manipulyatsiyalar bosqichma-bosqich, manba bilan.', 'Ekran 07_procedure (“Ko‘rsatmalar”, “Ma’lumot darslik asosida tayyorlangan…”); assets/content procedures'),
 'workplace': ('Yo‘nalishlar: hamshiralik, akusherlik, patronaj, rentgen laborant (va boshqalar).', 'Ekran 08_workplace (yo‘nalish chiplari); lib/features/hub/hub_screens.dart'),
 'groups': ('Ustoz guruh ochadi, topshiriq beradi, natijalarni ko‘radi.', 'Ekran 10_group_results (Test QR/Katta ekran, natijalar jadvali); lib/features/classroom, learn/classes_screens.dart'),
 'sources': ('Har bir ma’lumot qayerdan olingani ko‘rsatiladi.', 'Ekran 09_sources (“Adabiyotlar”, litsenziya va havola); assets/content/reference/literature.json'),
 'languages': ('Interfeys uch tilda: o‘zbekcha, ruscha, inglizcha.', 'lib/l10n/app_uz|ru|en.arb; Profil → Til; kadrlar 01_home (uz/ru/en)'),
 'end': ('“Tez kunda”; do‘kon, narx va sana yo‘q.', '—'),
}
def srt_cps(scenes, durs, lang):
    bad = []
    for s, d in zip(scenes, durs):
        if s.get('end'): continue
        cps = len(s['line'][lang]) / max(0.1, d - 0.3)
        if cps > 17: bad.append((s['id'], round(cps, 1)))
    return bad

def write(path, text): 
    os.makedirs(os.path.dirname(path), exist_ok=True)
    open(path, 'w', encoding='utf-8').write(text)

def chapters(scenes, durs, lang):
    t = 0; out = []
    for s, d in zip(scenes, durs):
        out.append(f"{int(t//60):02d}:{int(t%60):02d} {s['title'][lang]}")
        t += d
    return out

# ---------- OVERVIEW ----------
base = '../docs/video/overview'
for lang in ('en', 'ru', 'uz'):
    write(f'{base}/lines.{lang}.json', json.dumps({s['id']: s['line'][lang] for s in OV}, ensure_ascii=False, indent=1))
write(f'{base}/storyboard.json', json.dumps([{'id': s['id'], 'frames': s['frames'], 'seconds': d, 'voice_en': s['voice']} for s, d in zip(OV, ov_d)], ensure_ascii=False, indent=1))
write(f'{base}/SCRIPT.md', '# Umumiy rolik — ssenariy\n\nUzunlik: %.0f soniya. Diktor: inglizcha (Kokoro, ochiq). Subtitr: uz/ru/en.\n\nEXPERT_REVIEW_REQUIRED · NEEDS_NATIVE_REVIEW (uz, ru)\n\n' % sum(ov_d) + '\n'.join(
    f"## {i+1}. {s['id']} ({d:.1f} s) — kadr: {', '.join(s['frames']) or '—'}\n- EN (ovoz): {s['voice']}\n- UZ: {s['line']['uz']}\n- RU: {s['line']['ru']}\n- EN: {s['line']['en']}\n" for i, (s, d) in enumerate(zip(OV, ov_d))))
write(f'{base}/CLAIMS_AND_EVIDENCE.md', '# Da’volar va dalillar (umumiy rolik)\n\n| Sahna | Da’vo | Ilovadagi dalil |\n|---|---|---|\n' + '\n'.join(
    f"| {s['id']} | {EVID[s['id']][0]} | {EVID[s['id']][1]} |" for s in OV) + '\n\nUstunlik da’volari (“eng yaxshi”, “tezroq”), narx, do‘kon, sana, klinik maslahat — yo‘q.\n')
write(f'{base}/DESCRIPTION.md', f"""# Umumiy rolik — nashr matnlari

EXPERT_REVIEW_REQUIRED · NEEDS_NATIVE_REVIEW (uz, ru)

## YouTube sarlavhasi
- UZ: NurseGuide — hamshiralar va o‘rta tibbiyot xodimlari uchun o‘quv ilovasi
- RU: NurseGuide — учебное приложение для медсестёр и среднего медицинского персонала
- EN: NurseGuide — a study app for nurses and mid-level medical staff

## Tavsif (UZ)
NurseGuide — hamshiralar va o‘rta tibbiyot xodimlari uchun o‘quv ilovasi: kunlik savollar, «Bilim va malakani baholash» bo‘limi (test, og‘zaki bilet), manipulyatsiyalar va guruhlar. Har bir ma’lumot ostida manba ko‘rsatiladi. Interfeys: o‘zbekcha, ruscha, inglizcha. Tez kunda.
Ilova o‘quv va ma’lumot maqsadida; davolash yoki klinik qaror uchun emas.

## Описание (RU)
NurseGuide — учебное приложение для медсестёр и среднего медицинского персонала: ежедневные вопросы, раздел «Проверка знаний и компетенций» (тесты, устные билеты), манипуляции и группы. Под каждым материалом указан источник. Интерфейс: узбекский, русский, английский. Скоро.
Приложение учебное и справочное; не предназначено для лечения и клинических решений.

## Description (EN)
NurseGuide is a study app for nurses and mid-level medical staff: daily questions, a Knowledge & Skills Assessment section (tests, oral tickets), procedures and groups. Every item shows its source. Interface: Uzbek, Russian, English. Coming soon.
The app is for study and reference, not for treatment or clinical decisions.

## Boblar (UZ, 16:9 versiya)
{chr(10).join(chapters(OV, ov_d, 'uz'))}

## Teglar
nurseguide, hamshira, o‘rta tibbiyot xodimlari, tibbiyot ta’limi, manipulyatsiya, o‘quv ilovasi, медсестра, nursing education

## Instagram izohi (UZ asosiy)
5 ta savol, test, og‘zaki bilet va manipulyatsiyalar — hammasi manba bilan, bitta ilovada. NurseGuide: tez kunda. Havola profilda.
RU: 5 вопросов, тесты, устные билеты и манипуляции — всё с источниками, в одном приложении. Скоро. Ссылка в профиле.
EN: Questions, tests, oral tickets and procedures — all with sources, in one app. Coming soon. Link in bio.
#NurseGuide #hamshira #tibbiyot #nursing #медсестра
""")
# ---------- REEL ----------
base = '../docs/video/reel'
write(f'{base}/storyboard.json', json.dumps([{'id': s['id'], 'frames': s['frames'], 'seconds': d} for s, d in zip(REEL, reel_d)], ensure_ascii=False, indent=1))
write(f'{base}/SCRIPT.md', '# Qisqa reel — ssenariy (ovozsiz, 3 til subtitri)\n\nUzunlik: %.0f soniya.\n\nEXPERT_REVIEW_REQUIRED · NEEDS_NATIVE_REVIEW (uz, ru)\n\n' % sum(reel_d) + '\n'.join(
    f"## {i+1}. {s['id']} ({d:.0f} s) — kadr: {', '.join(s['frames']) or '—'}\n- UZ: {s['title']['uz']} — {s['line']['uz']}\n- RU: {s['title']['ru']} — {s['line']['ru']}\n- EN: {s['title']['en']} — {s['line']['en']}\n" for i, (s, d) in enumerate(zip(REEL, reel_d))))
write(f'{base}/CLAIMS_AND_EVIDENCE.md', '# Da’volar va dalillar (reel)\n\n| Sahna | Da’vo | Dalil |\n|---|---|---|\n| r-hook | Har kuni 5 ta savol; javobdan keyin izoh va manba | Bosh sahifa kartasi; kadr 11_daily |\n| r-test | Test: imtihon va mashq rejimi | Ekran 03_test_setup / 04_question |\n| r-oral | Og‘zaki bilet va javob rejasi | Ekran 06_oral_plan |\n| r-proc | Manipulyatsiyalar bosqichma-bosqich, manba bilan | Ekran 07_procedure |\n| r-end | “Tez kunda” | — |\n')
write(f'{base}/DESCRIPTION.md', """# Reel — Instagram matni

EXPERT_REVIEW_REQUIRED · NEEDS_NATIVE_REVIEW (uz, ru)

UZ: Har kuni 5 ta savol, test, og‘zaki bilet va manipulyatsiyalar — manba bilan. NurseGuide: tez kunda. Havola profilda.
RU: 5 вопросов в день, тесты, устные билеты и манипуляции — с источниками. NurseGuide: скоро. Ссылка в профиле.
EN: 5 questions a day, tests, oral tickets and procedures — with sources. NurseGuide: coming soon. Link in bio.
#NurseGuide #hamshira #nursing #медсестра #tibbiyot
""")
# ---------- QA ----------
bad = {l: srt_cps(OV, ov_d, l) for l in ('uz', 'ru', 'en')}
bad_r = {l: srt_cps(REEL, reel_d, l) for l in ('uz', 'ru', 'en')}
write('../docs/video/QA.md', f"""# QA hisoboti (rolik tayyorlash)

## Tekshirilgan (avtomatik)
- Subtitr tezligi (belgi/soniya, chegara 17): umumiy rolik {bad} ; reel {bad_r} (bo‘sh ro‘yxat = hammasi chegara ichida).
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
""")
print('docs tayyor', bad, bad_r)
