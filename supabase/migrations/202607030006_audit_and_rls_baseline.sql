create table if not exists audit_events (
  id uuid primary key default gen_random_uuid(),
  actor_profile_id uuid references profiles(id) on delete set null,
  actor_role app_role,
  action text not null,
  entity_table text not null,
  entity_id uuid,
  patient_id uuid references patient_profiles(id) on delete set null,
  metadata jsonb not null default '{}'::jsonb,
  ip_address inet,
  user_agent text,
  created_at timestamptz not null default now()
);

create index if not exists audit_events_patient_time_idx
on audit_events(patient_id, created_at desc);

create index if not exists audit_events_actor_time_idx
on audit_events(actor_profile_id, created_at desc);

alter table audit_events enable row level security;

create or replace function current_profile_id()
returns uuid
language sql
stable
as $$
  select auth.uid();
$$;

create or replace function is_platform_admin()
returns boolean
language sql
stable
as $$
  select exists (
    select 1
    from profiles
    where id = auth.uid()
      and role = 'platform_admin'
  );
$$;

create or replace function owns_patient(target_patient_id uuid)
returns boolean
language sql
stable
as $$
  select exists (
    select 1
    from patient_profiles
    where id = target_patient_id
      and owner_profile_id = auth.uid()
  );
$$;

create or replace function can_access_patient(target_patient_id uuid)
returns boolean
language sql
stable
as $$
  select
    owns_patient(target_patient_id)
    or exists (
      select 1
      from patient_provider_links ppl
      join practitioner_profiles pp on pp.id = ppl.practitioner_profile_id
      where ppl.patient_id = target_patient_id
        and pp.profile_id = auth.uid()
        and ppl.is_active = true
        and (ppl.ends_at is null or ppl.ends_at > now())
    )
    or is_platform_admin();
$$;

create policy profiles_select_self_or_admin
on profiles for select
using (id = auth.uid() or is_platform_admin());

create policy profiles_update_self
on profiles for update
using (id = auth.uid())
with check (id = auth.uid());

create policy patient_profiles_select_access
on patient_profiles for select
using (can_access_patient(id));

create policy patient_profiles_update_owner_or_admin
on patient_profiles for update
using (owner_profile_id = auth.uid() or is_platform_admin())
with check (owner_profile_id = auth.uid() or is_platform_admin());

create policy encounters_select_patient_access
on encounters for select
using (can_access_patient(patient_id));

create policy encounter_diagnoses_select_patient_access
on encounter_diagnoses for select
using (
  exists (
    select 1 from encounters e
    where e.id = encounter_diagnoses.encounter_id
      and can_access_patient(e.patient_id)
  )
);

create policy prescriptions_select_patient_access
on prescriptions for select
using (can_access_patient(patient_id));

create policy prescription_items_select_patient_access
on prescription_items for select
using (
  exists (
    select 1 from prescriptions p
    where p.id = prescription_items.prescription_id
      and can_access_patient(p.patient_id)
  )
);

create policy medication_schedules_select_patient_access
on medication_schedules for select
using (can_access_patient(patient_id));

create policy medication_intake_events_select_patient_access
on medication_intake_events for select
using (can_access_patient(patient_id));

create policy catalog_medications_read_active
on medication_catalog for select
using (is_active = true or is_platform_admin());

create policy catalog_forms_read
on medication_forms for select
using (
  exists (
    select 1 from medication_catalog m
    where m.id = medication_forms.medication_id
      and (m.is_active = true or is_platform_admin())
  )
);

create policy protocols_read_active
on clinical_protocols for select
using (is_active = true or is_platform_admin());

create policy notifications_select_owner
on notifications for select
using (profile_id = auth.uid() or is_platform_admin());

create policy telegram_accounts_select_owner
on telegram_accounts for select
using (profile_id = auth.uid() or is_platform_admin());

create policy audit_events_select_admin_only
on audit_events for select
using (is_platform_admin());
