create table if not exists clinical_protocols (
  id uuid primary key default gen_random_uuid(),
  slug text not null unique,
  title text not null,
  body text not null,
  version integer not null default 1,
  is_active boolean not null default true,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create trigger clinical_protocols_set_updated_at
before update on clinical_protocols
for each row execute function set_updated_at();

create table if not exists notifications (
  id uuid primary key default gen_random_uuid(),
  profile_id uuid references profiles(id) on delete cascade,
  patient_id uuid references patient_profiles(id) on delete cascade,
  channel notification_channel not null,
  title text not null,
  body text not null,
  payload jsonb not null default '{}'::jsonb,
  scheduled_at timestamptz,
  sent_at timestamptz,
  read_at timestamptz,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create index if not exists notifications_profile_time_idx
on notifications(profile_id, created_at desc);

create index if not exists notifications_scheduled_idx
on notifications(scheduled_at)
where sent_at is null;

create trigger notifications_set_updated_at
before update on notifications
for each row execute function set_updated_at();

create table if not exists telegram_accounts (
  id uuid primary key default gen_random_uuid(),
  profile_id uuid references profiles(id) on delete cascade,
  telegram_user_id bigint not null unique,
  username text,
  first_name text,
  last_name text,
  linked_at timestamptz,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create index if not exists telegram_accounts_profile_idx
on telegram_accounts(profile_id);

create trigger telegram_accounts_set_updated_at
before update on telegram_accounts
for each row execute function set_updated_at();

alter table clinical_protocols enable row level security;
alter table notifications enable row level security;
alter table telegram_accounts enable row level security;
