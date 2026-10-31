// Rolik mazmuni. Har gap ilovadagi ekran/matnga tayanadi (docs/video/*/CLAIMS_AND_EVIDENCE.md).
// O‘ g‘ = U+2018, tutuq belgisi ’ = U+2019.
export type Lang = 'uz' | 'ru' | 'en';
export type L3 = Record<Lang, string>;

export interface Scene {
  id: string;
  /** kadrlar (public/frames/<til>/<nom>.png); bir nechta bo'lsa — ketma-ket */
  frames: string[];
  /** ilovaning uchta tilidagi uchta telefon (til-kadr) */
  triple?: boolean;
  /** oxirgi karta */
  end?: boolean;
  title: L3;
  line: L3;
  /** inglizcha diktor matni (TTS) */
  voice: string;
  /** eng kam davomiylik, soniya */
  min: number;
}

export const OVERVIEW: Scene[] = [
  {
    id: 'hook', frames: ['01_home'], min: 4.2,
    title: {uz: 'Bitta ilova', ru: 'Одно приложение', en: 'One app'},
    line: {
      uz: 'Test, og‘zaki javob va manipulyatsiya — bitta ilovada?',
      ru: 'Тест, устные ответы и манипуляции — в одном приложении?',
      en: 'Tests, oral answers and procedures — in one app?',
    },
    voice: 'Tests, oral answers and procedures. In one app?',
  },
  {
    id: 'intro', frames: ['01_home'], min: 6,
    title: {uz: 'NurseGuide', ru: 'NurseGuide', en: 'NurseGuide'},
    line: {
      uz: 'NurseGuide — hamshiralar va o‘rta tibbiyot xodimlari uchun o‘quv ilovasi.',
      ru: 'NurseGuide — учебное приложение для медсестёр и среднего медицинского персонала.',
      en: 'NurseGuide is a study app for nurses and mid-level medical staff.',
    },
    voice: 'NurseGuide is a study app for nurses and mid-level medical staff.',
  },
  {
    id: 'daily', frames: ['11_daily'], min: 7,
    title: {uz: 'Kunlik 5 savol', ru: '5 вопросов в день', en: '5 questions a day'},
    line: {
      uz: 'Har kuni beshta yangi savol. Javobdan keyin izoh va manba ko‘rsatiladi.',
      ru: 'Каждый день пять новых вопросов. После ответа — пояснение и источник.',
      en: 'Five new questions every day, with an explanation and a source after each answer.',
    },
    voice: 'Five new questions every day, with an explanation and a source after each answer.',
  },
  {
    id: 'hub', frames: ['02_hub'], min: 7,
    title: {uz: 'Bilim va malakani baholash', ru: 'Проверка знаний и компетенций', en: 'Knowledge & Skills Assessment'},
    line: {
      uz: 'Testlar, og‘zaki biletlar va xatolar ustida ishlash — hammasi bir bo‘limda.',
      ru: 'Тесты, устные билеты и работа над ошибками — всё в одном разделе.',
      en: 'Tests, oral tickets and work on your mistakes, all in one section.',
    },
    voice: 'Knowledge and Skills Assessment: tests, oral tickets and work on your mistakes, all in one section.',
  },
  {
    id: 'test', frames: ['03_test_setup', '04_question'], min: 9,
    title: {uz: 'Test', ru: 'Тест', en: 'Test'},
    line: {
      uz: 'Yo‘nalishni tanlang: imtihon rejimida vaqt bilan, mashq rejimida javob darhol ko‘rinadi.',
      ru: 'Выберите направление: режим экзамена — с таймером, режим практики — ответ сразу.',
      en: 'Choose your direction: exam mode with a timer, or practice mode with an instant answer.',
    },
    voice: 'Choose your direction. Exam mode has a timer. Practice mode shows the answer right away.',
  },
  {
    id: 'oral', frames: ['06_oral_plan'], min: 7,
    title: {uz: 'Og‘zaki bilet', ru: 'Устный билет', en: 'Oral ticket'},
    line: {
      uz: 'Bilet torting va javob rejasi bilan o‘zingizni tekshiring.',
      ru: 'Вытяните билет и сверьтесь с планом ответа.',
      en: 'Draw a ticket and check yourself against the answer plan.',
    },
    voice: 'Draw an oral ticket and check yourself against the answer plan.',
  },
  {
    id: 'procedures', frames: ['07_procedure'], min: 7,
    title: {uz: 'Manipulyatsiyalar', ru: 'Манипуляции', en: 'Procedures'},
    line: {
      uz: 'Bosqichma-bosqich ko‘rsatmalar, har birining manbasi bilan.',
      ru: 'Пошаговые инструкции с указанием источника.',
      en: 'Step-by-step guides, each with its source.',
    },
    voice: 'Step-by-step procedure guides, each with its source.',
  },
  {
    id: 'workplace', frames: ['08_workplace'], min: 8,
    title: {uz: 'Ish joyi', ru: 'Рабочее место', en: 'Workplace'},
    line: {
      uz: 'Yo‘nalishingizni tanlang: hamshiralik, akusherlik, patronaj, rentgen laborant va boshqalar.',
      ru: 'Выберите направление: сестринское дело, акушерство, патронаж, рентген-лаборант и другие.',
      en: 'Pick your direction: nursing, midwifery, patronage, X-ray laboratory and more.',
    },
    voice: 'Pick your direction: nursing, midwifery, patronage, X-ray laboratory and more.',
  },
  {
    id: 'groups', frames: ['10_group_results'], min: 7,
    title: {uz: 'Guruhlar', ru: 'Группы', en: 'Groups'},
    line: {
      uz: 'Ustoz guruh ochadi, topshiriq beradi va natijalarni ko‘radi.',
      ru: 'Преподаватель создаёт группу, выдаёт задания и видит результаты.',
      en: 'Teachers create groups, assign tests and see the results.',
    },
    voice: 'Teachers create groups, assign tests and see the results.',
  },
  {
    id: 'sources', frames: ['09_sources'], min: 6,
    title: {uz: 'Manbalar', ru: 'Источники', en: 'Sources'},
    line: {
      uz: 'Har bir ma’lumot qayerdan olingani ko‘rsatiladi.',
      ru: 'Для каждого материала указан источник.',
      en: 'Every item shows where it comes from.',
    },
    voice: 'Every item shows where it comes from.',
  },
  {
    id: 'languages', frames: ['01_home'], triple: true, min: 6,
    title: {uz: '3 ta til', ru: '3 языка', en: '3 languages'},
    line: {
      uz: 'Interfeys o‘zbekcha, ruscha va inglizcha.',
      ru: 'Интерфейс на узбекском, русском и английском.',
      en: 'The interface is in Uzbek, Russian and English.',
    },
    voice: 'The interface is in Uzbek, Russian and English.',
  },
  {
    id: 'end', frames: [], end: true, min: 6,
    title: {uz: 'Tez kunda', ru: 'Скоро', en: 'Coming soon'},
    line: {uz: 'O‘zbekcha · Русский · English', ru: 'O‘zbekcha · Русский · English', en: 'O‘zbekcha · Русский · English'},
    voice: 'NurseGuide. Coming soon.',
  },
];

