# Medos Backend

Bu papka bitta backend API uchun joy.

Reja:
- runtime: Cloudflare Workers yoki Node-compatible edge/serverless;
- DB: Supabase PostgreSQL;
- frontendlar: Flutter mobile, web, Telegram mini app, CRM panel;
- migrationlar: `supabase/migrations`.

Hozircha bu yerda contract va deployment qarorlari saqlanadi. API implementatsiya keyingi bosqichda qo'shiladi.

## Environment Variables

```text
SUPABASE_URL=
SUPABASE_SERVICE_ROLE_KEY=
SUPABASE_ANON_KEY=
TELEGRAM_BOT_TOKEN=
JWT_AUDIENCE=
APP_ENV=local
```

Service role key faqat backendda bo'ladi. Mobil yoki web frontend ichiga qo'yilmaydi.
