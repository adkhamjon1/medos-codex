# Medos Backend Architecture

## Asosiy Qaror
Medos boshidan bitta backend va ko'p frontend prinsipida quriladi.

Frontendlar:
- Medos Android/iOS Flutter app.
- Medos web app yoki mavjud `medos.html`.
- Tibbiy Yaqin Telegram mini app.
- Klinikalar CRM paneli.
- Kelajakdagi admin panel.

Backend:
- Bitta API qatlam.
- Supabase PostgreSQL asosiy ma'lumotlar bazasi.
- Cloudflare Pages statik web hosting uchun.
- Cloudflare Workers yoki shunga teng API runtime bitta backend servis sifatida.

```text
Flutter Android/iOS       medos.html / web       Telegram Mini App
          \                    |                       /
           \                   |                      /
            v                  v                     v
                  Medos Backend API
                         |
                         v
                 Supabase PostgreSQL
```

## Nega To'g'ridan-To'g'ri Supabase Emas
Mobil va web ilovalar Supabase bilan bevosita ishlashi mumkin, lekin tibbiy platforma uchun markaziy API xavfsizroq:
- doza va retsept biznes qoidalari bitta joyda turadi;
- role/permission tekshiruvi markazlashadi;
- audit logni majburiy qilish osonlashadi;
- Telegram, push, SMS kabi notification providerlar frontendga ochilmaydi;
- keyingi integratsiyalar uchun contract buzilmaydi.

## Domain Chegaralari
- `identity`: user profile, role, auth mapping.
- `organizations`: klinika, filial, xodimlar.
- `care`: bemor, qabul, diagnoz, kuzatuv.
- `prescribing`: retsept, dori jadvali, qabul tasdig'i.
- `catalog`: dorilar, formalar, protokollar.
- `notifications`: reminder, push/telegram/sms/email queue.
- `integrations`: Telegram mini app va tashqi tizim identifikatorlari.
- `audit`: kim, qachon, nimani ko'rdi yoki o'zgartirdi.

## Auth Va Access
- Supabase Auth asosiy identity provider bo'ladi.
- Backend har so'rovda user tokenini tekshiradi.
- DB darajasida RLS yoqiladi.
- Backend service-role credential faqat serverda saqlanadi.
- Tibbiy ma'lumotlar uchun audit majburiy.

## Migration Strategiyasi
Migrationlar ko'p bo'lishi kutiladi. Shuning uchun:
- barcha schema o'zgarishi faqat `supabase/migrations` orqali;
- production DB'ga qo'l bilan table/column qo'shilmaydi;
- migration fayl nomi monoton vaqt prefiksi bilan boshlanadi;
- bitta migration bitta mantiqiy o'zgarish qiladi;
- destructive change oldin expand/contract usuli bilan qilinadi;
- hotfix ham alohida migration bo'ladi.

## Environmentlar
- `local`: ishlab chiqish.
- `dev`: jamoaviy test.
- `staging`: release oldi tekshiruv.
- `production`: real foydalanuvchilar.

Har environment alohida Supabase project yoki alohida DB bo'lishi kerak. Production credential local fayllarga yozilmaydi.

## Boshlang'ich Oqim
1. Tibbiyot xodimi qabul ochadi.
2. Bemor kartasi tanlanadi yoki yaratiladi.
3. `encounter` yaratiladi.
4. Diagnoz qo'shiladi.
5. Retsept va dori jadvali yoziladi.
6. Notification queue dori vaqtlarini yaratadi.
7. Bemor qabul qilganini tasdiqlaydi.
8. Shifokor adherence va kuzatuvni ko'radi.

## Tibbiy Yaqin Bilan Kelajakdagi Birlashuv
Hozir Tibbiy Yaqin alohida ishlaydi. Medos esa alohida boshlanadi.
Lekin ikkisi keyin birlashishi uchun:
- user identity model umumiy bo'ladi;
- Telegram user mapping alohida tableda turadi;
- shifokor, klinika, bemor profillari umumiy platformaga moslanadi;
- joylashuv/radius e'lonlari keyin `marketplace` domainiga ajratiladi.
