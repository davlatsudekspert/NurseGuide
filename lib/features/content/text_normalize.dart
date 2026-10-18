/// Qidiruv uchun matnni normallashtirish: kichik harf, o'zbekcha
/// apostrof variantlari (‘ ’ ʻ ʼ ` ') olib tashlanadi, ё → е, defis va
/// tinish belgilari bo'shliqqa aylanadi, bo'shliqlar siqiladi.
String normalizeForSearch(String input) {
  var s = input.toLowerCase();
  s = s.replaceAll(RegExp('[‘’ʻʼ`\'´]'), '');
  s = s.replaceAll('ё', 'е');
  s = s.replaceAll(RegExp(r'[\-‐–—_/,.;:()\[\]·]+'), ' ');
  s = s.replaceAll(RegExp(r'\s+'), ' ').trim();
  return s;
}

/// O'zbek kirill yozuvidagi so'rovni lotinga o'giradi (matnlar o'zbekcha
/// lotin yozuvida): “ўқитувчи” → “oqituvchi”. Apostroflar [normalizeForSearch]
/// da baribir olib tashlanadi (ғ → g, ў → o).
String uzCyrillicToLatin(String input) {
  const map = {
    'а': 'a',
    'б': 'b',
    'в': 'v',
    'г': 'g',
    'ғ': 'g',
    'д': 'd',
    'е': 'e',
    'ё': 'yo',
    'ж': 'j',
    'з': 'z',
    'и': 'i',
    'й': 'y',
    'к': 'k',
    'қ': 'q',
    'л': 'l',
    'м': 'm',
    'н': 'n',
    'о': 'o',
    'ў': 'o',
    'п': 'p',
    'р': 'r',
    'с': 's',
    'т': 't',
    'у': 'u',
    'ф': 'f',
    'х': 'x',
    'ҳ': 'h',
    'ц': 's',
    'ч': 'ch',
    'ш': 'sh',
    'щ': 'sh',
    'ъ': '',
    'ы': 'i',
    'ь': '',
    'э': 'e',
    'ю': 'yu',
    'я': 'ya',
  };
  final out = StringBuffer();
  final lower = input.toLowerCase();
  for (var i = 0; i < lower.length; i++) {
    final ch = lower[i];
    final wordStart =
        i == 0 || !RegExp(r'[\p{L}]', unicode: true).hasMatch(lower[i - 1]);
    // So'z boshidagi “е” — “ye” (ер → yer).
    if (ch == 'е' && wordStart) {
      out.write('ye');
    } else {
      out.write(map[ch] ?? ch);
    }
  }
  return out.toString();
}

final _cyrillic = RegExp('[а-яёўқғҳ]');

/// Normallashtirilgan so'rovning variantlari: kirillcha so'rov ruscha
/// nomlar bilan o'zicha, o'zbekcha (lotin) nomlar bilan esa lotinga
/// o'girilgan holda solishtiriladi.
Set<String> searchVariants(String normalized) => {
  normalized,
  if (_cyrillic.hasMatch(normalized))
    normalizeForSearch(uzCyrillicToLatin(normalized)),
  ?_ruStem(normalized),
};

final _ruEnding = RegExp('[ьйаяыиеуюо]\$');

/// Ruscha so'rovning oxirgi unlisi/“ь” qirqilgan varianti: “печень” →
/// “печен” (“Стеатоз печени”), “глюкоза” → “глюкоз” (“глюкозы”). Faqat
/// 5+ harfli so'rovda — qisqa so'rovlar shovqin bermasin.
String? _ruStem(String q) {
  if (q.length < 5 || !_ruEnding.hasMatch(q)) return null;
  return q.substring(0, q.length - 1);
}
