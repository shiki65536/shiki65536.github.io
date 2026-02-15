---
layout: default
title: "Yarn 1 vs Yarn 4 — A Registry Trap I Didn’t Expect"
date: Sun, 15 Feb 2026 08:16:48 +0000
excerpt: "I ran yarn install on a TSproj"
link: "https://medium.com/@shiki65536/yarn-1-vs-yarn-4-a-registry-trap-i-didnt-expect-5e76434c5a9c?source=rss-374d8f1302a3------2"
image: "https://cdn-images-1.medium.com/max/1024/1*Kooo4tnEnXlrWzI2pS-rdA.png"
tags: ["javascript", "private-registry", "yarn", "nodejs"]
---
I ran yarn install on a TSproject that uses private scoped packages. It failed with 404.The registry was correct.The .npmrc was correct.Authentication looked fine.The only real difference: this repo was using Yarn 4 instead of Yarn 1.What Actually ChangedSome of our repos still use Yarn 1 (Classic). Others have moved to Yarn 4 (Berry).That difference is structural.Yarn 1Reads .npmrcResolves scoped registries automaticallyAuth flows through without extra configurationYarn 4Uses .yarnrc.yml as the source of truthDoes not rely on .npmrc for scoped resolutionRequires explicit npmScopesFalls back to public npm if scope isn’t definedThe packages weren’t missing.Yarn was querying the wrong registry.The Correct ConfigurationnpmScopes: myorg: npmRegistryServer: &quot;https://&lt;required.url&gt;/repository/npm-group/&quot; npmAlwaysAuth: true npmAuthIdent: &quot;&lt;username&gt;:&lt;password&gt;&quot;Install succeeds immediately.The Tactical WorkaroundFor local debugging, my manager tole me an elegant way to relax the Yarn version constraint:&quot;engines&quot;: { &quot;yarn&quot;: &quot;&gt;=1.22.0 &lt;2.0.0&quot;}This allowed Yarn 1 to run locally while CI remained on Yarn 4.That isolation step shortened the debugging loop significantly.What This ReinforcedYarn 4 isn’t a version bump.It changes:registry resolution logicauthentication semanticsMost 404s in private registries aren’t missing packages.They’re misrouted requests.ReferencesMigration guide: Yarn 1 → Berrynpm authentication configurationYarn CLI: engines field behavior
