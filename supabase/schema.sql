-- Boodschappen — schema (Supabase-project lkzxkovpswyllzunrqks, zelfde als OnsBudget)
create table if not exists public.boodschappen_items (
  id uuid primary key default gen_random_uuid(),
  list text not null default 'samen' check (list in ('samen','mama')),
  name text not null check (length(trim(name)) > 0),
  qty int not null default 1 check (qty >= 1),
  category text not null default 'andere',
  added_by text,                -- 'E' of 'S'
  done_at timestamptz,          -- afgevinkt; na 24u verwijderd door de app
  created_at timestamptz not null default now()
);
create index if not exists boodschappen_items_list_idx on public.boodschappen_items (list, done_at);

-- Onthoudt per artikel de gekozen categorie + hoe vaak het gekocht werd (suggesties)
create table if not exists public.boodschappen_memory (
  name_key text primary key,
  name text not null,
  category text not null,
  times int not null default 1,
  updated_at timestamptz not null default now()
);

alter table public.boodschappen_items enable row level security;
alter table public.boodschappen_memory enable row level security;
create policy "boodschappen_items_all" on public.boodschappen_items for all using (true) with check (true);
create policy "boodschappen_memory_all" on public.boodschappen_memory for all using (true) with check (true);
alter publication supabase_realtime add table public.boodschappen_items;
