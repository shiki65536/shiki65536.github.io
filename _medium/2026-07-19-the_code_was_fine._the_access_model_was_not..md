---
layout: default
title: "The Code Was Fine. The Access Model Was Not."
date: Sun, 19 Jul 2026 09:05:37 +0000
excerpt: "This week, Supabase flagged se"
link: "https://medium.com/@shiki65536/the-code-was-fine-the-access-model-was-not-2bcc32ccf3ac?source=rss-374d8f1302a3------2"
image: "https://cdn-images-1.medium.com/max/500/1*bOrrn97nT4TYZoH9zYdXpg.jpeg"
tags: ["application-security", "postgresql", "database-security", "backend-development", "supabase"]
---
This week, Supabase flagged several backend tables with: RLS Disabled in Public.My application was already using the intended path: Frontend → Backend API → SupabaseHowever, the database configuration still allowed a potential direct-access path for client roles, violating the principle of least privilege.The FixI locked down the tables at both the policy and privilege levels.Enable RLS to prevent client roles from accessing rows without an explicit policy.alter table public.patent_ai enable row level security;2. Revoke Client Access to prevent `anon` and `authenticated` roles from accessing the table at all.revoke all on table public.patent_ai from anon, authenticated;The Backend API uses the trusted service_role, which bypasses RLS, so the application remains functional while the unintended direct-access path is removed.Note: Supabase is also moving new projects towards explicit opt-in exposure, rather than automatically exposing every new public table through the Data API.The TakeawayThe two controls operate at different levels:Privileges: What operations can this role perform on the table?RLS: Which rows can this role access?The core lesson:Working code does not mean the architecture is correctly enforced.The application already followed the intended path. The database configuration needed to make every other path invalid.A small but useful example of defence in depth.
