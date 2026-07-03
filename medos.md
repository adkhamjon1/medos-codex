# Medos loyiha yo‘riqnomasi

## Maqsad
Medos - retsept yozish, tashxis tanlash, dori mosligini tekshirish va doza hisoblash uchun klinik yordamchi ilova.

## Asosiy g‘oya
Loyiha kanonik ma’lumot modeli asosida quriladi:
- dorilar dori nomi emas, faol modda va ATC kodi bo‘yicha yuritiladi
- savdo nomlari shu kanonik doriga ulanadi
- tashxislar alohida nomlar bo‘yicha emas, guruh va variantlar bo‘yicha yuritiladi
- bir xil mazmundagi takroriy yozuvlar bitta bazada jamlanadi

## Nega bu kerak
- bir xil tarkibli 50+ dori uchun alohida karta yozmaslik
- bir xil klinik mazmundagi tashxislarni takrorlamaslik
- doza, kontrendikatsiya, o‘zaro ta’sir va protokolni bir joydan boshqarish
- retsept yozishda ogohlantirishlarni avtomatik ko‘rsatish

## Dorilar modeli
Har bir dori uchun kanonik karta quyidagilarni o‘z ichiga oladi:
- ATC kodi
- faol modda yoki faol moddalar kombinatsiyasi
- farmakologik guruh
- dozalash qoidalari
- maksimal sutkalik doza
- yosh va vazn bo‘yicha cheklovlar
- qarshi ko‘rsatmalar
- ehtiyot choralari
- nojo‘ya ta’sirlar
- dori-dori o‘zaro ta’sirlari
- protokolga moslik
- tavsiya darajasi
- ishonchlilik darajasi

Savdo nomlari alohida bo‘lak bo‘lib, kanonik dori kartasiga ulanadi.

## Tashxislar modeli
Har bir tashxis ham guruh asosida yuritiladi:
- asosiy tashxis guruhi
- uning kichik variantlari
- diagnostika tavsiyalari
- davolash protokollari
- gospitalizatsiya mezonlari
- qarshi ko‘rsatmalar
- dori tavsiyalari
- kombinatsiya cheklovlari

Masalan:
- sinusit guruhi
- gaymorit
- frontit
- etmoidit
- pansinusit
- gemisinusit

Bu variantlarning ko‘pi bir xil protokolga ega bo‘ladi, faqat ayrim farqlar bilan yuritiladi.

## Retsept tekshiruvlari
Tizim retsept yozilganda quyidagilarni tekshiradi:
- dori tanlangan tashxisga mosmi
- dori protokolda bor yoki yo‘qmi
- tavsiya darajasi qanday
- ishonchlilik darajasi qanday
- bemorning yoshi va vazniga mos doza hisoblanganmi
- sutkalik maksimal dozadan oshmaganmi
- bir xil farmakologik guruhdan 2 ta dori tanlanmaganmi
- bir-biriga zid dorilar qo‘shilmaganmi
- tashxislar ichida qarshi ko‘rsatma bormi
- kombinatsiya o‘zaro mosmi

## Doza hisoblash qoidalari
Tizim faqat oddiy mg/kg hisoblamaydi. U quyidagilarni ham inobatga oladi:
- bemorning vazni
- bemorning yoshi
- sutkalik mg/kg norma
- qabul soni
- dori shakli
- sirop konsentratsiyasi
- tabletka kuchi
- maksimal sutkalik doza
- minimal tavsiya doza
- yumaloqlash qoidasi
- protokol oralig‘i

Hisoblash ketma-ketligi:
1. sutkalik doza mg da hisoblanadi
2. bu doza qabul soniga bo‘linadi
3. dori shakliga qarab mL yoki tabletka ulushiga aylantiriladi
4. maksimal doza bilan solishtiriladi
5. yumaloqlangan amaliy variant ko‘rsatiladi
6. ogohlantirishlar chiqariladi

Misol:
- vazn: 10 kg
- norma: 40 mg/kg/kun
- sutkalik doza: 400 mg/kun
- qabul soni: 3 mahal
- bir martalik doza: 133.3 mg
- sirop konsentratsiyasi: 156.25 mg/5 mL
- bir martalik hajm: taxminan 4.3 mL

## Ogohlantirish turlari
Quyidagi holatlarda tizim ogohlantirish berishi kerak:
- bir xil guruhdagi dori takrorlansa
- maksimal doza oshsa
- yosh yoki vazn bo‘yicha doza mos kelmasa
- tanlangan dori tashxis protokolida bo‘lmasa
- tashxislar o‘zaro ziddiyatli bo‘lsa
- dori kombinatsiyasi mos bo‘lmasa
- qarshi ko‘rsatma topilsa

## Frontend bo‘linishi
Loyiha quyidagi fayllarga bo‘linadi:
- `medos.html` - sahifa skeleti
- `medos.css` - dizayn
- `medos-core.js` - umumiy holat va yordamchi funksiyalar
- `dorilar.js` - kanonik dori bazasi
- `tashxislar.js` - tashxis guruhi va variantlar
- `retsept.js` - retsept tuzish va tekshirish logikasi
- `sozlamalar.js` - umumiy sozlamalar

## Kodlash tartibi
1. Avval ma’lumot modeli to‘ldiriladi
2. Keyin tashxis va dori o‘zaro bog‘lanadi
3. So‘ng doza hisobi qo‘shiladi
4. Keyin ogohlantirish dvigateli yoziladi
5. Oxirida UI interaktiv qilinadi

## Keyingi ishlar
- dori canonical schema yozish
- tashxis group schema yozish
- Amoksiklav kabi bitta dori misolini to‘ldirish
- Sinusit kabi bitta tashxis guruhini to‘ldirish
- retsept builder mantiqini yozish
- ogohlantirish qoidalarini belgilash

