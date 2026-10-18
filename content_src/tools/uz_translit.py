"""Uzbek Cyrillic -> Latin (1995 alphabet, o'/g' with ASCII apostrophe) and text normalisation."""
import re

APOS = "'"
_APOS_RE = re.compile("[’‘ʻʼ`´′ʹ]")
# Cyrillic letters that look like Latin ones (found inside Latin text of the source PDFs)
_HOMOGLYPH = {'а': 'a', 'е': 'e', 'о': 'o', 'р': 'p', 'с': 'c', 'у': 'y', 'х': 'x', 'к': 'k', 'і': 'i',
              'А': 'A', 'В': 'B', 'Е': 'E', 'К': 'K', 'М': 'M', 'Н': 'H', 'О': 'O', 'Р': 'P', 'С': 'C', 'Т': 'T', 'Х': 'X', 'У': 'Y'}
_VOWELS = set('аеёиоуўэюяАЕЁИОУЎЭЮЯ')
_VOWELS_LC = set('аеёиоуўэюя')
INITIAL_E = 'e'  # the source banks type 'е' for 'э' (emas, etika); use 'ye' only via exceptions
_BASE = {'а': 'a', 'б': 'b', 'в': 'v', 'г': 'g', 'д': 'd', 'ж': 'j', 'з': 'z', 'и': 'i', 'й': 'y', 'к': 'k', 'л': 'l',
         'м': 'm', 'н': 'n', 'о': 'o', 'п': 'p', 'р': 'r', 'с': 's', 'т': 't', 'у': 'u', 'ф': 'f', 'х': 'x', 'ч': 'ch',
         'ш': 'sh', 'э': 'e', 'ю': 'yu', 'я': 'ya', 'ё': 'yo', 'ў': "o'", 'ғ': "g'", 'қ': 'q', 'ҳ': 'h', 'ы': 'i',
         'ц': 'ts', 'ъ': "'", 'ь': '', 'ґ': 'g', 'ӯ': "o'"}
# whole-word medical/loan exceptions (lower-case Cyrillic -> Latin); extended after manual review
EXCEPTIONS = {'нитроглицерин': 'nitrogliserin', 'акроцианоз': 'akrosianoz', 'катьиян': "qat'iyan", 'израел': 'Isroil',
              'остеомиелит': 'osteomielit', 'пиелонефрит': 'pielonefrit', 'пиелонефтит': 'pielonefrit'}
_PREFIX = (('обьект', 'obyekt'), ('субьект', 'subyekt'), ('коньюнкт', 'konyunkt'), ('инфекц', 'infeks'), ('реакц', 'reaks'), ('инъекц', 'inyeks'))


def normalize_apostrophes(s: str) -> str:
    return _APOS_RE.sub(APOS, s)


def fix_homoglyphs(s: str) -> str:
    """Replace Cyrillic look-alikes inside words that also contain Latin letters."""
    def fix(m):
        w = m.group(0)
        if re.search('[A-Za-z]', w) and re.search('[Ѐ-ӿ]', w):
            return ''.join(_HOMOGLYPH.get(c, c) for c in w)
        return w
    return re.sub(r"[\w']+", fix, s)


def _word(w: str) -> str:
    low = w.lower()
    for pre, rep in _PREFIX:
        if low.startswith(pre):
            rest = _word(w[len(pre):]) if len(w) > len(pre) else ''
            return (rep[:1].upper() + rep[1:] if w[:1].isupper() else rep) + (rest if low[len(pre):] else '')
    if low in EXCEPTIONS:
        r = EXCEPTIONS[low]
        return r.upper() if w.isupper() and len(w) > 1 else (r[:1].upper() + r[1:] if w[:1].isupper() else r)
    out = []
    upper_word = len(w) > 1 and w.isupper()
    for i, ch in enumerate(w):
        lo = ch.lower()
        if lo == 'е':
            prev = w[i - 1].lower() if i else ''
            if i == 0:
                lat = INITIAL_E
            elif prev == 'о':
                lat = 'e'
            else:
                lat = 'ye' if (prev in _VOWELS_LC or prev in 'ъь') else 'e'
        elif lo == 'ѐ':
            lat = 'yo'
        elif lo == 'ь' and 0 < i < len(w) - 1:
            lat = "'"  # in this source soft sign stands for tutuq belgisi
        elif lo in _BASE:
            lat = _BASE[lo]
        else:
            out.append(ch); continue
        if ch != lo and lat:  # upper-case source letter
            lat = lat.upper() if upper_word else lat[0].upper() + lat[1:]
        out.append(lat)
    return ''.join(out)


def cyr_to_lat(text: str) -> str:
    text = normalize_apostrophes(text)
    return re.sub(r"[Ѐ-ӿ]+(?:'[Ѐ-ӿ]+)*", lambda m: _word(m.group(0)), text)


def normalize_uz_latin(text: str) -> str:
    return fix_homoglyphs(normalize_apostrophes(text))
