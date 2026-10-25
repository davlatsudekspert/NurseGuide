// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get appTagline => 'ДЛЯ МЕДСЁСТЕР';

  @override
  String get navHome => 'Главная';

  @override
  String get navLibrary => 'Библиотека';

  @override
  String get navLearn => 'Обучение';

  @override
  String get actionBack => 'Назад';

  @override
  String get actionProfile => 'Профиль и настройки';

  @override
  String get actionLanguage => 'Язык';

  @override
  String get actionRetry => 'Повторить';

  @override
  String get actionContinue => 'Продолжить';

  @override
  String get actionCancel => 'Отмена';

  @override
  String get actionDelete => 'Удалить';

  @override
  String get linkCopied => 'Ссылка скопирована';

  @override
  String get notAvailableYet => 'Пока недоступно';

  @override
  String get debugBuildBadge => 'DEBUG · ДЕМО-АДАПТЕРЫ';

  @override
  String get welcomeEyebrow => 'Ваш помощник медсестры';

  @override
  String get welcomeTitle => 'Сестринское дело.\nПонятно и практично.';

  @override
  String get welcomeSubtitle =>
      'Проверка знаний, манипуляции и обучение в одном месте.';

  @override
  String get welcomeGetStarted => 'Начать / зарегистрироваться';

  @override
  String get welcomeGuest => 'Посмотреть как гость';

  @override
  String get welcomeSignIn => 'Войти';

  @override
  String get welcomeGuestNote =>
      'Гостевой режим — это знакомство: главная, список манипуляций, рабочее место и библиотека. Тесты, практика, ежедневные вопросы, описания манипуляций и группы открываются после регистрации.';

  @override
  String get stateLoading => 'Загрузка…';

  @override
  String get homeTileTests => 'Тест по теме с пояснениями';

  @override
  String get homeTileSaved => 'Быстрый доступ к отмеченному';

  @override
  String get homeTileExam => 'Пробный экзамен на время';

  @override
  String get homeTileClasses => 'Студенты и задания';

  @override
  String get homeTileLecture => 'Слайды и показ на экране';

  @override
  String get authTitle => 'Добро пожаловать';

  @override
  String get authSubtitle => 'Вход или регистрация по email.';

  @override
  String get authEmailLabel => 'Email';

  @override
  String get authEmailHint => 'name@example.com';

  @override
  String get authEmailInvalid => 'Введите корректный адрес email.';

  @override
  String get authConsent =>
      'Я принимаю условия использования и политику конфиденциальности.';

  @override
  String get authConsentRequired => 'Примите условия, чтобы продолжить.';

  @override
  String get authGetCode => 'Получить код';

  @override
  String get authViewTerms => 'Посмотреть условия';

  @override
  String get authDemoNotice =>
      'Debug-сборка: демо-вход. Письмо не отправляется; код будет показан на следующем экране.';

  @override
  String get authUnavailableTitle => 'Вход по email пока не подключён';

  @override
  String get authUnavailableBody =>
      'Гость может смотреть главную, список процедур, рабочее место и библиотеку. Вход пока недоступен.';

  @override
  String get authContinueGuest => 'Продолжить как гость';

  @override
  String authRateLimited(int seconds) {
    return 'Слишком много запросов. Повторите через $seconds с.';
  }

  @override
  String get authGenericError =>
      'Что-то пошло не так. Проверьте соединение и повторите попытку.';

  @override
  String get otpTitle => 'Подтвердите email';

  @override
  String get otpCodeLabel => '6-значный код';

  @override
  String get otpVerify => 'Подтвердить';

  @override
  String otpDemoCode(String code) {
    return 'Демо-код: $code. Письмо не отправлено (только debug-сборка).';
  }

  @override
  String otpInvalid(int attempts) {
    return 'Неверный код. Осталось попыток: $attempts.';
  }

  @override
  String get otpExpired => 'Срок действия кода истёк. Запросите новый.';

  @override
  String get otpTooManyAttempts =>
      'Слишком много попыток. Запросите новый код.';

  @override
  String get otpNoActiveCode => 'Нет активного кода. Запросите новый.';

  @override
  String get otpFormat => 'Введите 6-значный код.';

  @override
  String get otpResend => 'Получить код повторно';

  @override
  String otpResendIn(int seconds) {
    return 'Повторно через $seconds с';
  }

  @override
  String otpValidFor(int minutes) {
    return 'Код действует $minutes мин.';
  }

  @override
  String get otpResent => 'Выдан новый код.';

  @override
  String get rolesTitle => 'Ваше рабочее пространство';

  @override
  String get rolesSubtitle =>
      'Выберите основное направление. Его можно изменить позже.';

  @override
  String get rolesNote =>
      'Роль меняет только главную страницу. Она не даёт доступа к чужим группам и данным.';

  @override
  String get roleStudent => 'Студент';

  @override
  String get roleStudentDesc => 'Обучение, практика и экзамены';

  @override
  String get roleTeacher => 'Преподаватель';

  @override
  String get roleTeacherDesc => 'Группы и задания';

  @override
  String get homeTitle => 'Знания. Уверенность. Практика.';

  @override
  String get homeHeroStudentTitle => 'Учитесь с пониманием';

  @override
  String get homeHeroStudentBody => 'Тема → тест → повторение.';

  @override
  String get homeHeroStudentCta => 'Начать вопросы дня';

  @override
  String get homeHeroTeacherTitle => 'От знаний к занятию';

  @override
  String get homeHeroTeacherBody =>
      'Группы, вопросы с пояснениями и задания со сроком.';

  @override
  String get homeHeroTeacherCta => 'Открыть группы';

  @override
  String get featureTests => 'Тесты';

  @override
  String get featureSaved => 'Сохранённое';

  @override
  String get featureExam => 'Экзамен';

  @override
  String get featureClasses => 'Группы';

  @override
  String get testsFilterAll => 'Все';

  @override
  String get testsEmptyTitle => 'Ничего не найдено';

  @override
  String get testsClearSearch => 'Очистить поиск';

  @override
  String get contentLoading => 'Загрузка контента…';

  @override
  String get contentErrorTitle => 'Не удалось загрузить контент';

  @override
  String get contentErrorBody =>
      'Пакет контента не прошёл проверку. Непроверенные данные никогда не показываются.';

  @override
  String get sourceNoInterpretation =>
      'NurseGuide не интерпретирует отдельные результаты и не предлагает диагнозы или дозы.';

  @override
  String sourceAccessed(String date) {
    return 'Дата обращения: $date';
  }

  @override
  String get sourceReuseRightsVerify =>
      'Права на использование: необходимо проверить перед распространением';

  @override
  String get sourceReuseCitationOnly =>
      'Книга: приведена только как источник, текст не копировался';

  @override
  String get libTitle => 'Библиотека';

  @override
  String get libSubtitle => 'Ваши знания в одном месте.';

  @override
  String get libBooks => 'Книги и руководства';

  @override
  String get libBooksSub => 'Каталог книг, пособий и сайтов';

  @override
  String get libSavedSub => 'Сохранённые материалы';

  @override
  String get libSources => 'Источники и лицензии';

  @override
  String get libSourcesSub => 'Проверка и условия использования';

  @override
  String get booksEmptyTitle => 'Книг пока нет';

  @override
  String get booksEmptyBody =>
      'Книги добавляются только при подтверждённом праве распространения. PDF, добавленный вами, остаётся для личного изучения и не распространяется.';

  @override
  String get booksCatalogNote =>
      'Материалы каталога даны ссылками на официальные страницы. Полный текст добавляется в приложение только при открытой лицензии или подтверждённом праве на распространение.';

  @override
  String get booksResetFilters => 'Сбросить фильтры';

  @override
  String get savedEmptyTitle => 'Закладок пока нет';

  @override
  String get savedEmptyBody =>
      'Нажмите «Сохранить» на странице материала, и он появится здесь.';

  @override
  String get sourcesTitle => 'Источники и лицензии';

  @override
  String get sourcesContent => 'Источники контента';

  @override
  String get sourcesBody =>
      'Каждое публикуемое утверждение связано с первоисточником, датой обращения, областью применения и статусом проверки.';

  @override
  String get learnTitle => 'Учитесь осознанно';

  @override
  String get learnHeroTag => 'Темы и практика';

  @override
  String get learnHeroTitle => 'От знаний к практике';

  @override
  String get learnHeroBody => 'Выберите тему и проверьте знания вопросами.';

  @override
  String get learnHeroCta => 'Выбрать тему';

  @override
  String get learnClassesSub => 'Преподаватель → задание → студент → результат';

  @override
  String get learnQuiz => 'Тест с объяснениями';

  @override
  String learnQuizSub(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count учебного вопроса',
      many: '$count учебных вопросов',
      few: '$count учебных вопроса',
      one: '$count учебный вопрос',
    );
    return '$_temp0';
  }

  @override
  String get learnExam => 'Режим экзамена';

  @override
  String get learnExamSub => 'Время, тема и вопросы';

  @override
  String get toifaTitle => 'Проверка знаний и компетенций';

  @override
  String get toifaSubtitle => 'Тесты, устные вопросы и результаты';

  @override
  String get toifaEyebrow => 'Медсестра · категория';

  @override
  String get toifaEntryBody =>
      'Вопросы из официального списка: тест из 50 вопросов, практика по темам, устный билет и работа над ошибками.';

  @override
  String get toifaEntryBodyShort =>
      'Тест, устный билет и работа над ошибками — по официальному списку.';

  @override
  String get toifaEntryTagTest => 'Тест · 50 вопросов';

  @override
  String get toifaEntryTagOral => 'Устно · 5 вопросов';

  @override
  String toifaEntryTestActive(int done, int total) {
    return 'Тест продолжается: $done / $total ответов';
  }

  @override
  String toifaEntryTicketActive(int done, int total) {
    return 'Устный билет продолжается: $done / $total';
  }

  @override
  String get toifaOpen => 'Начать';

  @override
  String get toifaContinue => 'Продолжить';

  @override
  String get toifaUzbekOnly => 'Официальный текст — на узбекском';

  @override
  String get toifaUzbekNotice =>
      'Официальный текст вопросов — на узбекском. Оценка — по официальному узбекскому тексту и ключу.';

  @override
  String get toifaShowOriginal => 'Показать оригинал';

  @override
  String get toifaHideOriginal => 'Скрыть оригинал';

  @override
  String get toifaOriginalTitle => 'Официальный текст (на узбекском)';

  @override
  String get toifaTranslationAux =>
      'Перевод вспомогательный; оценка — по официальному узбекскому тексту.';

  @override
  String get toifaLoadError => 'Не удалось открыть список вопросов';

  @override
  String get toifaYourCategory => 'Ваша категория';

  @override
  String get toifaCatSecond => '2 категория';

  @override
  String get toifaCatFirst => '1 категория';

  @override
  String get toifaCatHighest => 'Высшая категория';

  @override
  String get toifaTransitionNote =>
      'Тест категории — подготовка к системе квалификационных категорий, действующей до 2030 года. С 1 июля 2027 года вводится государственная регистрация медработников; категории, присвоенные до 2030 года, действуют до истечения срока (ПФ-192, 10.09.2026).';

  @override
  String get toifaCategoryHint =>
      'Устный билет составляется из списка этой категории. Тестовые вопросы общие для всех категорий.';

  @override
  String get toifaReadyTest => 'Тест';

  @override
  String get toifaReadyOral => 'Устно';

  @override
  String get toifaPrepare => 'Подготовка';

  @override
  String get toifaTestTitle => 'Тест на категорию';

  @override
  String toifaTestRowSub(int count, int bank) {
    return '$count случайных вопросов · всего $bank';
  }

  @override
  String get toifaPracticeTitle => 'Практика по темам';

  @override
  String toifaPracticeRowSub(int count) {
    return '$count тем · ключ и пояснение сразу после ответа';
  }

  @override
  String get toifaOralTitle => 'Устный билет';

  @override
  String toifaOralRowSub(String category, int count) {
    return '$category: 5 из $count вопросов';
  }

  @override
  String get toifaOralRowPick => 'Сначала выберите категорию';

  @override
  String toifaOralRowActive(int done, int total) {
    return 'Продолжается: оценено $done / $total';
  }

  @override
  String get toifaMistakesTitle => 'Работа над ошибками';

  @override
  String toifaMistakesRowSub(int tests, int oral) {
    return 'Ошибки в тесте: $tests · устно «не знал»: $oral';
  }

  @override
  String get toifaMistakesRowEmpty => 'Пока ошибок нет';

  @override
  String get toifaProgressTitle => 'Прогресс';

  @override
  String get toifaProgressRowSub => 'Результаты по темам и готовность';

  @override
  String get toifaAboutTitle => 'Источник и проверка';

  @override
  String get toifaListSource => 'Источник: списки вопросов и учебные сборники';

  @override
  String toifaAboutList(int tests, int oral) {
    return 'В списке $tests тестовых и $oral устных вопросов (повторы между категориями объединены).';
  }

  @override
  String toifaAboutKeys(int disputed, int ambiguous) {
    return 'Ключ — ответ, отмеченный в списке; баллы считаются по нему. NurseGuide считает ключ спорным в $disputed вопросах и неоднозначным в $ambiguous — там показаны пояснение и источник.';
  }

  @override
  String toifaAboutKeyless(int count) {
    return 'В $count вопросах ключ в списке не отмечен — они не включены в тест и практику.';
  }

  @override
  String toifaAboutOral(int ready, int total) {
    return 'Планы устных ответов — учебная помощь, подготовленная NurseGuide ($ready / $total планов с источниками).';
  }

  @override
  String toifaTestSubtitle(int count) {
    return '$count вопросов · случайно из списка';
  }

  @override
  String get toifaFormatTitle => 'Формат';

  @override
  String toifaFormatStep1(int count, int bank) {
    return 'Случайные $count вопросов из $bank в списке.';
  }

  @override
  String get toifaFormatStep2 =>
      'В каждом вопросе один ответ; варианты в порядке списка.';

  @override
  String get toifaFormatStep3 =>
      'В конце разбор ошибок: ключ и пояснение NurseGuide.';

  @override
  String get toifaTimeLabel => 'Время, минут';

  @override
  String get toifaNoTime => 'Без времени';

  @override
  String get toifaTimeHelper =>
      'Официальный лимит времени в приложении не задан — выберите сами или оставьте пустым.';

  @override
  String get toifaTimeError => 'Введите от 1 до 240 минут или оставьте пустым';

  @override
  String get toifaPassLabel => 'Проходной порог, %';

  @override
  String get toifaNoPass => 'Не задан';

  @override
  String get toifaPassHelper =>
      'Это выбранный вами порог, а не официальный проходной балл.';

  @override
  String get toifaPassError => 'Введите от 1 до 100 % или оставьте пустым';

  @override
  String get toifaScoringNotice =>
      'Баллы считаются по ключу — верным считается ответ, отмеченный в нём. Для спорных ключей в результатах есть пояснение NurseGuide.';

  @override
  String get toifaTestStart => 'Начать тест';

  @override
  String get toifaTodayEyebrow => 'Сегодня';

  @override
  String toifaTodayGoal(int count) {
    return 'Цель: $count вопросов или 1 билет';
  }

  @override
  String get toifaTodayDone => 'Цель на сегодня выполнена';

  @override
  String toifaTodayProgress(int answered, int goal) {
    return '$answered/$goal вопросов';
  }

  @override
  String toifaTodayCorrect(int percent) {
    return '$percent% верно';
  }

  @override
  String toifaTodayTickets(int count) {
    return 'билетов: $count';
  }

  @override
  String toifaStreakDays(int count) {
    return 'Дней подряд: $count';
  }

  @override
  String get toifaTodayNone => 'Сегодня ещё не занимались.';

  @override
  String get toifaTodayTomorrow => 'Продолжайте завтра — не прерывайте серию.';

  @override
  String toifaWeekLabel(String values) {
    return 'Последние 7 дней: $values';
  }

  @override
  String get toifaGoalLabel => 'Цель на день';

  @override
  String toifaGoalOption(int count) {
    return '$count вопросов';
  }

  @override
  String get toifaGoalHint => 'Или 1 устный билет — что будет раньше.';

  @override
  String get toifaReminderTitle => 'NurseGuide · Категория';

  @override
  String toifaReminderBody(int count) {
    return 'Сегодняшняя подготовка к категории ждёт вас — $count вопросов или 1 билет';
  }

  @override
  String get toifaReminderChannel => 'Напоминание о категории';

  @override
  String get toifaOfferTitle => 'Продолжим завтра?';

  @override
  String get toifaOfferBody =>
      'Выберите время напоминания. В день, когда цель выполнена, напоминания не будет.';

  @override
  String toifaOfferOn(String time) {
    return 'Напомним завтра в $time.';
  }

  @override
  String get toifaModeTitle => 'Режим';

  @override
  String get toifaModeExam => 'Режим экзамена';

  @override
  String get toifaModeExamSub =>
      'С таймером; баллы и ошибки в конце — как на экзамене.';

  @override
  String get toifaModePractice => 'Режим практики — ошибка видна сразу';

  @override
  String get toifaModePracticeSub =>
      'После каждого ответа — правильный ответ и пояснение; без таймера.';

  @override
  String get toifaDrillStep2 =>
      'Сразу после ответа видно, верно или нет: официальный ключ и (если есть) пояснение, источник.';

  @override
  String get toifaDrillStep3 =>
      'Можно продолжить с того же места после закрытия приложения; в конце — работа над ошибками.';

  @override
  String get toifaDrillStart => 'Начать практику';

  @override
  String toifaDrillActive(int answered, int total) {
    return 'Практика идёт: $answered/$total';
  }

  @override
  String get toifaDrillTitle => 'Режим практики';

  @override
  String get toifaDrillRework => 'Работа над ошибками';

  @override
  String toifaDrillScore(int right, int wrong) {
    return 'Верно: $right · ошибок: $wrong';
  }

  @override
  String get toifaDrillFinishEarly => 'Завершить сейчас';

  @override
  String get toifaDrillFinishBody =>
      'Вопросы без ответа засчитываются как неверные. Данные ответы останутся в списке ошибок.';

  @override
  String get toifaDrillDiscardTitle => 'Прервать практику?';

  @override
  String get toifaDrillNone => 'Нет начатой практики';

  @override
  String get toifaDrillNew => 'Новый тест';

  @override
  String toifaDrillUnanswered(int count) {
    return 'Без ответа: $count';
  }

  @override
  String get toifaThinkHint =>
      'Продумайте ответ: проговорите вслух или запишите на бумаге. Затем откройте план и сравните.';

  @override
  String toifaThinkTimer(int minutes) {
    return '$minutes мин на обдумывание';
  }

  @override
  String toifaThinkLeft(String time) {
    return 'Время на обдумывание: $time';
  }

  @override
  String get toifaThinkUp => 'Время вышло — откройте план и сравните.';

  @override
  String get toifaThinkStop => 'Остановить таймер';

  @override
  String get toifaChecklistToggle => 'Ключевые пункты для сверки с планом';

  @override
  String get toifaChecklistHint =>
      'Отметьте то, что было в вашем ответе (только на устройстве, печатать не нужно).';

  @override
  String toifaChecklistCount(int done, int total) {
    return 'Отмечено: $done/$total';
  }

  @override
  String get toifaRepeatTitle => 'Нужно повторить';

  @override
  String get toifaRepeatNote =>
      'Вопросы «Частично» и «Не знал» первыми вернутся в следующих билетах.';

  @override
  String get toifaRepeatNone =>
      'Всё знали — в следующем билете будут новые вопросы.';

  @override
  String get toifaPracticeSubtitle => 'Ключ сразу после ответа';

  @override
  String toifaPracticeMixed(int count) {
    return 'Вперемешку: $count вопросов';
  }

  @override
  String get toifaPracticeMistakes => 'Повторить ошибки';

  @override
  String get toifaBackToTopics => 'Темы';

  @override
  String get toifaPracticeRight => 'Ваш ответ совпадает с официальным ключом.';

  @override
  String get toifaPracticeWrong =>
      'Ваш ответ не совпадает с официальным ключом.';

  @override
  String toifaListNumber(int number) {
    return '№ $number';
  }

  @override
  String get toifaOfficialKey => 'Официальный ключ';

  @override
  String get toifaNurseGuideNote => 'Пояснение NurseGuide';

  @override
  String get toifaVerdictDisputed => 'Ключ спорный';

  @override
  String get toifaVerdictAmbiguous => 'Вопрос неоднозначный';

  @override
  String toifaSuggested(String options) {
    return 'По мнению NurseGuide: $options';
  }

  @override
  String get toifaScoredByOfficial =>
      'Баллы считаются по официальному ключу — на экзамене требуется именно этот ответ.';

  @override
  String get toifaNoOfficialKey =>
      'Ключ в списке не отмечен — вопрос не оценивается.';

  @override
  String get toifaNoteNoSource => 'Источник для пояснения не указан.';

  @override
  String toifaOralSubtitle(int count) {
    return '$count вопросов · подготовка и самооценка';
  }

  @override
  String toifaOralPool(String category, int count) {
    return '$category: в списке $count вопросов';
  }

  @override
  String get toifaOralHowTitle => 'Как это работает';

  @override
  String toifaOralStep1(int count) {
    return '$count случайных вопросов из списка вашей категории.';
  }

  @override
  String get toifaOralStep2 => 'Подготовьте ответы — мысленно или письменно.';

  @override
  String get toifaOralStep3 =>
      'Посмотрите план ответа и оцените себя: знал, частично или не знал.';

  @override
  String get toifaPickCategoryFirst => 'Сначала выберите категорию';

  @override
  String get toifaDrawTicket => 'Взять билет';

  @override
  String get toifaTicketTitle => 'Ваш билет';

  @override
  String get toifaPrepHint =>
      'Печатать в приложении не нужно. Продумайте ответ на каждый вопрос — проговорите вслух или запишите на бумаге. Затем сравните с планом ответа и оцените себя.';

  @override
  String get toifaShowPlans => 'Отвечать по очереди';

  @override
  String get toifaShowPlan => 'Посмотреть план ответа';

  @override
  String get toifaNewTicket => 'Новый билет';

  @override
  String get toifaNewTicketBody =>
      'Вместо текущего билета будет взято 5 новых вопросов. Поставленные оценки сохранятся.';

  @override
  String get toifaPlanTitle => 'План ответа';

  @override
  String get toifaScopeTitle => 'Направление';

  @override
  String get toifaScopeHint => 'Вопросы берутся из выбранного направления.';

  @override
  String get toifaScopeAll => 'Все';

  @override
  String get toifaLiteratureTitle => 'Литература';

  @override
  String get toifaPlanPending => 'Подготовлено NurseGuide';

  @override
  String get toifaPlanMissing => 'План для этого вопроса ещё не подготовлен.';

  @override
  String get toifaPlanNotChecked => 'К этому плану источник ещё не привязан.';

  @override
  String get toifaReferenceTitle => 'Нормативные показатели';

  @override
  String get toifaCutoffTitle => 'Порог (руководство)';

  @override
  String get toifaWrongLabel => 'Неверно';

  @override
  String get toifaRightLabel => 'Верно';

  @override
  String get toifaNeedsSource => 'Нужен источник — уточняется у преподавателя';

  @override
  String get toifaUnverifiedNote =>
      'Пояснение не подтверждено источником — вариант не предлагается.';

  @override
  String toifaAgentChecked(String date) {
    return 'Сверено с источниками: $date';
  }

  @override
  String get toifaHeld => 'Уточняется';

  @override
  String get toifaHeldBody =>
      'Пока формулировка уточняется, вопрос не входит в билеты и оценку.';

  @override
  String toifaAboutHeld(int count) {
    return '$count вопрос(ов) исключены из билетов и теста до уточнения.';
  }

  @override
  String get toifaPitfallsTitle => 'Устаревшее / частая ошибка';

  @override
  String get toifaRateTitle => 'Оцените себя';

  @override
  String get toifaRateHint =>
      'Оценка хранится только на этом устройстве и видна в «Работе над ошибками».';

  @override
  String get toifaRateKnew => 'Знал';

  @override
  String get toifaRatePartial => 'Частично';

  @override
  String get toifaRateUnknown => 'Не знал';

  @override
  String get toifaTicketDone => 'Билет завершён';

  @override
  String toifaTicketSummary(int knew, int partial, int unknown) {
    return 'Знал: $knew · частично: $partial · не знал: $unknown';
  }

  @override
  String get toifaRatingsSaved =>
      'Оценки сохранены. Нажмите вопрос, чтобы снова открыть план и изменить оценку.';

  @override
  String get toifaRatingSaved => 'Оценка сохранена';

  @override
  String get toifaMistakesSubtitle => 'Ошибки теста и устные вопросы';

  @override
  String get toifaMistakesEmpty => 'Пока ошибок нет';

  @override
  String get toifaMistakesEmptyBody =>
      'Здесь собираются вопросы с ошибками из теста и практики, а также устные вопросы с оценкой «не знал».';

  @override
  String toifaMistakesTests(int count) {
    return 'Ошибки теста · $count';
  }

  @override
  String toifaMistakesOralUnknown(int count) {
    return 'Устно: не знал · $count';
  }

  @override
  String toifaMistakesOralPartial(int count) {
    return 'Устно: частично · $count';
  }

  @override
  String toifaMoreMistakes(int count) {
    return 'Ещё $count ошибок — отработайте их через «Повторить ошибки».';
  }

  @override
  String get toifaNothingHere => 'Здесь пока ничего нет.';

  @override
  String get toifaProgressSubtitle => 'Результаты по темам и готовность';

  @override
  String get toifaReadyTitle => 'Примерная готовность';

  @override
  String get toifaReadyCaption => 'Среднее теста и устной части.';

  @override
  String toifaReadyTestDetail(int done, int total) {
    return 'Тест: освоено $done / $total вопросов';
  }

  @override
  String toifaReadyOralDetail(int done, int total) {
    return 'Устно: $done / $total «знал»';
  }

  @override
  String get toifaProgressPickCategory =>
      'Устный результат считается по списку вашей категории — выберите категорию:';

  @override
  String get toifaRecentTests => 'Последние тесты';

  @override
  String get toifaPassedShort => 'Порог пройден';

  @override
  String get toifaNotPassedShort => 'Порог не пройден';

  @override
  String get toifaByTopicNote =>
      'Сначала самые слабые темы. Тест — вопросы с последним верным ответом; устно — с оценкой «знал».';

  @override
  String toifaBarTest(int done, int total) {
    return 'Тест: $done / $total';
  }

  @override
  String toifaBarOral(int done, int total) {
    return 'Устно: $done / $total';
  }

  @override
  String examPassMet(int percent) {
    return 'Порог пройден (≥$percent%)';
  }

  @override
  String examPassMissed(int percent) {
    return 'Порог не достигнут ($percent%)';
  }

  @override
  String quizProgress(int current, int total) {
    return 'Вопрос $current из $total';
  }

  @override
  String get quizCorrect => 'Верно.';

  @override
  String get quizIncorrect => 'Этот ответ неверен.';

  @override
  String get quizNext => 'Далее';

  @override
  String get quizFinish => 'Посмотреть результат';

  @override
  String get quizDoneTitle => 'Практика завершена';

  @override
  String quizScore(int correct, int total) {
    return 'Верно: $correct из $total';
  }

  @override
  String get quizRestart => 'Повторить';

  @override
  String quizBasis(String basis) {
    return 'Основание: $basis';
  }

  @override
  String get quizSources => 'Источник';

  @override
  String get quizReviewNote =>
      'Учебные вопросы — для тренировки; результат не является официальной оценкой.';

  @override
  String get quizMistakes => 'Разбор ошибок';

  @override
  String get quizNoMistakes => 'Ошибок нет — отлично.';

  @override
  String get quizYourAnswer => 'Ваш ответ';

  @override
  String get quizCorrectAnswer => 'Правильный ответ';

  @override
  String get quizChooseTopic => 'Выберите тему';

  @override
  String quizTopicMixed(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Вперемешку: $count случайного вопроса',
      many: 'Вперемешку: $count случайных вопросов',
      few: 'Вперемешку: $count случайных вопроса',
      one: 'Вперемешку: $count случайный вопрос',
    );
    return '$_temp0';
  }

  @override
  String get quizTopicGeneral => 'Общие вопросы';

  @override
  String quizQuestionCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count вопроса',
      many: '$count вопросов',
      few: '$count вопроса',
      one: '$count вопрос',
    );
    return '$_temp0';
  }

  @override
  String get quizOtherTopic => 'Другая тема';

  @override
  String get dailyTitle => 'Вопросы дня';

  @override
  String get dailyCardStart => '5 вопросов на сегодня';

  @override
  String get dailyCardStartSub =>
      '2–3 минуты. Каждый день новые вопросы, после ответа — пояснение и источник.';

  @override
  String dailyCardProgress(int count, int total) {
    return 'Отвечено: $count из $total';
  }

  @override
  String dailyCardDone(int correct, int total) {
    return 'Сегодня выполнено: верно $correct из $total';
  }

  @override
  String get dailyCardDoneSub => 'Завтра будут новые 5 вопросов.';

  @override
  String get dailyStart => 'Начать';

  @override
  String get dailyContinue => 'Продолжить';

  @override
  String get dailyShowResult => 'Посмотреть результат';

  @override
  String dailyStreakDays(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count дня подряд',
      many: '$count дней подряд',
      few: '$count дня подряд',
      one: '$count день подряд',
    );
    return '$_temp0';
  }

  @override
  String get dailyStreakTitle => 'Серия';

  @override
  String get dailyStreakCurrent => 'Текущая серия';

  @override
  String get dailyStreakBest => 'Самая длинная';

  @override
  String dailyDaysShort(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count дня',
      many: '$count дней',
      few: '$count дня',
      one: '$count день',
    );
    return '$_temp0';
  }

  @override
  String get dailyFreezeAvailable => 'Заморозка на этой неделе доступна';

  @override
  String get dailyFreezeUsed => 'Заморозка на этой неделе использована';

  @override
  String get dailyFreezeRule =>
      'Если пропустить один день, серия не прервётся — раз в неделю (заморозка). Замороженный день в серию не засчитывается; если пропустить два дня подряд, серия начнётся заново.';

  @override
  String get dailyFreezeSaved =>
      'Вчера был пропуск — заморозка сохранила серию.';

  @override
  String get dailyKeepStreak =>
      'Ответьте на сегодняшние вопросы, чтобы сохранить серию.';

  @override
  String get dailyEmpty => 'Вопросов на сегодня не найдено';

  @override
  String get dailyReviewTitle => 'Сегодняшние вопросы';

  @override
  String get dailySourceToifa =>
      'Вопросы берутся из официального списка — только те, чей ключ прошёл проверку NurseGuide.';

  @override
  String get dailyReminderTitle => 'NurseGuide: вопросы дня';

  @override
  String get dailyReminderBody => '5 вопросов на сегодня готовы — 2–3 минуты.';

  @override
  String get dailyReminderChannel => 'Ежедневное напоминание';

  @override
  String get dailyReminderSetting => 'Ежедневное напоминание';

  @override
  String dailyReminderAt(String time) {
    return 'Каждый день в $time';
  }

  @override
  String get dailyReminderOff => 'Выключено';

  @override
  String get dailyReminderTime => 'Время напоминания';

  @override
  String get dailyOfferTitle => 'Напоминать каждый день?';

  @override
  String get dailyOfferBody =>
      'Одно уведомление в выбранное время. В дни, когда вы уже ответили, напоминания не будет. Отключить можно в любой момент.';

  @override
  String get dailyOfferYes => 'Включить напоминание';

  @override
  String get dailyOfferNo => 'Не нужно';

  @override
  String get dailyReminderDenied =>
      'Разрешение на уведомления не дано, напоминание выключено. Включите уведомления для NurseGuide в настройках телефона и попробуйте снова.';

  @override
  String get dailyReminderUnavailable =>
      'На этом устройстве не удалось включить напоминание.';

  @override
  String dailyReminderOnSnack(String time) {
    return 'Напоминание включено: каждый день в $time';
  }

  @override
  String get dailyReminderNote =>
      'Напоминание планируется только на этом устройстве (без сервера). Телефон может задержать его на несколько минут для экономии заряда. Если не открывать приложение 7 дней, напоминания прекратятся.';

  @override
  String get shareResult => 'Поделиться результатом';

  @override
  String get shareSheetTitle => 'Карточка результата';

  @override
  String get shareSheetBody =>
      'На картинке нет вашего имени и других личных данных.';

  @override
  String get shareFailed =>
      'Не удалось открыть окно «Поделиться». Попробуйте ещё раз.';

  @override
  String get shareKindDaily => 'Вопросы дня';

  @override
  String get shareKindExam => 'Тренировочный экзамен';

  @override
  String get shareKindToifa => 'Тренировка теста на категорию';

  @override
  String get shareCorrectCaption => 'верных ответов';

  @override
  String get shareFooter => 'Справочник и тренировки для медсестёр';

  @override
  String get shareToifaNote => 'Результат тренировки в NurseGuide';

  @override
  String shareText(String kind, int correct, int total, int percent) {
    return 'NurseGuide · $kind: $correct/$total ($percent%)';
  }

  @override
  String get quizTopicMistakes => 'Работа над ошибками';

  @override
  String quizMastered(int correct, int total) {
    return 'верно в прошлый раз: $correct из $total';
  }

  @override
  String get examTitle => 'Режим экзамена';

  @override
  String get classesTitle => 'Группы и задания';

  @override
  String get classesSignInTitle => 'Войдите, чтобы пользоваться группами';

  @override
  String get classesSignInBody =>
      'Создание групп, вступление и отправка заданий привязаны к аккаунту.';

  @override
  String get classesSignIn => 'Войти';

  @override
  String get classesUnavailableTitle => 'Сервер групп пока не подключён';

  @override
  String get classesUnavailableBody =>
      'Ничего не отправляется и не сохраняется. После подключения преподаватель видит только свои группы, а студент — только свои результаты; это проверяется на сервере.';

  @override
  String get examSubtitle =>
      'Экзамен на время: выберите темы, число вопросов и время. Работает без интернета.';

  @override
  String get examActiveTitle => 'Незавершённый экзамен';

  @override
  String examActiveBody(int answered, int total, String time) {
    return 'Ответов: $answered/$total · осталось $time';
  }

  @override
  String get examResume => 'Продолжить';

  @override
  String get examDiscard => 'Прервать экзамен';

  @override
  String get examDiscardTitle => 'Прервать экзамен?';

  @override
  String get examDiscardBody =>
      'Ответы удалятся, результат не попадёт в историю.';

  @override
  String get examDiscardAction => 'Прервать';

  @override
  String get examTopics => 'Темы';

  @override
  String get examAllTopics => 'Все';

  @override
  String examPoolCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'В выбранных темах $count вопроса',
      many: 'В выбранных темах $count вопросов',
      few: 'В выбранных темах $count вопроса',
      one: 'В выбранных темах $count вопрос',
    );
    return '$_temp0';
  }

  @override
  String get examSettings => 'Параметры';

  @override
  String get examCount => 'Число вопросов';

  @override
  String examCountHint(int max) {
    return 'От 1 до $max';
  }

  @override
  String examCountError(int max) {
    return 'Введите число от 1 до $max';
  }

  @override
  String examCountAll(int count) {
    return 'Все $count';
  }

  @override
  String get examTime => 'Время, мин';

  @override
  String get examTimeHint => '1–180 мин · обычно 1 мин на вопрос';

  @override
  String get examTimeError => 'Введите от 1 до 180 минут';

  @override
  String examMinutes(int count) {
    return '$count мин';
  }

  @override
  String get examRulesNotice =>
      'Вопросы и варианты — в случайном порядке. До завершения можно менять ответы и отмечать вопросы, чтобы вернуться к ним. Время идёт, даже если приложение закрыто; когда оно истечёт, экзамен завершится сам.';

  @override
  String get examStart => 'Начать экзамен';

  @override
  String get examReplaceTitle => 'Есть незавершённый экзамен';

  @override
  String get examReplaceBody =>
      'Если начать новый, предыдущий удалится вместе с ответами.';

  @override
  String get examHistory => 'История результатов';

  @override
  String get examHistoryEmpty =>
      'Экзаменов пока не было. Первый результат появится здесь — он хранится только на этом устройстве.';

  @override
  String examHistoryStats(int count, int avg, int best) {
    return 'Последние $count: в среднем $avg% · лучший $best%';
  }

  @override
  String examHistoryRow(String date, int correct, int total, String time) {
    return '$date · $correct/$total · $time';
  }

  @override
  String get examHistoryClear => 'Очистить историю';

  @override
  String get examHistoryClearBody =>
      'Все результаты экзаменов будут удалены с этого устройства.';

  @override
  String examProgressLabel(String values) {
    return 'Последние результаты: $values';
  }

  @override
  String get examProgressOld => 'Раньше → сейчас';

  @override
  String get examProgressLast => 'Последний';

  @override
  String get examSettled => 'Предыдущий экзамен завершён: время истекло';

  @override
  String get examOpenResult => 'Результат';

  @override
  String get examTitleAll => 'Все темы';

  @override
  String examTitleTopics(String first, int more) {
    return '$first и ещё $more';
  }

  @override
  String get examReworkTitle => 'Работа над ошибками';

  @override
  String get examQuestionMissing =>
      'Этого вопроса нет в текущем пакете контента.';

  @override
  String get examMap => 'Карта вопросов';

  @override
  String get examFinish => 'Завершить';

  @override
  String get examFinishTitle => 'Завершить экзамен?';

  @override
  String examFinishBody(int unanswered, int flagged) {
    return 'Без ответа: $unanswered, отмечено: $flagged. После завершения ответы изменить нельзя.';
  }

  @override
  String get examFinishBodyAll =>
      'На все вопросы есть ответ. После завершения ответы изменить нельзя.';

  @override
  String get examFinishClassTitle => 'Завершить тест?';

  @override
  String get examFinishClassBody => 'Ответы будут отправлены преподавателю.';

  @override
  String get examFlag => 'Отметить';

  @override
  String get examFlagged => 'Отмечен';

  @override
  String get examLegendAnswered => 'Есть ответ';

  @override
  String get examLegendEmpty => 'Без ответа';

  @override
  String get examLegendFlagged => 'Отмечен';

  @override
  String examQuestionN(int n) {
    return 'Вопрос $n';
  }

  @override
  String examAnsweredOf(int answered, int total) {
    return 'Ответов: $answered/$total';
  }

  @override
  String get examPrev => 'Назад';

  @override
  String get examNext => 'Далее';

  @override
  String examTimeLeft(String time) {
    return 'Осталось: $time';
  }

  @override
  String examElapsed(String time) {
    return 'Прошло: $time';
  }

  @override
  String get examNoActive => 'Нет активного экзамена';

  @override
  String get examNoActiveBody =>
      'Он завершён или прерван. Настройте и начните новый.';

  @override
  String get examNew => 'Новый экзамен';

  @override
  String get examSaving => 'Сохраняем результат…';

  @override
  String get examResultTitle => 'Результат';

  @override
  String get examResultMissing => 'Результат не найден';

  @override
  String get examBand90 => 'Отличный результат!';

  @override
  String get examBand70 => 'Хороший результат!';

  @override
  String get examBand50 => 'Неплохо — разберите ошибки';

  @override
  String get examBand0 => 'Нужна практика — у вас получится';

  @override
  String get examCorrectN => 'Верно';

  @override
  String get examWrongN => 'Ошибки';

  @override
  String get examSkippedN => 'Без ответа';

  @override
  String get examSpent => 'Время';

  @override
  String get examTimedOut => 'Время вышло — завершено автоматически';

  @override
  String examDeltaUp(int n) {
    return '+$n% к прошлой попытке';
  }

  @override
  String examDeltaDown(int n) {
    return '−$n% к прошлой попытке';
  }

  @override
  String get examDeltaSame => 'Как в прошлой попытке';

  @override
  String examReworkMistakes(int count) {
    return 'Работа над ошибками · $count';
  }

  @override
  String get examAnalysis => 'Разбор ошибок';

  @override
  String examFilterMistakes(int count) {
    return 'Ошибки · $count';
  }

  @override
  String examFilterAll(int count) {
    return 'Все · $count';
  }

  @override
  String get examNoAnswer => 'Нет ответа';

  @override
  String get examWrongTag => 'Ошибка';

  @override
  String get examWhyWrong => 'Почему не этот ответ';

  @override
  String get examNoSource => 'Для этого вопроса источник не указан.';

  @override
  String get examSourceMissing =>
      'Банк вопросов этого экзамена не найден в приложении';

  @override
  String get examMultiHint => 'Несколько верных ответов — отметьте все';

  @override
  String get examNoExplanation => 'Пояснение к этому вопросу ещё не написано.';

  @override
  String get examByTopic => 'По темам';

  @override
  String get examByTopicNote =>
      'Сначала — тема с самым низким результатом: начните с неё.';

  @override
  String get classesSubtitle =>
      'Преподаватель создаёт группу и даёт задания, студенты вступают по коду и решают.';

  @override
  String get classesTryExam => 'Открыть экзамен без интернета';

  @override
  String get classesLoading => 'Загрузка…';

  @override
  String get classesInvalid => 'Сервер не принял данные — проверьте поля.';

  @override
  String get classesCodeNotFound =>
      'Группа с таким кодом не найдена. Уточните код у преподавателя.';

  @override
  String get classesCreate => 'Создать группу';

  @override
  String get classesCreateSub =>
      'Для преподавателя: получите код и давайте задания';

  @override
  String get classesJoin => 'Вступить по коду';

  @override
  String get classesJoinSub => 'Для студента: 8-значный код от преподавателя';

  @override
  String get classesRoleNote =>
      'Роль в приложении не даёт прав на сервере: группу открывает только аккаунт, зарегистрированный как преподаватель, и он управляет только своими группами.';

  @override
  String get classesMine => 'Мои группы';

  @override
  String get classesEmpty => 'Групп пока нет';

  @override
  String get classesEmptyBody =>
      'Создайте группу или вступите по коду от преподавателя.';

  @override
  String get classesRoleTeacher => 'Преподаватель';

  @override
  String get classesRoleStudent => 'Студент';

  @override
  String classesMembers(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count участника',
      many: '$count участников',
      few: '$count участника',
      one: '$count участник',
    );
    return '$_temp0';
  }

  @override
  String get classesCreateIntro =>
      'Преподаватель, открывший группу, управляет только ею. Студенты вступают по вашему коду или QR.';

  @override
  String get classesGroupName => 'Название группы';

  @override
  String get classesGroupNameHint => 'Например, Сестринское дело 2 курс';

  @override
  String classesLengthError(int min, int max) {
    return 'Введите от $min до $max символов';
  }

  @override
  String get classesDisplayName => 'Псевдоним (необязательно)';

  @override
  String get classesDisplayNameHint =>
      'Например, Звезда — если пусто, порядковый номер';

  @override
  String get classesDisplayNameNote =>
      'ФИО на сервере не хранятся: студенты видны по псевдониму или порядковому номеру. Настоящее имя можно записать только как метку на своём устройстве.';

  @override
  String get classesCreateAction => 'Создать группу';

  @override
  String get classesCreated => 'Группа создана — отправьте код студентам';

  @override
  String get classesJoinIntro => 'Введите код, который дал преподаватель.';

  @override
  String get classesCode => 'Код приглашения';

  @override
  String get classesCodeError => 'Код состоит из 8 букв и цифр';

  @override
  String get classesJoinNote =>
      'Не указывайте настоящее имя. Преподаватель видит только ваш псевдоним (или номер) и результаты заданий; другие студенты вас не видят. Email не показывается.';

  @override
  String get classesJoinAction => 'Вступить';

  @override
  String get classesJoined => 'Вы вступили в группу';

  @override
  String classesYouTeacher(int count) {
    return 'Вы — преподаватель · участников: $count';
  }

  @override
  String get classesYouStudent => 'Вы — студент';

  @override
  String get classesGroupMissing =>
      'Группа не найдена или вы больше не участник';

  @override
  String get classesBackToList => 'К списку групп';

  @override
  String get classesAssignments => 'Задания';

  @override
  String get classesNoAssignmentsTeacher =>
      'Заданий пока нет. Выберите темы и число вопросов из списка и дайте задание.';

  @override
  String get classesNoAssignmentsStudent => 'Пока заданий нет';

  @override
  String get classesNoAssignmentsStudentBody =>
      'Когда преподаватель даст задание, оно появится здесь.';

  @override
  String get classesNoDue => 'без срока';

  @override
  String classesDue(String date) {
    return 'срок $date';
  }

  @override
  String classesSubmittedOf(int done, int total) {
    return 'сдали $done/$total';
  }

  @override
  String classesMembersTitle(int count) {
    return 'Студенты · $count';
  }

  @override
  String get classesNoStudents => 'Студентов пока нет — отправьте код.';

  @override
  String get classesMemberNoWork => 'Пока ничего не сдано';

  @override
  String classesMemberSummary(int done, int total, int avg) {
    return 'Заданий: $done/$total · в среднем $avg%';
  }

  @override
  String get classesRemove => 'Исключить из группы';

  @override
  String classesRemoveTitle(String name) {
    return 'Исключить $name из группы?';
  }

  @override
  String get classesRemoveBody =>
      'Студент больше не увидит группу и новые задания. Сданные результаты сохранятся.';

  @override
  String get classesRemoveAction => 'Исключить';

  @override
  String classesStatusDone(int score, int total) {
    return 'Сдано · $score/$total';
  }

  @override
  String get classesStatusInProgress => 'В процессе';

  @override
  String get classesStatusPending => 'Не отправлено';

  @override
  String get classesStatusOverdue => 'Срок истёк';

  @override
  String get classesStatusNew => 'Новое';

  @override
  String get classesStudentNote =>
      'Преподаватель видит только ваш псевдоним (или порядковый номер) и результаты заданий.';

  @override
  String get classesLeave => 'Выйти из группы';

  @override
  String get classesLeaveTitle => 'Выйти из группы?';

  @override
  String get classesLeaveBody =>
      'Чтобы вернуться, понадобится код преподавателя. Сданные результаты останутся у преподавателя.';

  @override
  String get classesLeaveAction => 'Выйти';

  @override
  String get classesInviteTitle => 'Код приглашения';

  @override
  String get classesInviteBody =>
      'Студенты сканируют QR камерой телефона и нажимают «Открыть в приложении» — или: Обучение → Группы и задания → Вступить по коду.';

  @override
  String get classesCopyCode => 'Скопировать код';

  @override
  String get classesCopyInvite => 'Скопировать приглашение';

  @override
  String get classesCopied => 'Скопировано';

  @override
  String classesInviteText(String name, String code) {
    return 'Вступите в группу «$name» в приложении NurseGuide: Обучение → Группы и задания → Вступить по коду. Код: $code';
  }

  @override
  String get classesAssignmentTitle => 'Название задания';

  @override
  String get classesTimeLimit => 'Ограничение времени, мин';

  @override
  String get classesNoLimit => 'Без ограничения';

  @override
  String get classesDueNone => 'Без срока';

  @override
  String classesDueDays(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count дня',
      many: '$count дней',
      few: '$count дня',
      one: '$count день',
    );
    return '$_temp0';
  }

  @override
  String get classesDuePick => 'Выбрать дату';

  @override
  String get classesDueNoneBody => 'Без срока — студенты сдают в любое время.';

  @override
  String classesDueAt(String date) {
    return 'Срок: до $date';
  }

  @override
  String classesPreview(int count) {
    return 'Выбранные вопросы · $count';
  }

  @override
  String get classesReshuffle => 'Другие вопросы';

  @override
  String get classesKeyNotice =>
      'Студенты не видят ключ заранее — баллы считает сервер. Каждый сдаёт один раз.';

  @override
  String get classesSendAssignment => 'Дать задание';

  @override
  String get classesSubmitted => 'Ответы отправлены';

  @override
  String get classesSubmitNetwork =>
      'Нет интернета — ответы сохранены на устройстве. Отправьте позже.';

  @override
  String get classesSubmitRejected =>
      'Сервер не принял ответы: время или срок истекли, либо задание уже сдано.';

  @override
  String get classesAssignmentMissing => 'Задание не найдено';

  @override
  String get classesMetricQuestions => 'Вопросов';

  @override
  String get classesMetricLimit => 'Ограничение времени';

  @override
  String get classesMetricDue => 'Срок';

  @override
  String get classesMetricSubmitted => 'Сдали';

  @override
  String get classesMetricAverage => 'Средний балл';

  @override
  String get classesPendingTitle => 'Ответы ещё не отправлены';

  @override
  String get classesPendingBody =>
      'Они сохранены на устройстве. Отправьте, когда появится интернет, — сервер примет их в пределах лимита времени.';

  @override
  String get classesResend => 'Отправить снова';

  @override
  String get classesOverdueTitle => 'Срок истёк';

  @override
  String get classesOverdueBody => 'Это задание больше нельзя сдать.';

  @override
  String classesOutdatedPack(int count) {
    return 'В вашей версии приложения нет вопросов из этого задания: $count. Обновите приложение.';
  }

  @override
  String classesStartNotice(int minutes) {
    return 'После начала даётся $minutes мин — время не останавливается, по окончании ответы отправятся сами. Сдать можно один раз; для отправки нужен интернет.';
  }

  @override
  String get classesStartNoticeNoLimit =>
      'Без ограничения времени. Ответы отправляются один раз, пересдать нельзя; для отправки нужен интернет.';

  @override
  String get classesStart => 'Начать';

  @override
  String classesSubmittedAt(String date) {
    return 'Сдано: $date';
  }

  @override
  String get classesServerScore => 'Балл посчитан сервером';

  @override
  String get classesResults => 'Результаты';

  @override
  String get classesColStudent => 'Студент';

  @override
  String get classesColScore => 'Балл · %';

  @override
  String get classesNotSubmitted => 'Не сдано';

  @override
  String get classesByQuestion => 'По вопросам';

  @override
  String get classesByQuestionEmpty => 'Пока никто не сдал.';

  @override
  String classesWrongOf(int wrong, int total) {
    return 'ошибок $wrong/$total';
  }

  @override
  String get classesSending => 'Отправка ответов…';

  @override
  String get classesMyProgress => 'Мой прогресс';

  @override
  String classesDoneOf(int done, int total) {
    return 'Выполнено заданий: $done/$total';
  }

  @override
  String classesAverage(int avg) {
    return 'Средний балл: $avg%';
  }

  @override
  String get classesStudentResultTitle => 'Результат студента';

  @override
  String get classesStudentAnswer => 'Ответ студента';

  @override
  String get classesInviteMore => 'Пригласить ещё студентов';

  @override
  String get profileTitle => 'Профиль и настройки';

  @override
  String get profileGuest => 'Гость';

  @override
  String get profileGuestSub => 'Гость: основные разделы видны';

  @override
  String get profileGuestLocal => 'Данные только на этом устройстве';

  @override
  String get profileDemoSession => 'Демо-сессия · debug-сборка';

  @override
  String get profileRole => 'Роль';

  @override
  String get profileRoleSub => 'Главная адаптируется под вас';

  @override
  String get profileLanguage => 'Язык';

  @override
  String get profileAppearance => 'Оформление';

  @override
  String get themeSystem => 'Система';

  @override
  String get themeLight => 'Светлая';

  @override
  String get themeDark => 'Тёмная';

  @override
  String get themeTitle => 'Тема';

  @override
  String get themeRowSub => 'Цвета приложения и шрифт заголовков';

  @override
  String get themeCurrent => 'Текущая тема';

  @override
  String get themeClassicName => 'Прозрачное стекло';

  @override
  String get themeClassicDesc => 'Мягкое стекло и 3D-значки';

  @override
  String get themeIvoryName => 'Слоновая кость';

  @override
  String get themeIvoryDesc =>
      'Слоновая кость, чёрный и золото, изящные заголовки с засечками';

  @override
  String get themeModeSection => 'Светлая или тёмная';

  @override
  String get profilePrivacy => 'Конфиденциальность и данные';

  @override
  String get profilePrivacySub => 'Данные и управление аккаунтом';

  @override
  String get supportTitle => 'Предложения и помощь';

  @override
  String get supportSub => 'Предложение, ошибка или вопрос — ответ придёт сюда';

  @override
  String get supportNew => 'Новое обращение';

  @override
  String get supportEmptyTitle => 'Обращений пока нет';

  @override
  String get supportEmptyBody =>
      'Напишите предложение, сообщите об ошибке или задайте вопрос — ответ появится здесь.';

  @override
  String get supportKind => 'Тип';

  @override
  String get supportKindSuggestion => 'Предложение';

  @override
  String get supportKindBug => 'Ошибка';

  @override
  String get supportKindQuestion => 'Вопрос';

  @override
  String get supportSubject => 'Тема';

  @override
  String get supportSubjectHint => 'Коротко: о чём?';

  @override
  String get supportMessage => 'Сообщение';

  @override
  String get supportMessageHint =>
      'Подробно: на каком экране, что вы сделали и что ожидали';

  @override
  String get supportAttach => 'Прикрепить скриншот (необязательно)';

  @override
  String get supportAttachRemove => 'Убрать изображение';

  @override
  String get supportAttachTooLarge =>
      'Изображение больше 5 МБ. Выберите изображение поменьше.';

  @override
  String get supportAttachType => 'Только PNG или JPEG.';

  @override
  String get supportPhiNotice =>
      'На скриншоте не должно быть имени пациента, даты рождения, номера карты и других персональных данных.';

  @override
  String get supportSend => 'Отправить';

  @override
  String get supportSent => 'Обращение отправлено';

  @override
  String get supportReplyHint => 'Напишите ответ…';

  @override
  String get supportTeam => 'Команда NurseGuide';

  @override
  String get supportYou => 'Вы';

  @override
  String get supportUser => 'Пользователь';

  @override
  String get supportHumanReplies =>
      'Ответы пишет команда NurseGuide; автоматических ответов нет.';

  @override
  String get supportStatusNew => 'Новое';

  @override
  String get supportStatusInReview => 'На рассмотрении';

  @override
  String get supportStatusAnswered => 'Отвечено';

  @override
  String get supportStatusClosed => 'Закрыто';

  @override
  String get supportUnread => 'Новый ответ';

  @override
  String supportUnreadCount(int count) {
    return 'Новых ответов: $count';
  }

  @override
  String get supportSignInTitle => 'Войдите, чтобы отправить обращение';

  @override
  String get supportSignInBody =>
      'Чтобы ответ дошёл до вас, нужно войти по email. Данные на устройстве не изменятся.';

  @override
  String get supportUnavailableTitle => 'Сервер ещё не подключён';

  @override
  String get supportUnavailableBody =>
      'В этой версии не удалось подключиться к серверу аккаунтов, обращений и групп.';

  @override
  String get errNetwork => 'Нет соединения с интернетом. Попробуйте снова.';

  @override
  String get errRateLimited => 'Слишком много запросов. Попробуйте чуть позже.';

  @override
  String get errInvalidSupport =>
      'Тема — не короче 3 символов, сообщение не должно быть пустым.';

  @override
  String get errForbidden => 'Нет доступа к этому действию.';

  @override
  String get errSessionExpired => 'Сессия истекла. Войдите снова.';

  @override
  String get errGeneric => 'Не получилось. Попробуйте снова.';

  @override
  String get accountDelete => 'Удалить аккаунт';

  @override
  String get accountDeleteSub =>
      'Удалятся аккаунт на сервере, обращения и участие в группах';

  @override
  String get accountDeleteTitle => 'Удалить аккаунт?';

  @override
  String get accountDeleteBody =>
      'Аккаунт, способы входа (привязка Google/Apple), участие и результаты в группах и обращения в «Предложения и помощь» будут полностью удалены с сервера. Если вы преподаватель, созданные вами группы тоже удалятся. Отменить это нельзя. Тексты жалоб, отправленных в приложении, остаются без привязки к аккаунту. Данные на устройстве тоже очищаются.';

  @override
  String get accountDeleted => 'Аккаунт удалён';

  @override
  String get adminTitle => 'Админ-панель';

  @override
  String get adminSub => 'Модерация, обращения, контент, администраторы';

  @override
  String get adminMfaTitle => 'Двухфакторная защита';

  @override
  String get adminMfaEnrollBody =>
      'Для админ-панели нужно приложение-аутентификатор (Google Authenticator, Microsoft Authenticator, 1Password…). Добавьте ключ в приложение и введите показанный 6-значный код.';

  @override
  String get adminMfaVerifyBody =>
      'Введите 6-значный код из приложения-аутентификатора.';

  @override
  String get adminMfaSecret => 'Ключ';

  @override
  String get adminMfaCopy => 'Скопировать ключ';

  @override
  String get adminMfaOpen => 'Открыть в аутентификаторе';

  @override
  String get adminMfaCode => '6-значный код';

  @override
  String get adminMfaVerify => 'Подтвердить';

  @override
  String get adminMfaWrong =>
      'Код неверный или устарел. Введите новый код из приложения.';

  @override
  String get adminCopied => 'Скопировано';

  @override
  String get adminForbiddenTitle => 'Только для администратора';

  @override
  String get adminForbiddenBody =>
      'Права администратора выдаёт сервер — роль или email в приложении на это не влияют.';

  @override
  String get adminStats => 'Статистика';

  @override
  String get adminRegistered => 'Зарегистрировано';

  @override
  String get adminNewToday => 'Новых сегодня';

  @override
  String get adminNew7 => 'Новых за 7 дней';

  @override
  String get adminNew30 => 'Новых за 30 дней';

  @override
  String get adminActiveToday => 'Активны сегодня';

  @override
  String get adminActive7 => 'Активны за 7 дней';

  @override
  String get adminActive30 => 'Активны за 30 дней';

  @override
  String get adminDefinitions =>
      'Зарегистрирован — аккаунт с email, подтверждённым кодом; гости и неподтвердившие не считаются. Новый — день первого подтверждения email. Активный — хотя бы раз открыл приложение, будучи в аккаунте, за период. Дни по ташкентскому времени; «7 дней» включая сегодня.';

  @override
  String get adminByRole => 'По ролям';

  @override
  String get adminByLanguage => 'По языкам';

  @override
  String adminNoProfile(int count) {
    return 'Профиль ещё не создан: $count';
  }

  @override
  String get adminInbox => 'Обращения';

  @override
  String adminAwaiting(int count) {
    return 'Ждут ответа: $count';
  }

  @override
  String get adminAllStatuses => 'Все';

  @override
  String get adminUsers => 'Пользователи';

  @override
  String get adminAudit => 'Журнал действий';

  @override
  String get adminAuditEmpty => 'Действий пока нет';

  @override
  String get adminSearchHint => 'Поиск по email';

  @override
  String get adminAllRoles => 'Все роли';

  @override
  String get adminAllLanguages => 'Все языки';

  @override
  String get adminShowEmail => 'Показать email (запишется в журнал)';

  @override
  String adminPage(int from, int to, int total) {
    return '$from–$to из $total';
  }

  @override
  String get adminPrev => 'Назад';

  @override
  String get adminNext => 'Далее';

  @override
  String adminRegisteredOn(String date) {
    return 'Регистрация: $date';
  }

  @override
  String adminLastSeen(String date) {
    return 'Последняя активность: $date';
  }

  @override
  String get adminNoUsers => 'Пользователи не найдены';

  @override
  String get adminReplyHint => 'Напишите ответ сами';

  @override
  String get adminSendReply => 'Отправить ответ';

  @override
  String get adminStatus => 'Статус';

  @override
  String get adminActionSupportReply => 'Ответ на обращение';

  @override
  String get adminActionSupportStatus => 'Изменён статус обращения';

  @override
  String get adminActionRevealEmail => 'Просмотрен email';

  @override
  String get adminActionAdminGranted => 'Выданы права администратора';

  @override
  String get adminActionAdminRevoked => 'Отозваны права администратора';

  @override
  String get profileSignIn => 'Войти по email';

  @override
  String get profileSignOut => 'Выйти';

  @override
  String get profileRestartSetup => 'Начать настройку заново';

  @override
  String get profileSignOutTitle => 'Выйти из аккаунта?';

  @override
  String get profileSignOutBody =>
      'Закладки, заметки и результаты тренировок останутся на этом устройстве. Если устройством будет пользоваться кто-то другой, удалите и их.';

  @override
  String get profileSignOutDelete => 'Выйти и удалить';

  @override
  String profileVersion(String version) {
    return 'Версия $version';
  }

  @override
  String get privacyTitle => 'Конфиденциальность и данные';

  @override
  String get privacyBody =>
      'Гость может смотреть главную, список процедур, рабочее место и библиотеку; настройки хранятся на этом устройстве. Для тестов, тренировок, ежедневных вопросов, описаний процедур, групп и «Предложений и помощи» нужен бесплатный аккаунт (код по email, Google или Apple). Тогда данные хранятся в сети Cloudflare (серверы могут находиться за пределами Узбекистана): email — только в виде хеша и маскированного вида, способ входа, роль, язык, время последней активности (до минуты); в группе — псевдоним или порядковый номер, ответы и баллы; тексты обращений и жалоб. От Google/Apple берутся только идентификатор аккаунта и email, токен не хранится. Преподаватель видит только свою группу. Без рекламы, аналитики и отслеживания. Аккаунт можно удалить в любой момент кнопкой «Удалить аккаунт». Полный текст — по ссылке «Политика конфиденциальности».';

  @override
  String get privacyBodyLocal =>
      'В этой сборке сервер не подключён: приложение ничего не отправляет на сервер. Настройки, закладки и результаты тренировок хранятся на этом устройстве (могут попадать в системную резервную копию). Без рекламы и отслеживания.';

  @override
  String get privacyTerms => 'Условия использования';

  @override
  String get privacyTermsSub => 'Правила использования приложения';

  @override
  String get privacyDeleteLocal => 'Удалить локальные данные';

  @override
  String get privacyDeleteLocalSub =>
      'Настройки, закладки, незавершённые тесты и результаты тренировок';

  @override
  String get privacyDeleteConfirmTitle => 'Удалить локальные данные?';

  @override
  String get privacyDeleteConfirmBody =>
      'Настройки, закладки, незавершённые тесты и результаты тренировок на этом устройстве будут удалены. Это нельзя отменить.';

  @override
  String get privacyDeleted => 'Локальные данные удалены';

  @override
  String get termsTitle => 'Условия использования';

  @override
  String get termsFullText => 'Полный текст условий';

  @override
  String get termsFullTextSub => 'На сайте nurseguide.nfcstore.uz';

  @override
  String get termsBody =>
      'NurseGuide — бесплатный справочник и обучающее приложение для медсестёр. Пользуясь приложением, вы соглашаетесь со следующими условиями.\n\n1. Медицинское ограничение. NurseGuide не ставит диагноз, не назначает лечение или лекарства и не заменяет утверждённые процедуры вашего учреждения, инструкции к лекарственным средствам и назначения врача. Под каждым сведением указан источник; принимая решения, опирайтесь на первоисточник и правила своего учреждения.\n\n2. Аккаунт. Для основных функций (тесты, практика, ежедневные вопросы, описания манипуляций, группы, обращения) нужен аккаунт (код по email, Apple или Google). Вы отвечаете за безопасность аккаунта и действия, совершённые через него. Удалить аккаунт можно в любой момент: Профиль → Конфиденциальность и данные → Удалить аккаунт.\n\n3. Группы преподавателя и студентов. Когда студент вступает в группу, преподаватель видит его псевдоним (или порядковый номер) и результаты тестов. Преподаватель использует группу только в учебных целях.\n\n4. Пользовательский контент. Вы отвечаете за то, что пишете в обращениях. Строго запрещены оскорбления, незаконный контент, реклама, чужие персональные данные и интимные изображения без согласия. Такой контент удаляется, аккаунт нарушителя может быть ограничен или удалён.\n\n5. Авторские права. Тексты, слайды, тесты и дизайн приложения принадлежат авторам NurseGuide; внешние источники указаны со своими лицензиями. Их нельзя копировать и распространять в коммерческих целях.\n\n6. Сервис. Приложение предоставляется «как есть»; возможны перебои и ошибки, мы исправляем их как можно скорее. Об изменении условий сообщим в приложении.\n\n7. Конфиденциальность. Как используются ваши данные — в политике конфиденциальности: nurseguide.nfcstore.uz/privacy\n\n8. Связь: nurseguide@nfcstore.uz';

  @override
  String get rightsUnknown => 'Право распространения не подтверждено';

  @override
  String get rightsPersonal =>
      'Только для личного изучения — не распространяется';

  @override
  String get rightsPermitted => 'Разрешение на распространение зафиксировано';

  @override
  String get rightsDenied => 'Распространение не разрешено';

  @override
  String get kindBook => 'Книга';

  @override
  String get kindManual => 'Руководство';

  @override
  String get kindMethod => 'Методика';

  @override
  String get kindArticle => 'Статья';

  @override
  String get kindQuestionSet => 'Сборник вопросов';

  @override
  String get kindWebsite => 'Веб-ресурс';

  @override
  String libAccessOpen(String licence) {
    return 'Открытая лицензия · $licence';
  }

  @override
  String get libAccessFree => 'Бесплатно для чтения · только ссылка';

  @override
  String get libAccessCatalog => 'Только библиографическая запись';

  @override
  String get libOpenSource => 'Открыть официальную страницу';

  @override
  String libChecked(String date) {
    return 'Страница и лицензия проверены: $date';
  }

  @override
  String libItemPack(String size) {
    return 'Офлайн-пакет · $size';
  }

  @override
  String libItemSupersedes(String title) {
    return 'Новое издание. Предыдущее: $title';
  }

  @override
  String get libSearchEntry => 'Поиск: книга, автор, тема';

  @override
  String libBooksCount(int count) {
    return 'Источников: $count · поиск и фильтры';
  }

  @override
  String get libContinueReading => 'Продолжить чтение';

  @override
  String get libSearchLabel => 'Поиск в библиотеке';

  @override
  String get libSearchHint => 'Название, автор, тема…';

  @override
  String get libFilterLanguage => 'Язык';

  @override
  String get libFilterTopic => 'Тема';

  @override
  String get libFilterType => 'Тип';

  @override
  String get libFilterSectionField => 'Направление';

  @override
  String get libFilterSectionGroup => 'Тема';

  @override
  String get libFilterSectionKind => 'Вид материала';

  @override
  String get libFilterSectionOpen => 'Как открывается';

  @override
  String libResultCount(int shown, int total) {
    return 'Материалов: $shown из $total';
  }

  @override
  String get libClearFilters => 'Сбросить';

  @override
  String get libFilteredEmptyTitle => 'По этим фильтрам материалов нет';

  @override
  String get libFilteredEmptyBody =>
      'Уберите один фильтр или попробуйте другое слово — например, фамилию автора.';

  @override
  String get libOpenLink => 'Ссылка · внешний сайт';

  @override
  String libOpenLinkHint(String host) {
    return 'Откроется в браузере: $host';
  }

  @override
  String get libOpenInApp => 'Файл в приложении';

  @override
  String get libOpenInAppHint => 'Читается в приложении — интернет не нужен';

  @override
  String get libOpenDownload => 'Книга для загрузки';

  @override
  String libOpenDownloadHint(String size) {
    return 'После загрузки читается в приложении · $size';
  }

  @override
  String get libOpenPending => 'Ожидается';

  @override
  String get libOpenPendingHint => 'Материал ещё не получен — открыть нельзя';

  @override
  String get libOpenReceivedHint =>
      'Файл получен и проверяется — пока не открывается';

  @override
  String get libOpenRecordHint =>
      'Право на распространение файла не зафиксировано — в приложении не открывается';

  @override
  String get libOpenLinkShort => 'Ссылка';

  @override
  String get libOpenInAppShort => 'В приложении';

  @override
  String get libOpenDownloadShort => 'Для загрузки';

  @override
  String get libOpenRecordShort => 'Только запись';

  @override
  String get libItemRead => 'Читать';

  @override
  String libItemContinue(int page) {
    return 'Продолжить со стр. $page';
  }

  @override
  String get libItemCannotOpen => 'Открыть нельзя';

  @override
  String get libDownloadUnavailable =>
      'Сервер загрузки ещё не подключён — книгу пока нельзя скачать.';

  @override
  String get libDetailsTitle => 'Сведения';

  @override
  String get libFieldAuthors => 'Автор';

  @override
  String get libFieldYear => 'Год';

  @override
  String get libFieldEdition => 'Издание';

  @override
  String get libFieldPublisher => 'Издательство';

  @override
  String get libFieldAccess => 'Доступ';

  @override
  String get libFieldStatus => 'Статус';

  @override
  String get libFieldRights => 'Право на распространение';

  @override
  String libFieldRightsRecorded(String date, String by) {
    return 'Зафиксировано: $date · $by';
  }

  @override
  String get libFieldTopics => 'Темы';

  @override
  String get libFieldPages => 'Страниц';

  @override
  String get libStateNotReceived => 'Ещё не получен';

  @override
  String get libStateReceived => 'Получен, проверяется';

  @override
  String get libStateCataloged => 'Каталогизирован';

  @override
  String get libStateLinked => 'Связан с карточками';

  @override
  String get libStateReviewed => 'Подтверждён преподавателем';

  @override
  String get libProvidedByTeacher => 'Материал от преподавателя';

  @override
  String get libItemNotFound => 'Материал не найден';

  @override
  String get libItemNotFoundBody =>
      'Возможно, пакет контента обновился. Вернитесь в каталог.';

  @override
  String get libItemUnavailable => 'Материал недоступен на вашем языке';

  @override
  String get libItemUnavailableBody =>
      'Этот материал пока есть только на другом языке. Смените язык интерфейса или вернитесь в каталог.';

  @override
  String get libBackToCatalog => 'Вернуться в каталог';

  @override
  String get readerTitle => 'Чтение';

  @override
  String readerPageOf(int page, int total) {
    return '$page из $total';
  }

  @override
  String get readerToc => 'Оглавление';

  @override
  String get readerTocEmpty => 'В этом файле нет оглавления';

  @override
  String get readerTocEmptyBody =>
      'Перейдите на страницу или поставьте закладку в нужном месте.';

  @override
  String get readerBookmarks => 'Закладки';

  @override
  String get readerAddBookmark => 'Добавить закладку';

  @override
  String get readerBookmarkName => 'Название закладки';

  @override
  String get readerBookmarkNameHint => 'Например: важная таблица';

  @override
  String readerBookmarkSaved(int page) {
    return 'Закладка сохранена: стр. $page';
  }

  @override
  String get readerBookmarkRemoved => 'Закладка удалена';

  @override
  String get readerBookmarkRemove => 'Удалить закладку';

  @override
  String get readerBookmarksEmpty => 'Закладок пока нет';

  @override
  String get readerBookmarksEmptyBody =>
      'На нужной странице нажмите «Добавить закладку» — потом вернётесь одним касанием.';

  @override
  String readerPageLabel(int page) {
    return 'Стр. $page';
  }

  @override
  String get readerGoTo => 'Перейти на страницу';

  @override
  String get readerGoToShort => 'Страница';

  @override
  String readerGoToHint(int total) {
    return 'От 1 до $total';
  }

  @override
  String readerGoToError(int total) {
    return 'Введите число от 1 до $total';
  }

  @override
  String get readerGo => 'Перейти';

  @override
  String get readerSave => 'Сохранить';

  @override
  String get readerRenameBookmark => 'Переименовать закладку';

  @override
  String get libFieldProvidedBy => 'От кого';

  @override
  String get libQueryEmptyBody =>
      'Попробуйте другое слово — например, фамилию автора или название темы.';

  @override
  String get readerZoomIn => 'Увеличить';

  @override
  String get readerZoomOut => 'Уменьшить';

  @override
  String readerResumed(int page) {
    return 'Вы остановились на стр. $page';
  }

  @override
  String get readerFromStart => 'С начала';

  @override
  String get readerLoading => 'Открываем файл…';

  @override
  String get readerFileMissing => 'Файл не найден';

  @override
  String get readerFileMissingBody =>
      'Этого файла нет в приложении. Попробуйте обновить приложение.';

  @override
  String get readerFileCorrupted => 'Файл не прошёл проверку';

  @override
  String get readerFileCorruptedBody =>
      'Размер файла или контрольная сумма не совпадают с каталогом — файл мог быть повреждён или подменён, поэтому он не открыт.';

  @override
  String get readerOpenFailed => 'Не удалось открыть PDF';

  @override
  String get readerBlockedTitle => 'Не открывается в приложении';

  @override
  String get readerBlockedRights =>
      'В приложении открываются только файлы с полностью зафиксированным правом на распространение. Для этого материала такого файла нет.';

  @override
  String get readerBookmarkedPage => 'Эта страница в закладках';

  @override
  String get lessonsTitle => 'Темы занятий';

  @override
  String classesSeat(String n) {
    return 'Студент $n';
  }

  @override
  String classesQrLabel(String code) {
    return 'QR кода приглашения: $code';
  }

  @override
  String get classesTeacherRegisterEyebrow => 'Преподаватель';

  @override
  String get classesTeacherRegisterTitle =>
      'Зарегистрируйтесь как преподаватель';

  @override
  String get classesTeacherRegisterBody =>
      'Преподаватель открывает свою группу и видит результаты только своих студентов. Это не права администратора и не влияет на другие группы.';

  @override
  String get classesTeacherRegister => 'Зарегистрироваться как преподаватель';

  @override
  String get classesLocalNameTitle => 'Метка (только на этом устройстве)';

  @override
  String get classesLocalNameBody =>
      'Например, имя студента. Не отправляется на сервер и не видна студенту.';

  @override
  String get classesLocalNameHint => 'Пусто — удалить метку';

  @override
  String get classesLocalNameSave => 'Сохранить';

  @override
  String get classroomPlanTitle => 'Учебный план';

  @override
  String get classroomPlanSub => 'Темы по дням: лекция, опрос, тест';

  @override
  String get classroomTopicsTitle => 'Темы';

  @override
  String get classroomTopicsSub => 'Открытые преподавателем темы и тесты';

  @override
  String get classroomProgramEyebrow => 'Учебная программа';

  @override
  String classroomPlanProgress(int done, int total) {
    return 'Тестов по темам завершено: $done/$total';
  }

  @override
  String get classroomStartNone =>
      'Дата начала не задана — план по порядку дней';

  @override
  String classroomStartAt(String date) {
    return '1-й учебный день: $date';
  }

  @override
  String get classroomStartNote =>
      'Даты примерные (воскресенья пропускаются, праздники не учитываются) и хранятся только на этом устройстве.';

  @override
  String get classroomStartPick => 'Указать дату начала';

  @override
  String classroomDayN(int n) {
    return 'День $n';
  }

  @override
  String classroomWeekN(int n) {
    return 'Неделя $n';
  }

  @override
  String classroomHours(int n) {
    return '$n ч';
  }

  @override
  String get classroomTypeLecture => 'Лекция';

  @override
  String get classroomTypePractical => 'Практика';

  @override
  String get classroomTypeSeminar => 'Семинар';

  @override
  String get classroomTypeAttestation => 'Проверка знаний';

  @override
  String get classroomTypeOther => 'Занятие';

  @override
  String get classroomStatusClosed => 'Не открыта';

  @override
  String get classroomStatusOpened => 'Открыта';

  @override
  String get classroomStatusLectured => 'Пройдена';

  @override
  String get classroomStatusOral => 'Опрос проведён';

  @override
  String get classroomStatusTestRunning => 'Идёт тест';

  @override
  String get classroomStatusTestDone => 'Тест завершён';

  @override
  String get classroomNoCurriculumTitle => 'Учебная программа ещё не добавлена';

  @override
  String get classroomNoCurriculumBody => 'Пока используйте задания группы.';

  @override
  String get classroomCurriculumError =>
      'Не удалось прочитать учебную программу';

  @override
  String get classroomNoTopicsStudent => 'Преподаватель ещё не открыл темы';

  @override
  String get classroomNoTopicsStudentBody =>
      'Когда тема откроется, материалы и тест появятся здесь.';

  @override
  String get classroomTopicTitle => 'Тема';

  @override
  String get classroomTopicMissing => 'Тема не найдена в программе';

  @override
  String get classroomTopicNotOpened => 'Эта тема ещё не открыта';

  @override
  String get classroomOpenNote =>
      'После открытия студенты увидят материалы темы.';

  @override
  String get classroomOpenTopic => 'Открыть студентам';

  @override
  String classroomStep(int n) {
    return 'Этап $n';
  }

  @override
  String get classroomStageLecture => 'Лекция';

  @override
  String get classroomStageLectureBody =>
      'Покажите тему слайдами на большом экране (работает и без интернета).';

  @override
  String get classroomStageOral => 'Устный опрос';

  @override
  String classroomStageOralBody(int count) {
    return 'Список вопросов и план ответа. Задано: $count.';
  }

  @override
  String get classroomStageTest => 'Тест группы';

  @override
  String get classroomStageTestBody =>
      'Выберите вопросы и запустите тест — он сразу откроется у студентов.';

  @override
  String get classroomStageDone => 'Пройдено';

  @override
  String get classroomMarkDone => 'Отметить как пройденное';

  @override
  String get classroomOralOpen => 'Список вопросов';

  @override
  String get classroomTestPrepare => 'Подготовить тест';

  @override
  String get classroomTestResults => 'Панель результатов';

  @override
  String get classroomTestFinish => 'Завершить тест';

  @override
  String get classroomTestFinishTitle => 'Завершить тест?';

  @override
  String get classroomTestFinishBody =>
      'Новые попытки не принимаются. Начавшим остаётся 2 минуты, чтобы отправить ответы.';

  @override
  String classroomTestSubmitted(int done, int total) {
    return 'Сдали: $done/$total';
  }

  @override
  String get classroomTestNotStarted => 'Преподаватель ещё не начал тест.';

  @override
  String get classroomTestOpenStudent => 'Тест открыт — пройти';

  @override
  String get classroomMaterials => 'Материалы темы';

  @override
  String get classroomNoMaterials =>
      'В приложении пока нет материалов по этой теме.';

  @override
  String get classroomGapNote =>
      'Материалов по этой теме в приложении мало — преподаватель дополняет из своих источников.';

  @override
  String get classroomPlanRecommended =>
      'Рекомендованный NurseGuide план практики';

  @override
  String get classroomOralNotice =>
      'Вопросы — автоматически подобранные кандидаты; план ответа — учебная помощь. Отметки «задан» и оценки хранятся только на этом устройстве.';

  @override
  String get classroomOralEmpty => 'Для этой темы нет устных вопросов';

  @override
  String classroomCandidate(int n) {
    return 'Вопрос-кандидат $n';
  }

  @override
  String get classroomOralPlan => 'Краткий план ответа';

  @override
  String get classroomOralNoPlan => 'План ответа ещё не написан.';

  @override
  String get classroomOralAsked => 'Задан';

  @override
  String classroomOralGrade(int count) {
    return 'Оценить студентов ($count)';
  }

  @override
  String get classroomOralGradeTitle => 'Кто как ответил';

  @override
  String get classroomOralGradeNote =>
      'Только на этом устройстве; на сервер не отправляется.';

  @override
  String get classroomGradeKnew => 'Знал';

  @override
  String get classroomGradePartial => 'Частично';

  @override
  String get classroomGradeDidNot => 'Не знал';

  @override
  String get classroomCandidatesNotice =>
      'Вопросы-кандидаты подобраны автоматически. Просмотрите каждый вопрос и его ключ: балл считается на сервере по показанному ключу.';

  @override
  String classroomCandidatesTitle(int picked, int total) {
    return 'Кандидаты · выбрано $picked/$total';
  }

  @override
  String get classroomPickAll => 'Все';

  @override
  String get classroomPickNone => 'Снять';

  @override
  String classroomKeyShown(String answer) {
    return 'Ключ: $answer';
  }

  @override
  String get classroomKeyFlagged => 'Спорный ключ';

  @override
  String get classroomPickAtLeastOne => 'Выберите хотя бы один вопрос';

  @override
  String get classroomPickMax => 'Не более 50 вопросов';

  @override
  String classroomTestStart(int count) {
    return 'Начать тест · $count вопр.';
  }

  @override
  String get classroomTestStarted => 'Тест начат — открыт у студентов';

  @override
  String classroomTestTitle(String topic) {
    return 'Тест: $topic';
  }

  @override
  String get classroomTestAlready => 'Тест по этой теме уже начат';

  @override
  String get classroomTestNoCandidates => 'Для этой темы нет тестовых вопросов';

  @override
  String get classroomTestNoCandidatesBody =>
      'Можно составить задание вручную (Новое задание).';

  @override
  String get lectureTitle => 'Лекция';

  @override
  String get lectureListTitle => 'Режим лекции';

  @override
  String get lectureListSub =>
      'Выберите тему — слайды на большом экране, без интернета';

  @override
  String get lectureStart => 'Начать лекцию';

  @override
  String get lectureClose => 'Закрыть лекцию';

  @override
  String lectureCounter(int current, int total) {
    return '$current / $total';
  }

  @override
  String get lecturePrev => 'Назад';

  @override
  String get lectureNext => 'Далее';

  @override
  String get lectureGoals => 'Цель';

  @override
  String get lectureKeyPoints => 'Ключевые понятия';

  @override
  String lectureQuestionN(int n) {
    return 'Вопрос $n';
  }

  @override
  String get lectureEndEyebrow => 'Дальше';

  @override
  String get lectureEndTitle => 'Опрос и тест';

  @override
  String get lectureEndOral => 'Устный опрос — спрашивает преподаватель';

  @override
  String get lectureEndTest => 'Тест группы — в приложении, на время';

  @override
  String get lectureUzOnly => 'Эта презентация пока только на узбекском языке';

  @override
  String get lectureNotesShow => 'Показать заметки преподавателя';

  @override
  String get lectureNotesHide => 'Скрыть заметки преподавателя';

  @override
  String get lectureTeacherNote => 'Заметка для преподавателя';

  @override
  String get cmAdminDone => 'Готово';

  @override
  String get admYouSuper => 'Вы — владелец (суперадмин)';

  @override
  String get admYouAdmin => 'Вы — администратор';

  @override
  String get adm2faOn =>
      'Двухэтапная защита (2FA) подтверждена. Она требуется для каждого действия администратора.';

  @override
  String get admNotConnected => 'На этом сервере пока не подключено';

  @override
  String get admTeam => 'Управление администраторами';

  @override
  String admTeamCount(int count) {
    return 'Администраторов: $count';
  }

  @override
  String get admTeamSubManage => 'Добавление по email и удаление';

  @override
  String get admTeamSubView => 'Список (изменяет только владелец)';

  @override
  String get admLegacyNote =>
      'Статистика, пользователи и журнал действий ещё не перенесены на этот сервер — они появятся здесь, когда будут готовы.';

  @override
  String get admOther => 'Другие разделы';

  @override
  String get admTeamIntro =>
      'Администратор получает полный доступ ко всем разделам: обращения, пользователи, жалобы. Права выдаёт только сервер, и для каждого действия нужен код 2FA.';

  @override
  String get admTeamOwnerOnly =>
      'Добавлять и удалять администраторов может только владелец (суперадмин).';

  @override
  String get admAddTitle => 'Добавить администратора';

  @override
  String get admAddEmail => 'Email (например, Gmail)';

  @override
  String get admAddHint =>
      'Права вступят в силу, когда человек войдёт с этим email и включит 2FA; если аккаунт уже есть — сразу.';

  @override
  String get admAddButton => 'Сделать администратором';

  @override
  String get admAddConfirmTitle => 'Сделать администратором?';

  @override
  String admAddConfirmBody(String email) {
    return '$email получит полный доступ ко всем разделам администратора. Вы можете удалить его в любой момент.';
  }

  @override
  String admAdded(String email) {
    return 'Добавлен: $email';
  }

  @override
  String get admInvalidEmail => 'Неверный email. Например: name@gmail.com';

  @override
  String get admErrAlready => 'Этот email уже администратор.';

  @override
  String get admErrSuper =>
      'Это email владельца (суперадмин) — он уже администратор.';

  @override
  String admErrTooMany(int max) {
    return 'Лимит администраторов: $max. Сначала удалите кого-нибудь.';
  }

  @override
  String admListTitle(int count) {
    return 'Администраторы ($count)';
  }

  @override
  String get admKindSuper => 'Владелец · суперадмин';

  @override
  String admKindGranted(String date) {
    return 'Админ · добавлен $date';
  }

  @override
  String get admNotSignedIn =>
      'Ещё не входил(а) — права вступят в силу при первом входе';

  @override
  String get admYou => 'Вы';

  @override
  String get admRemove => 'Удалить';

  @override
  String get admRemoveTitle => 'Удалить администратора?';

  @override
  String admRemoveBody(String email) {
    return '$email сразу потеряет права администратора — на всех устройствах. Аккаунт и данные не удаляются.';
  }

  @override
  String admRemoved(String email) {
    return 'Удалён: $email';
  }

  @override
  String get admSuperNote =>
      'Владелец задан в секретной настройке сервера (LG_ADMIN_EMAILS) — из приложения не удаляется.';

  @override
  String get admNoGranted => 'Добавленных администраторов пока нет.';

  @override
  String get adminActionGrantAdded => 'Добавлен администратор';

  @override
  String get adminActionGrantRemoved => 'Администратор удалён';

  @override
  String get contactPrivacyPolicy => 'Политика конфиденциальности';

  @override
  String get autoPresTitle => 'Автоматическая презентация';

  @override
  String get autoPresEntrySub =>
      'Слайды из материалов приложения с источниками';

  @override
  String get autoPresShowAnswer => 'Показать ответ';

  @override
  String get autoPresHideAnswer => 'Скрыть ответ';

  @override
  String get contactRowTitle => 'Контакты и жалобы';

  @override
  String get contactRowSub => 'Вопросы, жалобы, сообщить об ошибке';

  @override
  String get contactTitle => 'Связь';

  @override
  String get contactIntro =>
      'Работает без интернета и аккаунта: письмо отправляется из вашего почтового приложения.';

  @override
  String get contactEmailLabel => 'Электронная почта';

  @override
  String get contactCopy => 'Скопировать адрес';

  @override
  String get contactCopied => 'Адрес скопирован';

  @override
  String get contactNoMailApp =>
      'Не удалось открыть почтовое приложение. Адрес скопирован: отправьте письмо из любой почты.';

  @override
  String get contactQuestionTitle => 'Вопросы и предложения';

  @override
  String get contactQuestionBody =>
      'Задайте вопрос о приложении, предложите тему или улучшение.';

  @override
  String get contactQuestionAction => 'Написать письмо';

  @override
  String get contactReportTitle => 'Жалоба / сообщить об ошибке';

  @override
  String get contactReportBody =>
      'Сообщите о неверных медицинских данных или неуместном пользовательском контенте.';

  @override
  String get contactReportHint =>
      'Укажите в письме раздел или карточку, чтобы мы быстрее нашли.';

  @override
  String get contactReportAction => 'Отправить жалобу';

  @override
  String get contactResponseNote =>
      'Мы читаем каждое сообщение и исправляем подтверждённые ошибки, но не обещаем срок ответа. Этот адрес не предназначен для экстренной медицинской помощи.';

  @override
  String get contactPrivacyNote =>
      'Если вы нам пишете, мы видим ваш адрес и текст письма.';

  @override
  String contactMailBodyQuestion(String version, String platform) {
    return 'Ваш вопрос или предложение:\n\n\n---\nПриложение: NurseGuide $version\nПлатформа: $platform';
  }

  @override
  String contactMailBodyReport(String version, String platform) {
    return 'Раздел / название карточки:\nЧто не так:\n(Не указывайте данные пациентов.)\n\n\n---\nПриложение: NurseGuide $version\nПлатформа: $platform';
  }

  @override
  String get authOr => 'или';

  @override
  String get authSignInApple => 'Войти с Apple';

  @override
  String get authSignInGoogle => 'Войти через Google';

  @override
  String get authSocialFailed =>
      'Не удалось войти. Проверьте соединение и попробуйте ещё раз или войдите по коду из письма.';

  @override
  String get authSocialEmailUnverified =>
      'Email этого аккаунта не подтверждён, поэтому войти с ним нельзя. Войдите по коду из письма.';

  @override
  String get authSocialEmailRequired =>
      'Этот аккаунт не передал адрес email. Войдите по коду из письма.';

  @override
  String get accountDeleteAppleNote =>
      'Вы вошли через Apple, поэтому перед удалением Apple попросит подтверждение. Это также отключит NurseGuide от вашего Apple ID.';

  @override
  String get accountDeleteAppleCancelled =>
      'Ничего не удалено: подтверждение Apple отменено.';

  @override
  String get admPanelAccess =>
      'Доступ: email владельца (ADMIN_EMAILS) и код из письма. Сервер проверяет каждый запрос.';

  @override
  String get admOverview => 'Общие показатели';

  @override
  String admOverviewSub(int total, int online, int week) {
    return 'Зарегистрировано: $total · онлайн: $online · новых за 7 дней: $week';
  }

  @override
  String get admComplaintsRow => 'Жалобы из приложения';

  @override
  String admComplaintsRowSub(int count) {
    return 'Открытые: $count';
  }

  @override
  String admEmailNote(String email) {
    return 'Жалобы и вопросы по email приходят на $email — смотрите их в почте (в приложение они не попадают).';
  }

  @override
  String get admUsersSub => 'Поиск по email или псевдониму, роль, приостановка';

  @override
  String get admAuditSub => 'Каждое действие админа записывается';

  @override
  String get admStoreTitle => 'Загрузки и продажи';

  @override
  String get admStoreBody =>
      'Сервер не видит загрузки из магазинов — их показывают App Store Connect и Google Play Console. В приложении нет аналитических SDK (политика конфиденциальности). Числа в этой панели — аккаунты, подтвердившие email.';

  @override
  String get admSales => 'Продажи: 0 (оплаты пока нет)';

  @override
  String get admAppStoreConnect => 'App Store Connect';

  @override
  String get admPlayConsole => 'Google Play Console';

  @override
  String get admStatsAccounts => 'Аккаунты';

  @override
  String get admOnlineNow => 'Сейчас онлайн (5 минут)';

  @override
  String get admSuspendedAccounts => 'Приостановленные аккаунты';

  @override
  String get admStatsActiveNote =>
      'Онлайн и активные — аккаунты, отправившие запрос на сервер. Хранятся только минута и день; IP и устройство не сохраняются.';

  @override
  String get admChartTitle => 'Новые аккаунты — последние 14 дней';

  @override
  String admChartBar(String date, int count) {
    return '$date: новых аккаунтов — $count';
  }

  @override
  String admChartTotal(int count) {
    return 'Всего за 14 дней: $count';
  }

  @override
  String get admStatsObjects => 'Основные объекты';

  @override
  String get admStatsGroupsCount => 'Группы';

  @override
  String get admStatsTeachers => 'Зарегистрированные преподаватели';

  @override
  String get admStatsStudents => 'Студенты в группах';

  @override
  String get admStatsAssignments => 'Тестовые сессии';

  @override
  String get admStatsResults => 'Результаты тестов';

  @override
  String get admStatsComplaintsOpen => 'Открытые жалобы';

  @override
  String get admStatsComplaintsResolved => 'Решённые жалобы';

  @override
  String get admStatsAwaiting => 'Обращения: ждут ответа';

  @override
  String admStatsUpdated(String time) {
    return 'Обновлено: $time';
  }

  @override
  String get admComplaintsTitle => 'Жалобы из приложения';

  @override
  String get admApple12Note =>
      'Рассматривайте жалобы на неприемлемый контент быстро (Apple 1.2 требует своевременной реакции; цель — 24 часа).';

  @override
  String get admFilterOpen => 'Открытые';

  @override
  String get admFilterResolved => 'Решённые';

  @override
  String get admAllKinds => 'Все типы';

  @override
  String get complaintKindComplaint => 'Жалоба';

  @override
  String get complaintKindInappropriate => 'Неприемлемый контент';

  @override
  String get complaintKindBug => 'Ошибка';

  @override
  String get complaintKindAd => 'Реклама';

  @override
  String get complaintKindOther => 'Другое';

  @override
  String get admComplaintsEmpty => 'В этом списке жалоб нет';

  @override
  String get admComplaintAnon => 'Гость (без аккаунта)';

  @override
  String admComplaintFrom(String email) {
    return 'Отправитель: $email';
  }

  @override
  String admComplaintTarget(String ref) {
    return 'Ссылка: $ref';
  }

  @override
  String get admComplaintNote => 'Заметка админа';

  @override
  String get admComplaintNoteHint => 'Что сделано? (видят только админы)';

  @override
  String get admComplaintSaveNote => 'Сохранить заметку';

  @override
  String get admComplaintResolve => 'Решено';

  @override
  String get admComplaintReopen => 'Открыть снова';

  @override
  String admComplaintResolvedOn(String date) {
    return 'Решено: $date';
  }

  @override
  String get admSaved => 'Сохранено';

  @override
  String get admSearchModeEmail => 'Email';

  @override
  String get admSearchModeName => 'Псевдоним';

  @override
  String get admSearchEmail => 'Полный email (точное совпадение)';

  @override
  String get admSearchName => 'Псевдоним в группе (минимум 2 символа)';

  @override
  String get admUsersSearchNote =>
      'Email не хранится на сервере в открытом виде: аккаунт находится только по полному email и показывается замаскированным.';

  @override
  String get admSearch => 'Искать';

  @override
  String get admStatusActive => 'Активен';

  @override
  String get admStatusSuspended => 'Приостановлен';

  @override
  String get admUserAdminTag => 'Админ';

  @override
  String get admUserTitle => 'Пользователь';

  @override
  String get admUserRole => 'Роль';

  @override
  String get admRoleChanged => 'Роль изменена';

  @override
  String get admRoleSelfNote => 'Свою роль и статус здесь изменить нельзя.';

  @override
  String admUserFacts(int owned, int joined, int threads, int complaints) {
    return 'Группы: $owned (преподаватель) · $joined (студент) · обращения: $threads · жалобы: $complaints';
  }

  @override
  String get admAccountTitle => 'Статус аккаунта';

  @override
  String get admAccountSuspend => 'Приостановить аккаунт';

  @override
  String get admAccountSuspendTitle => 'Приостановить аккаунт?';

  @override
  String get admAccountSuspendBody =>
      'Пользователь выйдет на всех устройствах и не сможет войти снова (код из письма, Google, Apple). Приложение покажет ему контактный адрес. Действие записывается в журнал.';

  @override
  String get admAccountReactivate => 'Восстановить доступ';

  @override
  String get admAccountReactivateTitle => 'Восстановить аккаунт?';

  @override
  String get admAccountReactivateBody =>
      'Пользователь снова сможет войти. Действие записывается в журнал.';

  @override
  String get admAccountAdminNote => 'Аккаунт админа нельзя приостановить.';

  @override
  String get admErrOwner => 'Аккаунт владельца нельзя приостановить.';

  @override
  String get admErrSelf => 'Это действие нельзя применить к себе.';

  @override
  String get admErrName => 'Псевдоним: 2–40 символов.';

  @override
  String admAuditBy(String actor) {
    return 'Исполнитель: $actor';
  }

  @override
  String get admAuditSystem => 'Система';

  @override
  String get adminActionAccountDeleted => 'Аккаунт удалён';

  @override
  String get adminActionMfa => '2FA включена';

  @override
  String get adminActionTeacher => 'Преподаватель зарегистрирован';

  @override
  String get adminActionRoleChanged => 'Роль изменена';

  @override
  String get adminActionAccountSuspended => 'Аккаунт приостановлен';

  @override
  String get adminActionAccountReactivated => 'Аккаунт восстановлен';

  @override
  String get adminActionComplaintNote => 'Добавлена заметка к жалобе';

  @override
  String get adminActionComplaintResolved => 'Жалоба решена';

  @override
  String get adminActionComplaintReopened => 'Жалоба открыта снова';

  @override
  String get adminActionIdentityLinked => 'Привязан способ входа';

  @override
  String get complaintFormTitle => 'Отправить жалобу из приложения';

  @override
  String get complaintFormBody =>
      'Напишите о неприемлемом контенте, ошибке или другой проблеме — команда NurseGuide рассмотрит.';

  @override
  String get complaintKindLabel => 'Тип';

  @override
  String get complaintText => 'Текст';

  @override
  String get complaintTextHint => 'Что случилось? Какой экран или вопрос?';

  @override
  String complaintTarget(String ref) {
    return 'Ссылка: $ref';
  }

  @override
  String get complaintSend => 'Отправить жалобу';

  @override
  String get complaintSent => 'Отправлено. Спасибо — рассмотрим.';

  @override
  String get complaintTooShort => 'Напишите хотя бы 5 символов.';

  @override
  String complaintRateLimited(int minutes) {
    return 'Слишком много отправок: не более 5 в час. Попробуйте через $minutes мин.';
  }

  @override
  String get complaintAnonNote =>
      'Без аккаунта мы не сможем вам ответить. Если нужен ответ — войдите или напишите на email.';

  @override
  String get complaintPhiNote =>
      'Не указывайте имя пациента и другие личные данные.';

  @override
  String get complaintFailed =>
      'Не отправлено. Проверьте интернет и попробуйте снова.';

  @override
  String authAccountSuspended(String email) {
    return 'Ваш аккаунт приостановлен. Если есть вопросы, напишите: $email';
  }

  @override
  String get admSectionComplaints => 'Жалобы';

  @override
  String get lectureSearchLabel => 'Поиск презентаций';

  @override
  String get lectureSearchHint => 'Тема или заголовок слайда';

  @override
  String get lectureFilterAll => 'Все';

  @override
  String get lectureFilterProtocols => 'Практические протоколы';

  @override
  String lectureFilterModule(int n) {
    return 'Модуль $n';
  }

  @override
  String get lectureLangAll => 'Все языки';

  @override
  String lectureDecksCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count презентации',
      many: '$count презентаций',
      few: '$count презентации',
      one: '$count презентация',
    );
    return '$_temp0';
  }

  @override
  String lectureSlidesCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count слайда',
      many: '$count слайдов',
      few: '$count слайда',
      one: '$count слайд',
    );
    return '$_temp0';
  }

  @override
  String lectureSlidesMatch(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count слайда подходят',
      many: '$count слайдов подходят',
      few: '$count слайда подходят',
      one: '$count слайд подходит',
    );
    return '$_temp0';
  }

  @override
  String lectureMoreSlides(int count) {
    return 'ещё $count';
  }

  @override
  String lectureResultsFound(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Найдено $count презентации',
      many: 'Найдено $count презентаций',
      few: 'Найдено $count презентации',
      one: 'Найдена $count презентация',
    );
    return '$_temp0';
  }

  @override
  String get lectureNoResultsTitle => 'Ничего не найдено';

  @override
  String get lectureNoResultsBody =>
      'Попробуйте другое слово или фильтр. Поиск работает по-узбекски (латиница или кириллица), по-русски и по-английски.';

  @override
  String get lectureClearFilters => 'Сбросить поиск и фильтры';

  @override
  String lectureLangFallback(String wanted, String shown) {
    return 'Эта презентация недоступна на языке «$wanted» — показана на языке «$shown»';
  }

  @override
  String get lectureDeckLoadFailed => 'Не удалось открыть презентацию';

  @override
  String get lectureFullscreen => 'Полный экран';

  @override
  String get lectureFullscreenExit => 'Выйти из полноэкранного режима';

  @override
  String get lectureSourcesTitle => 'Источники слайда';

  @override
  String get lectureSourcesOpen => 'Показать источники полностью';

  @override
  String lectureSourcesCount(int count) {
    return 'Источники: $count';
  }

  @override
  String lectureSourceLocator(String loc) {
    return 'Раздел/страница: $loc';
  }

  @override
  String get lectureSourcesHint =>
      'Полный список — на последнем слайде «Литература».';

  @override
  String get lectureRotateTitle =>
      'Повернуть экран горизонтально (альбомная ориентация)?';

  @override
  String get lectureRotateBody =>
      'В альбомной ориентации слайд займёт весь экран. «Нет» — экран не поворачивается, слайд показывается в текущей ориентации.';

  @override
  String get lectureRotateCastBody =>
      'Телевизоры и мониторы горизонтальные: для трансляции рекомендуется альбомная ориентация.';

  @override
  String get lectureRotateYes => 'Да';

  @override
  String get lectureRotateNo => 'Нет';

  @override
  String get lectureRotateRemember => 'Больше не спрашивать';

  @override
  String get lectureOrientationMenu => 'Ориентация экрана при показе';

  @override
  String get lectureOrientationAsk => 'Всегда спрашивать';

  @override
  String get lectureOrientationLandscape => 'Всегда горизонтально';

  @override
  String get lectureOrientationKeep => 'Не поворачивать';

  @override
  String get lectureMore => 'Другие действия';

  @override
  String get lectureCast => 'Вывести на экран';

  @override
  String get lectureCastTitle => 'Показ на телевизоре или мониторе';

  @override
  String get lectureCastHow =>
      'Показ работает через встроенное в телефон «дублирование экрана»: на телевизоре виден экран телефона. В режиме показа на экране только слайд (без кнопок), экран не гаснет.';

  @override
  String get lectureCastStepsAndroid =>
      '1. Телефон и телевизор должны быть в одной сети Wi‑Fi.\n2. Откройте «Трансляцию экрана» (Cast, Smart View, Miracast — зависит от телефона) и выберите телевизор.\n3. Вернитесь в приложение и нажмите «Начать показ».';

  @override
  String get lectureCastStepsIos =>
      '1. iPhone/iPad и телевизор (Apple TV или с поддержкой AirPlay) должны быть в одной сети Wi‑Fi.\n2. Откройте Пункт управления (свайп вниз от правого верхнего угла) → «Повтор экрана» → выберите телевизор.\n3. Вернитесь в приложение и нажмите «Начать показ».';

  @override
  String get lectureCastOpenSettings => 'Открыть настройки трансляции';

  @override
  String get lectureCastSettingsFailed =>
      'Не удалось открыть настройки — найдите «Трансляцию экрана» в настройках или в быстрой панели.';

  @override
  String get lectureCastStart => 'Начать показ';

  @override
  String get lecturePresenter => 'Режим докладчика';

  @override
  String get lecturePresenterNext => 'Следующий слайд';

  @override
  String get lecturePresenterLast => 'Это последний слайд';

  @override
  String get lecturePresenterTimer => 'Время';

  @override
  String get lecturePresenterReset => 'Сбросить время';

  @override
  String get lecturePresenterNote =>
      'Режим докладчика — только на этом устройстве. При трансляции телевизор покажет то же самое (дублирование экрана) — для зрителей используйте «Полный экран».';

  @override
  String get topicTestAction => 'Тест по теме';

  @override
  String get topicTestPreparing => 'Теста по этой теме нет';

  @override
  String get topicTestPreparingShort => 'Теста нет';

  @override
  String topicTestPreparingBody(int count) {
    return 'В тест входят только проверенные вопросы. По этой теме их $count — нужно не меньше 3.';
  }

  @override
  String topicTestIntro(int count) {
    return 'Вопросов: $count · после каждого ответа — правильный ответ и пояснение';
  }

  @override
  String get topicTestSavedNote =>
      'Если выйдете, ответы сохранятся — продолжите с того же места.';

  @override
  String get topicTestSourcesNote =>
      'Вопросы только из проверенных источников: официальные вопросы с подтверждённым ключом и учебные вопросы с указанным источником.';

  @override
  String get topicTestStart => 'Начать тест';

  @override
  String topicTestBest(int score, int total) {
    return 'Лучший результат: $score/$total';
  }

  @override
  String topicTestBadgeLabel(int score, int total) {
    return 'Тест по теме, лучший результат $score из $total';
  }

  @override
  String get topicTestRetake => 'Пройти заново';

  @override
  String get topicTestNextTopic => 'Следующая тема';

  @override
  String get topicTestOpenSlide => 'Открыть слайд';

  @override
  String get topicTestOpenDeckStart => 'Открыть презентацию с начала';

  @override
  String get topicTestHistory => 'История результатов';

  @override
  String get topicTestAssign => 'Задать группе';

  @override
  String topicTestLimitBody(int minutes) {
    return 'Каждому студенту даётся $minutes мин с момента начала. Когда время выйдет, ответы отправятся сами.';
  }

  @override
  String get topicTestLimitNoneBody =>
      'Без ограничения времени — студент решает тест в любое время до срока.';

  @override
  String get topicTestOpenFor => 'Сколько тест открыт';

  @override
  String get topicTestAssignSub =>
      'Студенты подключаются по QR или коду, результаты видите вы';

  @override
  String get topicTestSelf => 'Пройти самому';

  @override
  String get topicTestSelfSub =>
      'Сохраняется только у вас, студентам не отправляется';

  @override
  String get topicTestAssignIntro =>
      'Студенты сдают тест на своём телефоне до срока; балл считается на сервере.';

  @override
  String get topicTestGroups => 'Группы';

  @override
  String get topicTestNoGroups => 'У вас пока нет групп';

  @override
  String get topicTestNoGroupsBody =>
      'Сначала создайте группу и пригласите студентов — затем задайте тест отсюда.';

  @override
  String get topicTestPickGroup => 'Выберите хотя бы одну группу';

  @override
  String get topicTestReveal => 'Правильные ответы студенту';

  @override
  String get topicTestRevealNow => 'Сразу после сдачи';

  @override
  String get topicTestRevealAfterDue => 'После срока';

  @override
  String get topicTestRevealNeedsDue => 'Для «После срока» выберите срок сдачи';

  @override
  String topicTestSent(int count) {
    return 'Тест отправлен, групп: $count';
  }

  @override
  String topicTestTitle(String title) {
    return 'Тест по теме: $title';
  }

  @override
  String get topicTestSentList => 'Отправленные тесты';

  @override
  String topicTestAnswersLater(String date) {
    return 'Правильные ответы откроются после срока ($date) или когда преподаватель завершит тест';
  }

  @override
  String get topicTestDistribution => 'Распределение результатов';

  @override
  String get topicTestHardest => 'Самые трудные вопросы';

  @override
  String get topicTestAssignedTitle => 'Заданные тесты';

  @override
  String get topicTestMenu => 'Действия';

  @override
  String get topicTestOpenLecture => 'Открыть презентацию';

  @override
  String get topicTestCreateGroup => 'Создать группу';

  @override
  String topicTestStudents(int count) {
    return 'Студентов: $count';
  }

  @override
  String topicTestReworkMistakes(int count) {
    return 'Повторить ошибки · $count';
  }

  @override
  String get admDeleteTitle => 'Удаление аккаунта';

  @override
  String get admDeleteNote =>
      'Для запросов на удаление, пришедших по email (выполняется в течение 30 дней). Для подтверждения введите полный email пользователя — сервер проверит, что он принадлежит именно этому аккаунту. Аккаунт, участие в группах, обращения и способы входа удаляются полностью; если пользователь входил через Apple, сервер попытается отозвать токен Apple. Отменить нельзя; действие записывается в журнал.';

  @override
  String get admDeleteEmail => 'Полный email пользователя';

  @override
  String get admDeleteButton => 'Удалить аккаунт навсегда';

  @override
  String get admDeleteConfirmTitle => 'Удалить аккаунт навсегда?';

  @override
  String admDeleteConfirmBody(String email) {
    return 'Аккаунт $email и все связанные с ним данные будут удалены. Это действие нельзя отменить.';
  }

  @override
  String get admDeleteDone => 'Аккаунт удалён';

  @override
  String get admDeleteMismatch =>
      'Этот email не принадлежит этому аккаунту — проверьте и введите снова.';

  @override
  String get examPracticeNotice =>
      'Результат — для внутренней тренировки, это не официальная оценка.';

  @override
  String get classesPasteLink => 'Вставить ссылку';

  @override
  String get classesPasteNoCode =>
      'В скопированном тексте нет кода приглашения. Скопируйте ссылку или код от преподавателя.';

  @override
  String get classesScanTip =>
      'Отсканируйте QR-код камерой телефона и нажмите «Открыть в приложении» на открывшейся странице — код подставится сам.';

  @override
  String get qrScanAction => 'Сканировать QR-код';

  @override
  String get qrScanHint =>
      'Наведите рамку на QR-код группы или теста от преподавателя';

  @override
  String get qrScanTorchOn => 'Включить фонарик';

  @override
  String get qrScanTorchOff => 'Выключить фонарик';

  @override
  String get qrScanTypeCode => 'Ввести или вставить код';

  @override
  String get qrScanNotInvite =>
      'Этот QR-код не является приглашением в группу NurseGuide';

  @override
  String get qrScanDeniedTitle => 'Нет доступа к камере';

  @override
  String get qrScanDeniedBody =>
      'Чтобы прочитать QR-код, разрешите NurseGuide доступ к камере в настройках. Кадр обрабатывается только на телефоне — изображение не сохраняется и не отправляется. Или введите код вручную либо вставьте ссылку.';

  @override
  String get qrScanOpenSettings => 'Открыть настройки';

  @override
  String get qrScanFailedTitle => 'Не удалось открыть камеру';

  @override
  String get qrScanFailedBody =>
      'Введите код вручную или вставьте ссылку от преподавателя.';

  @override
  String get qrScanStarting => 'Камера открывается…';

  @override
  String get classesJoinOpensTest =>
      'После вступления сразу откроется тест от преподавателя.';

  @override
  String get classesJoinSignInTitle => 'Войдите, чтобы вступить в группу';

  @override
  String get classesJoinSignInBody =>
      'Через Google, Apple или код на email — это минута. Результат попадёт к преподавателю через этот аккаунт; код приглашения сохранится.';

  @override
  String get classesNicknameTaken =>
      'Этот псевдоним в группе занят — выберите другой.';

  @override
  String get classesNicknameAbusive =>
      'В псевдониме недопустимое слово — выберите другой.';

  @override
  String get classesTestQr => 'QR теста';

  @override
  String get classesTestQrBody =>
      'Студенты сканируют → входят → псевдоним → открывается этот тест. Результаты на этой странице обновляются сами.';

  @override
  String get classesInviteLink => 'Скопировать ссылку';

  @override
  String get classesLiveNote =>
      'Результаты обновляются каждые 10 секунд. Потяните вниз — обновить сейчас.';

  @override
  String get boardOpen => 'Большой экран';

  @override
  String get boardJoined => 'В группе';

  @override
  String get boardStarted => 'Решают';

  @override
  String get boardSubmitted => 'Сдали';

  @override
  String get boardStatusWaiting => 'Ожидание';

  @override
  String get boardStatusSolving => 'Решает…';

  @override
  String get boardScan => 'Сканируйте и вступайте';

  @override
  String get boardAnswersAfterClose =>
      'Правильные ответы покажем после завершения теста.';

  @override
  String get boardEmpty => 'Пока никого — сканируйте QR.';

  @override
  String get boardClose => 'Выйти из большого экрана';

  @override
  String get actionClose => 'Закрыть';

  @override
  String get variantToggle => 'Каждому студенту — свои вопросы';

  @override
  String variantOnBody(int pool, int n) {
    return 'Каждый студент получает $n из $pool вопросов темы — поровну по подтемам.';
  }

  @override
  String get variantOffBody =>
      'Всем одни и те же вопросы (в перемешанном порядке).';

  @override
  String variantDisabledBody(int pool, int need) {
    return 'В теме $pool вопросов — для разных наборов нужно не меньше $need (вдвое больше числа вопросов). Уменьшите число вопросов.';
  }

  @override
  String get variantUnsupported =>
      'Этот сервер не поддерживает вариантные тесты.';

  @override
  String variantPoolTitle(int pool) {
    return 'Пул вопросов ($pool)';
  }

  @override
  String get variantLabel => 'Вариантный тест';

  @override
  String variantPerStudent(int n, int pool) {
    return '$n вопросов каждому из пула в $pool';
  }

  @override
  String variantReceived(int n) {
    return 'Попался $n студентам';
  }

  @override
  String get homeResumeCta => 'Продолжить';

  @override
  String homeResumeBody(String title) {
    return 'Последнее открытое: $title';
  }

  @override
  String get helpTitle => 'Помощь и связь';

  @override
  String get helpSub =>
      'В приложении или по email — вопрос, предложение, жалоба';

  @override
  String get helpIntro =>
      'Выберите удобный способ: переписка в приложении (ответ придёт сюда) или email (жалоба, запрос о конфиденциальности).';

  @override
  String get classesNicknameInvalid =>
      'В псевдониме допустимы только буквы, цифры, пробел и . _ \' -; он должен начинаться и заканчиваться буквой или цифрой (без эмодзи и знаков вроде !?@).';

  @override
  String get classesGroupFull =>
      'Группа заполнена (200 человек) — сообщите преподавателю.';

  @override
  String get classesCodeAmbiguous =>
      'В коде нет символов 0, O, 1 и I. Уточните код у преподавателя или отсканируйте QR.';

  @override
  String get classesOwnGroupTitle => 'Вы преподаватель этой группы';

  @override
  String get classesOwnGroupBody =>
      'Этот аккаунт создал группу, поэтому не может вступить в неё как студент (смена роли в профиле этого не меняет). Чтобы проверить как студент, войдите с другим аккаунтом или пройдите тест в режиме студента.';

  @override
  String get classesOwnGroupOpen => 'Открыть как преподаватель';

  @override
  String get classesSwitchAccount => 'Войти с другим аккаунтом';

  @override
  String get classesPreviewAsStudent => 'Пройти как студент';

  @override
  String get classesPreviewNote =>
      'Пробный режим: ответы не отправляются на сервер и не попадают в результаты.';

  @override
  String classesPreviewResult(int correct, int total) {
    return 'Проба завершена: $correct / $total верно. Результат не отправлен.';
  }

  @override
  String get classesGiveTopicTest => 'Дать тест по теме';

  @override
  String get classesGiveTopicTestSub =>
      'Выберите тему — на следующей странице: число вопросов, варианты, срок и когда открыть ответы.';

  @override
  String get classesTopicSearchHint => 'Поиск темы (например, анемия)';

  @override
  String get classesTopicNoMatch => 'Нет темы с готовым тестом';

  @override
  String classesTopicQuestions(int count) {
    return 'Вопросов: $count';
  }

  @override
  String examDeadlineAt(String date) {
    return 'Срок: $date';
  }

  @override
  String get classesScanAskNick =>
      'Перед вступлением укажите псевдоним — под ним преподаватель увидит ваш результат (необязательно: без него — номер по порядку). Затем «Вступить».';

  @override
  String get classesMyNickname => 'Мой псевдоним';

  @override
  String get classesNoNickname => 'Нет — преподаватель видит ваш номер';

  @override
  String get classesNicknameSaved => 'Псевдоним сохранён';

  @override
  String get classesNicknameNote =>
      'Не пишите настоящее имя. Если оставить пустым — номер по порядку.';

  @override
  String get rolesTeacherRegisterNote =>
      '«Продолжить» зарегистрирует аккаунт как преподавателя: вы управляете только своими группами и видите их результаты (это не права администратора).';

  @override
  String get rolesTeacherSignInNote =>
      'Роль преподавателя доступна только вошедшим в аккаунт. Войдите (email, Google или Apple) — затем выберите роль в Профиле.';

  @override
  String get classesGiveGeneralTest => 'Дать общий тест';

  @override
  String get generalTestSub => 'Из нескольких тем — до 50 вопросов';

  @override
  String get generalTestIntro =>
      'Выберите темы — вопросы распределятся между ними поровну. Студенты сдают тест на своём телефоне, балл считает сервер.';

  @override
  String get generalTestSources => 'Откуда вопросы';

  @override
  String get generalTestSearchHint => 'Найти тему (например, анемия)';

  @override
  String get generalSourceToifa => 'Вопросы на категорию';

  @override
  String get generalSourceToifaSub => 'Официальный список, ключи проверены';

  @override
  String get generalSourceLecture => 'Темы лекций';

  @override
  String get generalSourceLectureSub => 'Весь модуль или отдельный день';

  @override
  String get generalSourcePack => 'По учебным вопросам';

  @override
  String get generalSourcePackSub => 'Вопросы тематических групп';

  @override
  String get generalSourceToifaShort => 'Категория';

  @override
  String get generalSourceLectureShort => 'Лекции';

  @override
  String get generalSourcePackShort => 'Практика';

  @override
  String get generalSelectAll => 'Выбрать все';

  @override
  String get generalAllShort => 'все';

  @override
  String generalDays(int count) {
    return 'Дни · $count';
  }

  @override
  String generalSelected(int topics, int questions) {
    return 'Выбрано тем: $topics · вопросов: $questions';
  }

  @override
  String get generalPickTopic => 'Выберите хотя бы одну тему';

  @override
  String generalTestTitle(String topics) {
    return 'Общий тест: $topics';
  }

  @override
  String get generalTestNameHint => 'Например, 1-й рубежный контроль';

  @override
  String get navProcedures => 'Манипуляции';

  @override
  String get navWorkplace => 'Работа';

  @override
  String get roleNurse => 'Медсестра';

  @override
  String get roleNurseDesc => 'Проверка знаний и манипуляции';

  @override
  String get procTitle => 'Манипуляции';

  @override
  String get procSub => 'Пошаговые практические инструкции';

  @override
  String get procEmptyTitle => 'Манипуляции';

  @override
  String get procEmptyBody => 'Список манипуляций не загрузился.';

  @override
  String get workDirTitle => 'Ваше направление работы';

  @override
  String get workDirHint =>
      'Ежедневные вопросы подбираются под это направление.';

  @override
  String get workDirPick =>
      'Выберите направление — ежедневные вопросы подстроятся под него.';

  @override
  String get workDirNursing => 'Сестринское дело';

  @override
  String get workDirHigher => 'Высшее сестринское дело';

  @override
  String get workDirPatronage => 'Патронаж';

  @override
  String get workDirDmed => 'DMED';

  @override
  String get workTodayDmed =>
      'Сегодня: 5 вопросов и ответов по DMED; ежедневный тест — общие вопросы по сестринскому делу';

  @override
  String get dmedTodayTitle => 'Вопросы DMED на сегодня';

  @override
  String get dmedAll => 'Все вопросы и ответы DMED';

  @override
  String get workTodayOwn => 'Сегодня: вопросы по вашему направлению';

  @override
  String get workTodayGeneral =>
      'Сегодня: общие вопросы (для всех направлений)';

  @override
  String get workTodayMixed =>
      'Сегодня: смешанный набор — 3 по вашему направлению, 2 общих';

  @override
  String get workPlan =>
      'План недели: понедельник–четверг — ваше направление, пятница–суббота — общие вопросы, воскресенье — смешанный набор.';

  @override
  String get procGoal => 'Цель';

  @override
  String get procIndications => 'Показания';

  @override
  String get procContra => 'Противопоказания';

  @override
  String get procEquipment => 'Необходимое оснащение';

  @override
  String get procSteps => 'Шаги';

  @override
  String get procChecklist => 'Чек-лист';

  @override
  String get procRisks => 'Риски и осложнения';

  @override
  String procStepsCount(int count) {
    return '$count шагов';
  }

  @override
  String get procSourceNote =>
      'Сведения подготовлены по учебнику. Сверяйте с действующей инструкцией вашего учреждения и приказами МЗ.';

  @override
  String get procNoteUzText =>
      'Текст шагов на узбекском. По учебнику — сверяйте с действующей инструкцией вашего учреждения и приказами МЗ.';

  @override
  String get procNotFound => 'Манипуляция не найдена';

  @override
  String get glossaryTitle => 'Словарь терминов';

  @override
  String get glossarySub => 'Точные определения из учебника';

  @override
  String glossaryCount(int count) {
    return 'Терминов: $count';
  }

  @override
  String get glossarySearch => 'Поиск термина';

  @override
  String get glossaryNothing => 'Ничего не найдено';

  @override
  String get dmedTitle => 'DMED: вопросы и ответы';

  @override
  String get dmedSub =>
      'Работа в системе DMED: роли, приём, стационар, формы документов';

  @override
  String get dmedSearch => 'Поиск вопроса или ответа';

  @override
  String dmedCount(int count) {
    return 'Вопросов: $count';
  }

  @override
  String get dmedNote =>
      'По тесту из обучающих видео DMED (июнь 2025) и таблице ARGOS MED. Не официальная инструкция: названия кнопок и разделов могут измениться при обновлении системы.';

  @override
  String get dmedShow => 'Показать ответ';

  @override
  String get dmedHide => 'Скрыть ответ';

  @override
  String get dmedAllGroups => 'Все';

  @override
  String litCardsN(int count) {
    return 'Вопросов DMED: $count';
  }

  @override
  String get refUzbekOnly => 'Текст на узбекском языке.';

  @override
  String get workVitalsTitle => 'Жизненные показатели';

  @override
  String get workVitalTemp => 'Температура тела';

  @override
  String get workVitalPulse => 'Пульс';

  @override
  String get workVitalResp => 'Частота дыхания';

  @override
  String get workVitalPerMin => 'в минуту';

  @override
  String get workVitalSource =>
      'Источник: Иномов К.С., «Основы сестринского дела», 4-е изд., Ташкент, 2007, с. 170/173/177 (PDF).';

  @override
  String get litTitle => 'Литература';

  @override
  String get litSub => 'Источники, на которые опираются вопросы и сведения';

  @override
  String get litNote =>
      'Текст книг в приложении не хранится: материалы изложены своими словами, под каждым указан источник.';

  @override
  String get litTextbooks => 'Учебники';

  @override
  String get litOfficial => 'Официальные документы';

  @override
  String get litOpen => 'Источники с открытой лицензией';

  @override
  String get litOther => 'Другие международные источники';

  @override
  String get litMainBadge => 'Основной';

  @override
  String get litRelies => 'Используется';

  @override
  String litQuestionsN(int count) {
    return 'Вопросов: $count';
  }

  @override
  String litProceduresN(int count) {
    return 'Манипуляций: $count';
  }

  @override
  String litTermsN(int count) {
    return 'Терминов: $count';
  }

  @override
  String get litTopics => 'Темы';

  @override
  String get litOpenLink => 'Открыть';

  @override
  String litMore(int count) {
    return 'и ещё $count';
  }

  @override
  String get litLicense => 'Лицензия';

  @override
  String get litDetailEmpty => 'Материалов, опирающихся на этот источник, нет.';

  @override
  String get admByPlatform => 'Платформы';

  @override
  String get admPlatformIos => 'iPhone (iOS)';

  @override
  String get admPlatformAndroid => 'Android';

  @override
  String get admUnknown => 'Неизвестно';

  @override
  String get admByLogin => 'Способ регистрации';

  @override
  String get admLoginEmail => 'Код на email';

  @override
  String get accountRequiredTitle => 'Нужна регистрация';

  @override
  String get accountRequiredBody =>
      'Этот раздел только для зарегистрированных: тесты, практика, ежедневные вопросы, описания манипуляций, термины и вопросы по DMED. Вход через Apple или email бесплатный и занимает минуту.';

  @override
  String get accountRequiredCta => 'Войти или зарегистрироваться';

  @override
  String get accountRequiredHome => 'На главную';

  @override
  String get workTitle => 'Рабочее место';

  @override
  String get workSub => 'Справочное для рабочей смены';

  @override
  String get hubGoLearn => 'Перейти к обучению';

  @override
  String get homeHeroNurseTitle => 'Проверка знаний и компетенций';

  @override
  String get homeHeroNurseBody =>
      'Тест, устные ответы и ежедневная практика — в одном месте.';

  @override
  String get homeHeroNurseCta => 'Начать проверку';

  @override
  String get homeTileToifa => 'Тест, устный билет и ошибки';

  @override
  String get homeTileProcedures => 'Пошаговые инструкции';

  @override
  String get homeTileWorkplace => 'Быстрая справка на смену';

  @override
  String get featureLessons => 'Уроки';

  @override
  String get homeTileLessons => 'Презентации лекций';

  @override
  String get catFundamentals => 'Основы';

  @override
  String get catClinicalNursing => 'Клиническое сестринское дело';

  @override
  String get catProcedures => 'Манипуляции';

  @override
  String get catPharmacology => 'Фармакология';

  @override
  String get catExams => 'Экзамены и проверка знаний';

  @override
  String get kindGuideline => 'Клиническое руководство';

  @override
  String get rolesTeacherLocked => 'Только для вошедших в аккаунт';

  @override
  String get rolesTeacherPlanLabel => 'Нужен план «Учитель» или «Специалист»';

  @override
  String get rolesTeacherFailed =>
      'Сервер не подтвердил роль преподавателя. Проверьте интернет и повторите.';

  @override
  String get toifaTopicOther => 'Другое';

  @override
  String get lectureUnverifiedNotice =>
      'Презентация ещё не прошла проверку — просмотрите содержание перед занятием';

  @override
  String get classroomKindProtocol => 'Презентация';

  @override
  String get lectureProtocols => 'Готовые презентации';

  @override
  String get quizEmptyTitle => 'Вопросы не найдены';

  @override
  String get quizEmptyBody =>
      'Вопросы не загрузились. Откройте приложение заново.';

  @override
  String get profileFontSize => 'Размер текста';

  @override
  String get fontSizeSmall => 'Мелкий';

  @override
  String get fontSizeNormal => 'Обычный';

  @override
  String get fontSizeLarge => 'Крупный';

  @override
  String get fontSizeXLarge => 'Очень крупный';

  @override
  String get profileFeedback => 'Звук и вибрация';

  @override
  String get profileHaptics => 'Вибрация';

  @override
  String get profileSounds => 'Звуки';

  @override
  String get welcomeBenefitNurseTitle => 'Медсестре';

  @override
  String get welcomeBenefitNurseBody =>
      'Тесты знаний, устные билеты и манипуляции';

  @override
  String get welcomeBenefitStudentTitle => 'Студенту';

  @override
  String get welcomeBenefitStudentBody => 'Уроки, тесты с разбором и экзамен';

  @override
  String get welcomeBenefitTeacherTitle => 'Преподавателю';

  @override
  String get welcomeBenefitTeacherBody => 'Группы, задания и большой экран';

  @override
  String get actionSave => 'Сохранить';

  @override
  String get actionUnsave => 'Убрать из сохранённых';

  @override
  String get toifaEmptyTitle => 'Вопросы не найдены';

  @override
  String get toifaEmptyBody =>
      'Вопросы не загрузились. Откройте приложение заново.';

  @override
  String get paywallTitle => 'NurseGuide Pro';

  @override
  String get paywallLocked => 'Этот раздел входит в подписку.';

  @override
  String get paywallLead =>
      'Тесты, режим экзамена, устные билеты и другие учебные разделы для подготовки к экзамену.';

  @override
  String get paywallTrial =>
      '30 дней бесплатно с первого входа на этом устройстве и аккаунте (один раз). Затем выберите план. Отменить можно в любой момент.';

  @override
  String get planStudent => 'Студент';

  @override
  String get planSpecialist => 'Специалист';

  @override
  String get planTeacher => 'Преподаватель';

  @override
  String get planStudentDesc => 'Тесты, практика, режим экзамена, сохранённое';

  @override
  String get planSpecialistDesc =>
      'Всё из плана «Преподаватель», плюс вопросы DMED и глоссарий';

  @override
  String get planTeacherDesc =>
      'Всё из плана «Студент», плюс группы и результаты';

  @override
  String get periodMonthly => 'в месяц';

  @override
  String get periodYearly => 'в год';

  @override
  String get paywallStart => 'Оформить подписку';

  @override
  String get paywallRestore => 'Восстановить покупки';

  @override
  String get paywallLegal =>
      'Подписка автоматически продлевается в конце каждого периода (месяц или год), если вы не отмените её не позднее чем за 24 часа. Оплата списывается с вашего аккаунта App Store или Google Play; управлять подпиской и отменять её можно в настройках подписок магазина.';

  @override
  String get paywallTerms => 'Условия использования';

  @override
  String get paywallPrivacy => 'Политика конфиденциальности';

  @override
  String get paywallUnavailable =>
      'Магазин недоступен. Проверьте соединение и повторите попытку.';

  @override
  String get paywallError => 'Покупка не выполнена.';

  @override
  String get paywallActive => 'Подписка активна.';

  @override
  String get paywallCurrentPlan => 'Текущий план';

  @override
  String get paywallFreeNote =>
      'Бесплатно: главная, манипуляции и ежедневные вопросы.';

  @override
  String get paywallBack => 'На главную';

  @override
  String get paywallProfileRow => 'Подписка';

  @override
  String get studyOnlyNote =>
      'Учебный материал для подготовки к экзамену. Не для лечения и клинических решений: следуйте действующим инструкциям вашего учреждения.';

  @override
  String get adminPro => 'Pro-подписки';

  @override
  String get adminProSub => 'Выдать или снять Pro для любого email';

  @override
  String get adminProEmail => 'Email пользователя';

  @override
  String get adminProDays => 'Дней (пусто = без срока)';

  @override
  String get adminProGive => 'Выдать Pro';

  @override
  String get adminProRemove => 'Снять Pro';

  @override
  String get adminProDone => 'Сохранено';

  @override
  String get adminProInvalid =>
      'Введите корректный email и, если нужно, число дней.';

  @override
  String adminProUntil(String date) {
    return 'до $date';
  }

  @override
  String get adminProForever => 'без срока';

  @override
  String get rolesTeacherNeedsPlan =>
      'Для роли преподавателя нужен план «Преподаватель» или «Специалист» (Профиль → Подписка).';

  @override
  String paywallTrialActive(String date) {
    return 'Бесплатный период до $date';
  }

  @override
  String get paywallRestored => 'Покупки восстановлены.';

  @override
  String get paywallNothingToRestore =>
      'Покупки для восстановления не найдены.';

  @override
  String get examNoQuestions => 'Сейчас нет доступных вопросов для экзамена.';

  @override
  String get workDirObstetrics => 'Акушерство';

  @override
  String get workDirRadiology => 'Рентген-лаборант';
}
