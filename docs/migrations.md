# Migration Qoidalari

## Fayl Nomi
Format:

```text
YYYYMMDDHHMM_short_description.sql
```

Misol:

```text
202607030001_enable_extensions_and_enums.sql
202607030002_create_identity_tables.sql
```

## Qoidalar
- Migration hech qachon edit qilinmaydi, agar u boshqa environmentga qo'llangan bo'lsa.
- Xato migration keyingi tuzatish migrationi bilan to'g'rilanadi.
- Destructive o'zgarishlar bosqichma-bosqich qilinadi:
  1. yangi column/table qo'shish;
  2. appni yangi fieldga o'tkazish;
  3. data backfill;
  4. eski fieldni keyingi release'da olib tashlash.
- Har tableda imkon qadar `id`, `created_at`, `updated_at` bo'ladi.
- Tibbiy ma'lumot o'zgarishlari auditga tushadi.
- RLS default deny prinsipida yoziladi.

## Tavsiya Etilgan Buyruqlar
Supabase CLI o'rnatilgandan keyin:

```powershell
supabase init
supabase start
supabase migration new create_medical_core
supabase db reset
supabase db push
```

## Migration Tekshiruv Checklist
- Foreign keylar bor.
- Indekslar bor.
- RLS yoqilgan.
- Policy yoki backend-only izohi bor.
- Audit kerak bo'lgan tablelar aniqlangan.
- Personal/tibbiy ma'lumotlar plaintext notificationga chiqmaydi.
