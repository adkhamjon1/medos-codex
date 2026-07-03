# Medos Memory

## Maqsad
- Medos uchun Flutter asosida Android APK tayyorlash.
- Ilova shifokor ishida tezkor yordamchi bo'lishi kerak: bemor ma'lumotlari, dori dozasi hisoblash, retsept, protokollar va offline ishlash kabi funksiyalar bosqichma-bosqich qo'shiladi.
- Katta yo'nalish: Tibbiy Yaqin, Medos mobile/web va kelajakdagi klinika CRM bitta backend platformaga suyanadi.

## Hozirgi holat
- Workspace: `C:\Users\drrak\Documents\Medos`
- Flutter project yaratildi. Project nomi: `medos`; org/application id: `uz.medos.medos`.
- Android va iOS platform papkalari bor, ya'ni loyiha boshidan cross-platform tuzilgan.
- Flutter stable 3.44.4 Puro orqali o'rnatildi: `C:\Users\drrak\.puro\envs\stable\flutter`.
- Git for Windows o'rnatildi.
- Temurin JDK 17 o'rnatildi: `C:\Program Files\Eclipse Adoptium\jdk-17.0.19.10-hotspot`.
- Android Studio o'rnatildi.
- Android SDK command-line tools o'rnatildi: `C:\Users\drrak\AppData\Local\Android\Sdk`.
- Android SDK platform/build-tools o'rnatildi: API 36, build-tools 36.1.0 va 36.0.0, platform-tools.
- Android SDK license'lari qabul qilindi.
- `flutter doctor` Android toolchain bo'yicha yashil. Faqat Flutter/Dart PATH warningi va Windows desktop uchun Visual Studio yo'qligi qolgan; Android APK build uchun bu to'siq emas.
- Doimiy APK fayl: `C:\Users\drrak\Documents\Medos\builds\medos.apk`.
- Hozirgi APK Medos MVP ekranlarini ko'rsatadi: doza hisoblash, retsept va protokollar.
- iOS uchun shu Flutter kodi ishlatiladi, lekin `.ipa` build qilish Windows'da mumkin emas; macOS + Xcode kerak bo'ladi.
- Backend fundamenti boshlandi:
  - bitta backend API, ko'p frontend prinsipi qabul qilindi;
  - Supabase PostgreSQL asosiy DB sifatida tanlandi;
  - Cloudflare Pages web hosting, Cloudflare Workers yoki shunga teng serverless runtime API uchun ko'zda tutiladi;
  - migrationlar `supabase/migrations` ichida yuradi;
  - hujjatlar `docs/backend-architecture.md`, `docs/migrations.md`, `docs/api-contract.md` ichida.

## Qilingan ishlar
- Workspace tarkibi tekshirildi.
- Flutter mavjudligi tekshirildi.
- `memory.md` yaratildi. Keyingi ishlarda kodni boshidan o'qib vaqt/token sarflamaslik uchun holat va reja shu faylga yozib boriladi.
- Git, JDK 17, Android Studio, Puro va Flutter stable o'rnatildi.
- Medos Flutter project yaratildi.
- Android SDK command-line tools va kerakli SDK paketlari o'rnatildi.
- Release APK build qilindi.
- `builds\medos.apk` yaratildi. Keyingi buildlarda yangi nomli APK berilmaydi, shu faylning o'zi almashtiriladi.
- `scripts\build_android_apk.ps1` qo'shildi. Bu script release APK build qilib, natijani `builds\medos.apk` ustidan yozadi.
- Default Flutter counter app olib tashlandi.
- `lib\main.dart` Medos MVP ga almashtirildi:
  - pastki navigatsiya: Hisob, Retsept, Protokol;
  - vazn, yosh, mg/kg va kunlik qabul soni kiritiladi;
  - bir martalik va kunlik doza hisoblanadi;
  - retsept matni avtomatik tuziladi;
  - boshlang'ich protokollar ro'yxati bor.
- `test\widget_test.dart` Medos ekranlari va hisob-kitob natijalarini tekshiradigan qilib yangilandi.
- `dart format`, `flutter analyze`, `flutter test` muvaffaqiyatli o'tdi.
- APK qayta build qilindi va `C:\Users\drrak\Documents\Medos\builds\medos.apk` fayli yangilandi.
- Backend foundation qo'shildi:
  - `backend/README.md`;
  - `backend/.env.example`;
  - `supabase/README.md`;
  - 6 ta boshlang'ich Supabase migration;
  - `scripts/check_backend_foundation.ps1`.
- Migrationlarda boshlang'ich domainlar bor:
  - identity/profile/role;
  - organization/clinic/member;
  - practitioner/patient/access link;
  - encounter/diagnosis;
  - medication catalog/form;
  - prescription/item/schedule/intake event;
  - protocols;
  - notifications;
  - telegram account mapping;
  - audit events;
  - RLS baseline va access helper functionlar.
- `scripts\check_backend_foundation.ps1` muvaffaqiyatli o'tdi: 6 migration tekshirildi.

## Reja
1. Supabase CLI/project ulash va migrationlarni local/dev DB'da yuritib tekshirish.
2. RLS policylarini real role workflow bo'yicha kuchaytirish.
3. Backend API implementatsiyasini boshlash: auth middleware, patient, encounter, prescription endpointlari.
4. Dori bazasini aniq preparatlar bilan to'ldirish.
5. Har bir dori uchun maksimal kunlik doza, forma, konsentratsiya va ogohlantirishlarni qo'shish.
6. Protokollarni real klinik matnlar bilan kengaytirish.
7. Flutter/mobile va `medos.html`ni bitta API'ga ulash.
8. Android APK build qilish va `builds\medos.apk` faylini almashtirish.
9. iOS build uchun keyin macOS + Xcode muhitida tekshirish.

## Ishlash qoidasi
- Har katta o'zgarishdan keyin shu fayl yangilanadi.
- Kodni to'liq qayta o'qishdan oldin avval shu fayldagi holat, qilingan ishlar va rejalar ko'riladi.
- Agar kod va `memory.md` orasida farq chiqsa, kod haqiqat manbasi hisoblanadi, lekin `memory.md` darhol yangilanadi.
