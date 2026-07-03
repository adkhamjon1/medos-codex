create extension if not exists pgcrypto;
create extension if not exists postgis;

do $$
begin
  create type app_role as enum (
    'patient',
    'doctor',
    'nurse',
    'clinic_admin',
    'platform_admin'
  );
exception
  when duplicate_object then null;
end $$;

do $$
begin
  create type organization_type as enum (
    'clinic',
    'hospital',
    'pharmacy',
    'education',
    'platform'
  );
exception
  when duplicate_object then null;
end $$;

do $$
begin
  create type encounter_status as enum (
    'draft',
    'active',
    'completed',
    'cancelled'
  );
exception
  when duplicate_object then null;
end $$;

do $$
begin
  create type prescription_status as enum (
    'draft',
    'active',
    'completed',
    'cancelled'
  );
exception
  when duplicate_object then null;
end $$;

do $$
begin
  create type intake_status as enum (
    'scheduled',
    'taken',
    'missed',
    'skipped'
  );
exception
  when duplicate_object then null;
end $$;

do $$
begin
  create type notification_channel as enum (
    'app',
    'telegram',
    'sms',
    'email',
    'push'
  );
exception
  when duplicate_object then null;
end $$;

create or replace function set_updated_at()
returns trigger
language plpgsql
as $$
begin
  new.updated_at = now();
  return new;
end;
$$;
