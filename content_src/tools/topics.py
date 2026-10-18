import re, json, collections
TOPICS = {
 'infection_control': r"infeksi|dezinfeks|sterilizats|aseptik|antiseptik|qo'l yuv|qo'lni yuv|qo'lqop|niqob|chiqindi|izolyats|gepatit|oits|\boiv\b|ichki kasalxona|kvarsla|avtoklav|quruq issiq|xloramin|xlorli|yuqumli|himoya vosit|zararsizlan|bakteritsid|sanitariya",
 'patronage': r"patronaj|xonadonga|oila hamshira|oilaviy hamshira|yangi tug'ilgan|chaqaloq|ona va bola|go'dak|homilador",
 'iv_access': r"tomir ichi|venoz|muolaj|tomir ichiga|venepunk|venopunk|infuzi|kateter|tomchi|v/i\b|vena\b|venaga|tomirga|qon quyish|transfuz",
 'injection': r"inyeksi|in'eksi|ineksi|ukol|dori yuborish|yuborish usul|teri ostiga|teri ichiga|mushak orasiga|mushak ichiga|shprits|igna|m/o\b|t/o\b|t/i\b|emlash|vaksina",
 'vital_signs': r"arterial bosim|qon bosim|puls|nafas olish soni|nafas harakat|harorat|termometr|tonometr|saturats|tana harorati|yurak urish|nafas chastota|bosimni o'lcha",
}
RX = {k: re.compile(v) for k, v in TOPICS.items()}
def topics_of(r):
    txt = (r['q'] + ' ' + ' '.join(r['options'])).lower()
    stem = r['q'].lower()
    return [k for k, rx in RX.items() if rx.search(stem) or len(rx.findall(txt)) >= 2]
if __name__ == '__main__':
    tot = collections.Counter(); per = {}
    for b in ('141', '142', '138'):
        rows = json.load(open(f'content/bank_{b}.json')); c = collections.Counter()
        for r in rows:
            for t in topics_of(r): c[t] += 1
        per[b] = c; print(b, dict(c))