## Sozlamalar bo‘limi
Sozlamalar bo‘limi plitkalar shaklida bo‘ladi:
- Klinikalar
- Shifokorlar
- Dori vositalari shakllari
- Dori guruhlash darajalari
- Yorliqlar va qisqa nomlar
- Qabul yo‘llari
- Protokol darajalari

## Ish mexanizmi
Medos quyidagi qatlamlarda ishlaydi:

### 1. Kanonik ma’lumot qatlami
Bu qatlamda takrorlanmaydigan asosiy ma’lumotlar saqlanadi:
- dori faol modda va ATC asosida
- tashxis guruh va variant asosida
- klinik farmakologik guruh
- klinik terapevtik guruh
- protokol darajasi

### 2. Bog‘langan ma’lumot qatlami
Bu qatlamda kanonik kartalarga ulanadigan qo‘shimcha nomlar bo‘ladi:
- savdo nomlari
- yorliqlar
- qisqa nomlar
- dori shakllari
- qabul yo‘llari

### 3. Ishchi ma’lumot qatlami
Bu qatlamda foydalanuvchi bilan ishlaydigan kundalik ma’lumotlar bo‘ladi:
- bemor ma’lumotlari
- tanlangan tashxislar
- tanlangan dorilar
- hisoblangan doza
- ogohlantirishlar
- retsept matni

## Foydalanuvchi oqimi
Shifokor ishlashi quyidagi tartibda bo‘ladi:
1. bemor ma’lumotlarini kiritadi
2. tashxis guruhidan variant tanlaydi
3. dori yorlig‘i yoki kanonik dorini tanlaydi
4. tizim doza hisoblaydi
5. tizim moslik va xavfsizlikni tekshiradi
6. tizim ogohlantirish beradi
7. retsept tayyor bo‘ladi

## Ogohlantirish logikasi
Tizim quyidagi holatlarda signal beradi:
- bir xil guruhdagi dori takrorlanganda
- maksimal doza oshganda
- yosh yoki vazn bo‘yicha noto‘g‘ri doza chiqsa
- tanlangan dori tashxis protokolida bo‘lmasa
- tashxislar bir-biriga zid bo‘lsa
- dori kombinatsiyasi mos bo‘lmasa
- qarshi ko‘rsatma topilsa

Ogohlantirishlar rang bilan ko‘rsatiladi:
- yashil - mos
- sariq - ehtiyot
- qizil - xavfli

## UI oqimi
Interfeys quyidagicha tuziladi:
- chap panel: bemor va tashxis
- o‘rta panel: dori va doza
- o‘ng panel: ogohlantirishlar va protokol
- past panel: tayyor retsept

## Sozlamalar ichidagi bog‘lanishlar
Sozlamalar bo‘limi quyidagi aloqalarni boshqaradi:
- dori shakli -> qabul yo‘li
- dori shakli -> kanonik dori kartasi
- dori yorlig‘i -> kanonik dori
- guruh -> guruhdagi barcha dorilar
- tashxis guruhi -> variantlar
- tashxis -> tavsiya qilingan dorilar

## Kodga o‘tish tartibi
Loyiha pishgandan keyin kod quyidagi tartibda yoziladi:
1. kanonik data
2. bog‘langan data
3. doza hisoblash
4. ogohlantirish tekshiruvi
5. retsept builder
6. UI interaktivligi

### Dori vositalari shakllari
Bu bo‘limda dori shakli va qabul yo‘li bir-biriga bog‘lanadi.
Masalan:
- sirop → ichish
- tabletka → ichish
- kapsula → ichish
- tomchi → ko‘zga yoki og‘izga
- inyeksiya → mushak ichiga yoki vena ichiga

Har bir shakl ochilganda shu shaklga mos dropdown ro‘yxati chiqadi.
Bu ro‘yxat dorilar bazasidagi kanonik dori formalariga ulanadi.

### Dori guruhlash darajalari
Dorilar uchun bir nechta guruhlash darajalari bo‘ladi:
- klinik farmakologik guruh
- klinik terapevtik guruh
- ATC yoki faol modda guruhi
- shakl bo‘yicha guruh
- qabul yo‘li bo‘yicha guruh

Bu guruhlashlar orqali tizim:
- bir xil guruhdagi dorilarni topadi
- takroriy dori berilishini ogohlantiradi
- mos bo‘lmagan kombinatsiyani ko‘rsatadi

### Yorliqlar va qisqa nomlar
Har bir doriga qisqa yorliq yoki klinik belgi biriktiriladi.
Masalan:
- Antibiotik
- Quloq tomchisi
- Burun spreyi
- Og‘riq qoldiruvchi
- Allergiya vositasi
- Antibiotik + beta-laktamaza ingibitori

Bu yorliqlar retsept yozayotganda shifokorga tez tushunish uchun kerak bo‘ladi.
Tizim dori nomi qaysi ekanligini shifokor yozgan qisqa yorliqdan ham anglay oladi.

### Shifokorlar uchun reka ro‘yxati
Shifokorlar uchun alohida reka ro‘yxat bo‘ladi.
Bu ro‘yxat:
- tez yoziladigan dori yorliqlari
- tayyor klinik iboralar
- ko‘p ishlatiladigan preparatlar
- mos tavsiyalar

Masalan:
- Antibiotik
- Quloq tomchisi
- Sinusit uchun dori
- Bolalar siropi
- Allergik rinit vositasi

Shifokor retsept yozayotganda shu ro‘yxatdan tez tanlaydi,
tizim esa uning orqasida qaysi kanonik dori turishini biladi.
