create table if not exists profiles (
  id uuid primary key references auth.users(id) on delete cascade,
  display_name text not null,
  phone text,
  role app_role not null,
  locale text not null default 'uz',
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create trigger profiles_set_updated_at
before update on profiles
for each row execute function set_updated_at();

create table if not exists organizations (
  id uuid primary key default gen_random_uuid(),
  type organization_type not null,
  name text not null,
  legal_name text,
  phone text,
  address text,
  location geography(point, 4326),
  is_active boolean not null default true,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create index if not exists organizations_location_idx
on organizations using gist (location);

create trigger organizations_set_updated_at
before update on organizations
for each row execute function set_updated_at();

create table if not exists organization_members (
  id uuid primary key default gen_random_uuid(),
  organization_id uuid not null references organizations(id) on delete cascade,
  profile_id uuid not null references profiles(id) on delete cascade,
  role app_role not null,
  title text,
  starts_at timestamptz not null default now(),
  ends_at timestamptz,
  is_active boolean not null default true,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  unique (organization_id, profile_id, role)
);

create index if not exists organization_members_profile_idx
on organization_members(profile_id);

create trigger organization_members_set_updated_at
before update on organization_members
for each row execute function set_updated_at();

create table if not exists practitioner_profiles (
  id uuid primary key default gen_random_uuid(),
  profile_id uuid not null unique references profiles(id) on delete cascade,
  specialty text,
  license_number text,
  bio text,
  is_public boolean not null default false,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create trigger practitioner_profiles_set_updated_at
before update on practitioner_profiles
for each row execute function set_updated_at();

alter table profiles enable row level security;
alter table organizations enable row level security;
alter table organization_members enable row level security;
alter table practitioner_profiles enable row level security;