/** Qisqa reel (ovozsiz, 3 til subtitri birga). */
export const REEL: Scene[] = [
  {
    id: 'r-hook', frames: ['11_daily'], min: 4,
    title: {uz: '5 savol. Har kuni.', ru: '5 вопросов. Каждый день.', en: '5 questions. Every day.'},
    line: {uz: 'Javobdan keyin — izoh va manba.', ru: 'После ответа — пояснение и источник.', en: 'After each answer: explanation and source.'},
    voice: '', 
  },
  {
    id: 'r-test', frames: ['04_question'], min: 7,
    title: {uz: 'Test', ru: 'Тест', en: 'Test'},
    line: {uz: 'Imtihon va mashq rejimi.', ru: 'Режим экзамена и практики.', en: 'Exam and practice modes.'},
    voice: '',
  },
  {
    id: 'r-oral', frames: ['06_oral_plan'], min: 7,
    title: {uz: 'Og‘zaki bilet', ru: 'Устный билет', en: 'Oral ticket'},
    line: {uz: 'Javob rejasi bilan o‘zingizni tekshiring.', ru: 'Сверьтесь с планом ответа.', en: 'Check yourself against the plan.'},
    voice: '',
  },
  {
    id: 'r-proc', frames: ['07_procedure'], min: 7,
    title: {uz: 'Manipulyatsiyalar', ru: 'Манипуляции', en: 'Procedures'},
    line: {uz: 'Bosqichma-bosqich, manba bilan.', ru: 'Пошагово, с источником.', en: 'Step by step, with sources.'},
    voice: '',
  },
  {
    id: 'r-end', frames: [], end: true, min: 5,
    title: {uz: 'Tez kunda', ru: 'Скоро', en: 'Coming soon'},
    line: {uz: 'O‘zbekcha · Русский · English', ru: 'O‘zbekcha · Русский · English', en: 'O‘zbekcha · Русский · English'},
    voice: '',
  },
];
