# Supabase

Medos uchun Supabase PostgreSQL migrationlari shu papkada yuradi.

## Tuzilma

```text
supabase/
  migrations/
    202607030001_enable_extensions_and_enums.sql
    ...
```

## Muhim
- Production schema faqat migration orqali o'zgaradi.
- RLS barcha bemor/tibbiy tablelarda yoqiladi.
- Backend service-role bilan yozadi, lekin frontend access uchun policylar alohida ko'rib chiqiladi.
- GitHub integration production branch `main` va working directory `.` orqali ulanadi.

## Tekshiruv

```powershell
powershell -ExecutionPolicy Bypass -File scripts\check_backend_foundation.ps1
```
