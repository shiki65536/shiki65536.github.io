---
layout: default
title: "Fixing query in OpenSearch — The .keyword Solution"
date: Sun, 26 Oct 2025 02:24:58 +0000
excerpt: "Fixing query in OpenSearch — T"
link: "https://medium.com/@shiki65536/fixing-query-in-opensearch-the-keyword-solution-1609141d0942?source=rss-374d8f1302a3------2"
image: "https://cdn-images-1.medium.com/max/1024/1*zWmNbtERt88j_dmuytcnJw.png"
tags: ["opensearch", "debugging", "elasticsearch"]
---
Fixing query in OpenSearch — The .keyword SolutionThis week, we found our API endpoint failing when searching by Identifier with `0974727407` or `QB02003325` as input.The Root CauseOpenSearch/Elasticsearch stores string fields in two formats:Text field (`identifier`) — analyzed and tokenized for full-text searchKeyword field** (`identifier.keyword`) — stored exactly as-is for exact matchingOur query was using the analyzed text field, which probably caused:Leading zeros stripped: `0974727407` → `974727407`Case normalization: `QB02003325` → `qb02003325`The SolutionAdd `.keyword` suffix to the field name then we can do the exact match queries:async findByIdentifier(identifier: string[] | number[], include?: string[]): Promise&lt;ServicePoints[]&gt; { return this.automap(await this.findBy(&#39;identifier.keyword&#39;, identifier, include));}Key TakeawayWhen querying OpenSearch/Elasticsearch for IDs, codes, or any field requiring exact matches, always use the `.keyword`subfield. The analyzed text field is for full-text search, not precise matching.
