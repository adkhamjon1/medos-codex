create table if not exists medication_catalog (
  id uuid primary key default gen_random_uuid(),
  generic_name text not null,
  brand_name text,
  atc_code text,
  default_dose_mg_per_kg numeric(10, 3),
  max_daily_dose_mg numeric(10, 3),
  contraindications text,
  warnings text,
  is_active boolean not null default true,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create index if not exists medication_catalog_generic_idx
on medication_catalog using gin (to_tsvector('simple', generic_name));

create trigger medication_catalog_set_updated_at
before update on medication_catalog
for each row execute function set_updated_at();

create table if not exists medication_forms (
  id uuid primary key default gen_random_uuid(),
  medication_id uuid not null references medication_catalog(id) on delete cascade,
  form text not null,
  strength_label text,
  concentration_mg_per_ml numeric(10, 3),
  route text,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create trigger medication_forms_set_updated_at
before update on medication_forms
for each row execute function set_updated_at();

create table if not exists prescriptions (
  id uuid primary key default gen_random_uuid(),
  encounter_id uuid not null references encounters(id) on delete cascade,
  patient_id uuid not null references patient_profiles(id) on delete restrict,
  practitioner_profile_id uuid not null references practitioner_profiles(id) on delete restrict,
  status prescription_status not null default 'draft',
  issued_at timestamptz,
  note text,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create index if not exists prescriptions_patient_idx
on prescriptions(patient_id, created_at desc);

create trigger prescriptions_set_updated_at
before update on prescriptions
for each row execute function set_updated_at();

create table if not exists prescription_items (
  id uuid primary key default gen_random_uuid(),
  prescription_id uuid not null references prescriptions(id) on delete cascade,
  medication_id uuid references medication_catalog(id) on delete set null,
  medication_form_id uuid references medication_forms(id) on delete set null,
  custom_medication_name text,
  dose_amount numeric(10, 3) not null,
  dose_unit text not null default 'mg',
  frequency_per_day numeric(10, 3) not null,
  duration_days integer,
  instructions text,
  start_at timestamptz,
  end_at timestamptz,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  check (medication_id is not null or custom_medication_name is not null)
);

create index if not exists prescription_items_prescription_idx
on prescription_items(prescription_id);

create trigger prescription_items_set_updated_at
before update on prescription_items
for each row execute function set_updated_at();

create table if not exists medication_schedules (
  id uuid primary key default gen_random_uuid(),
  prescription_item_id uuid not null references prescription_items(id) on delete cascade,
  patient_id uuid not null references patient_profiles(id) on delete cascade,
  scheduled_at timestamptz not null,
  dose_amount numeric(10, 3) not null,
  dose_unit text not null default 'mg',
  status intake_status not null default 'scheduled',
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create index if not exists medication_schedules_patient_time_idx
on medication_schedules(patient_id, scheduled_at);

create trigger medication_schedules_set_updated_at
before update on medication_schedules
for each row execute function set_updated_at();

create table if not exists medication_intake_events (
  id uuid primary key default gen_random_uuid(),
  schedule_id uuid not null references medication_schedules(id) on delete cascade,
  patient_id uuid not null references patient_profiles(id) on delete cascade,
  status intake_status not null,
  confirmed_at timestamptz not null default now(),
  note text,
  created_by_profile_id uuid references profiles(id) on delete set null,
  created_at timestamptz not null default now()
);

create index if not exists medication_intake_events_schedule_idx
on medication_intake_events(schedule_id, created_at desc);

alter table medication_catalog enable row level security;
alter table medication_forms enable row level security;
alter table prescriptions enable row level security;
alter table prescription_items enable row level security;
alter table medication_schedules enable row level security;
alter table medication_intake_events enable row level security;
