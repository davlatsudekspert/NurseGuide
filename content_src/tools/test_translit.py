import unittest, re
from uz_translit import cyr_to_lat, normalize_uz_latin, fix_homoglyphs, normalize_apostrophes

class T(unittest.TestCase):
    def test_basic(self):
        self.assertEqual(cyr_to_lat('Ҳамшира'), 'Hamshira')
        self.assertEqual(cyr_to_lat('қўл ювиш'), "qo'l yuvish")
        self.assertEqual(cyr_to_lat('ғишт'), "g'isht")
    def test_special_letters(self):
        self.assertEqual(cyr_to_lat('чой шакар'), 'choy shakar')
        self.assertEqual(cyr_to_lat('юрак'), 'yurak')
        self.assertEqual(cyr_to_lat('ёш'), 'yosh')
        self.assertEqual(cyr_to_lat('яра'), 'yara')
        self.assertEqual(cyr_to_lat('съезд'), "s'yezd")
        self.assertEqual(cyr_to_lat('маъно'), "ma'no")
        self.assertEqual(cyr_to_lat('маьно'), "ma'no")  # soft sign typo used as tutuq
    def test_e_rule(self):
        self.assertEqual(cyr_to_lat('Европа'), 'Evropa')
        self.assertEqual(cyr_to_lat('гигиена'), 'gigiyena')
        self.assertEqual(cyr_to_lat('биоетика'), 'bioetika')
        self.assertEqual(cyr_to_lat('електрокардиография'), 'elektrokardiografiya')
        self.assertEqual(cyr_to_lat('эмас'), 'emas')
        self.assertEqual(cyr_to_lat('етика'), 'etika')
        self.assertEqual(cyr_to_lat('бемор'), 'bemor')
    def test_medical_terms(self):
        self.assertEqual(cyr_to_lat('инфекцияли'), 'infeksiyali')
        self.assertEqual(cyr_to_lat('Инфекция'), 'Infeksiya')
        self.assertEqual(cyr_to_lat('обьект'), 'obyekt')
        self.assertEqual(cyr_to_lat('маьлумот'), "ma'lumot")
        self.assertEqual(cyr_to_lat('пациентни'), 'patsiyentni')
        self.assertEqual(cyr_to_lat('операция'), 'operatsiya')
        self.assertEqual(cyr_to_lat('нитроглицерин'), 'nitrogliserin')
        self.assertEqual(cyr_to_lat('тўғри ѐзиш'), "to'g'ri yozish")
    def test_ts(self):
        self.assertEqual(cyr_to_lat('станция'), 'stantsiya')
    def test_case(self):
        self.assertEqual(cyr_to_lat('Шифокор'), 'Shifokor')
        self.assertEqual(cyr_to_lat('ШИФОКОР'), 'SHIFOKOR')
        self.assertEqual(cyr_to_lat('Чегара'), 'Chegara')
        self.assertEqual(cyr_to_lat('Ўзбекистон'), "O'zbekiston")
        self.assertEqual(cyr_to_lat('ЎЗБЕК'), "O'ZBEK")
    def test_mixed_and_digits(self):
        self.assertEqual(cyr_to_lat('1. САД 12 мг'), '1. SAD 12 mg')
        self.assertEqual(cyr_to_lat('Latin text қолади'), 'Latin text qoladi')
    def test_no_cyrillic_left(self):
        s = cyr_to_lat('Ўзбекистон Республикасида ҳамширалик иши: қўлни ювиш ғ ъ ь ы э ю я ё ц')
        self.assertIsNone(re.search('[Ѐ-ӿ]', s))
    def test_apostrophes(self):
        for ch in '’‘ʻʼ`´′':
            self.assertEqual(normalize_apostrophes('o%sz' % ch), "o'z")
    def test_homoglyphs(self):
        self.assertEqual(fix_homoglyphs('F.Naytingeуl'), 'F.Naytingeyl')   # Cyrillic у
        self.assertEqual(fix_homoglyphs('Bаzеdоv'), 'Bazedov')               # Cyrillic а е о
        self.assertEqual(fix_homoglyphs('Ҳамшира'), 'Ҳамшира')               # pure Cyrillic untouched
    def test_normalize_latin(self):
        self.assertEqual(normalize_uz_latin('To’xtamatova o‘z'), "To'xtamatova o'z")

if __name__ == '__main__': unittest.main()
