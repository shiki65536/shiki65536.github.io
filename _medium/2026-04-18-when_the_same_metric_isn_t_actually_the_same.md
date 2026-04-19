---
layout: default
title: "When “the same metric” isn’t actually the same"
date: Sat, 18 Apr 2026 22:21:01 +0000
excerpt: "We had a simple question: Why "
link: "https://medium.com/@shiki65536/when-the-same-metric-isnt-actually-the-same-f0fedcb38d6f?source=rss-374d8f1302a3------2"
image: "https://cdn-images-1.medium.com/max/500/1*ILue8gFxccnpLstGuILGtw.jpeg"
tags: ["backend", "software-engineering", "observability", "data-engineering", "analytics"]
---
We had a simple question: Why does “active consents” show different numbers across dashboards?Gov dashboard (OpenSearch): higherNew Relic dashboard: lowerSame metric. Two answers.First instinctWe assumed it was a query problem.maybe NRQL is wrongmaybe filters are missingSo we tried to “fix the query”. Didn’t work.What was actually happeningBusiness assumption: “Same metric → should be the same number everywhere”Technical reality:OpenSearch → can reconstruct state*New Relic → works on events, not stateRetention is differentAggregation capability is differentSo we weren’t querying the same thing.We were asking two systems to mean the same word.More detailsActive consents is not a simple count.It is:grouped by consentIdlatest event winsexclude revokedcheck expiry (consentEndDate)within a time windowThis is a stateful business definition, not an event count.DecisionOpenSearch = source of truth (correct business logic)New Relic = visualisation layerSolution:Compute the metric in OpenSearchIngest the result into New RelicDashboard reads the precomputed numberTakeawayA metric is not just a query.It’s a business definition + a system capable of expressing it.The dashboards weren’t wrong. They were just answering three different questions with the same label.
