create table if not exists patient_profiles (
  id uuid primary key default gen_random_uuid(),
  owner_profile_id uuid references profiles(id) on delete set null,
  full_name text not null,
  birth_date date,
  sex text check (sex in ('male', 'female', 'other', 'unknown')),
  phone text,
  blood_group text,
  allergies text,
  chronic_conditions text,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create index if not exists patient_profiles_owner_idx
on patient_profiles(owner_profile_id);

create trigger patient_profiles_set_updated_at
before update on patient_profiles
for each row execute function set_updated_at();

create table if not exists patient_provider_links (
  id uuid primary key default gen_random_uuid(),
  patient_id uuid not null references patient_profiles(id) on delete cascade,
  practitioner_profile_id uuid not null references practitioner_profiles(id) on delete cascade,
  organization_id uuid references organizations(id) on delete set null,
  granted_by_profile_id uuid references profiles(id) on delete set null,
  reason text,
  starts_at timestamptz not null default now(),
  ends_at timestamptz,
  is_active boolean not null default true,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create index if not exists patient_provider_links_patient_idx
on patient_provider_links(patient_id);

create index if not exists patient_provider_links_practitioner_idx
on patient_provider_links(practitioner_profile_id);

create trigger patient_provider_links_set_updated_at
before update on patient_provider_links
for each row execute function set_updated_at();

create table if not exists encounters (
  id uuid primary key default gen_random_uuid(),
  patient_id uuid not null references patient_profiles(id) on delete restrict,
  practitioner_profile_id uuid not null references practitioner_profiles(id) on delete restrict,
  organization_id uuid references organizations(id) on delete set null,
  status encounter_status not null default 'draft',
  started_at timestamptz not null default now(),
  ended_at timestamptz,
  chief_complaint text,
  notes text,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create index if not exists encounters_patient_idx
on encounters(patient_id, started_at desc);

create index if not exists encounters_practitioner_idx
on encounters(practitioner_profile_id, started_at desc);

create trigger encounters_set_updated_at
before update on encounters
for each row execute function set_updated_at();

create table if not exists encounter_diagnoses (
  id uuid primary key default gen_random_uuid(),
  encounter_id uuid not null references encounters(id) on delete cascade,
  code text,
  title text not null,
  note text,
  is_primary boolean not null default false,
  created_by_profile_id uuid references profiles(id) on delete set null,
  created_at timestamptz not null default now()
);

create index if not exists encounter_diagnoses_encounter_idx
on encounter_diagnoses(encounter_id);

alter table patient_profiles enable row level security;
alter table patient_provider_links enable row level security;
alter table encounters enable row level security;
alter table encounter_diagnoses enable row level security;
