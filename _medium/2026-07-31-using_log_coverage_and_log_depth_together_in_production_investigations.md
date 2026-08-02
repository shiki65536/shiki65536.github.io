---
layout: default
title: "Using Log Coverage and Log Depth Together in Production Investigations"
date: Fri, 31 Jul 2026 22:21:01 +0000
excerpt: "The SituationRecently, a regul"
link: "https://medium.com/@shiki65536/using-log-coverage-and-log-depth-together-in-production-investigations-e80e09709a5c?source=rss-374d8f1302a3------2"
image: "https://cdn-images-1.medium.com/max/500/1*-coM0Y2sOdQ14lmJwHXZDw.jpeg"
tags: ["cloud-engineering", "production-engineering", "observability", "software-engineering"]
---
The SituationRecently, a regulatory report required the number of consumer data request refusals and the rules or data standards behind them.The raw data contained thousands of 404, 422, 429, 500, and 503 responses. Simply counting status codes was not enough — the same HTTP code could represent different business conditions.The InvestigationI used two telemetry sources for different purposes:OpenSearch provided coverage across the full reporting period.CloudWatch provided deeper request context, including API paths, scopes, error reasons, and consent IDs.I grouped the requests by status code, refusal reason, endpoint, and scope, then reviewed individual request sequences to validate the broader patterns.The FindingThe requests were reaching valid API endpoints. The errors referred to invalid or unauthorised resources — not invalid URLs.The apparent endpoint errors were primarily caused by continued downstream polling after the underlying customer or resource relationship had expired.The LessonLog coverage answers “how often?”Log depth answers “why?”Reliable production investigations often require both.
