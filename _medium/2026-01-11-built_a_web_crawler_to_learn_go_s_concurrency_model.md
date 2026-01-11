---
layout: default
title: "Built a Web Crawler to Learn Go’s Concurrency Model"
date: Sun, 11 Jan 2026 04:38:25 +0000
excerpt: "I’d been putting off learning "
link: "https://medium.com/@shiki65536/built-a-web-crawler-to-learn-gos-concurrency-model-e137a7030832?source=rss-374d8f1302a3------2"
image: "https://cdn-images-1.medium.com/max/1024/1*P0CJMNeHVTfv9RwiVt0ZNg.png"
tags: ["backend", "golang", "web-crawler", "concurrency"]
---
I’d been putting off learning a new programming language and was torn between Rust and Go for a while.Since Go is well known for its concurrency model, I decided to write a minimal concurrent web crawler to see how goroutines and channels actually feel in practice.Why a Web Crawler?Go’s big promise is concurrency made easy.Coming from Python’s GIL and JavaScript’s async complexity, I know this is often a real pain point in engineering.Web crawling felt like the perfect test:I/O heavyNaturally concurrentEasy to reason about correctnessIf Go’s concurrency model really worked, this would expose it quickly.What I BuiltI built a concurrent web crawler with an HTTP API, using only Go’s standard library.Worker pool with goroutinesChannels for job distribution and result collectionA small dashboard to visualize progress in real timeThe core pattern looked like this:for i := 0; i &lt; workers; i++ { go worker(jobs, results)}for _, url := range urls { jobs &lt;- url}In Python, this would’ve meant threads or asyncio. In JavaScript, a maze of Promises. In Go? It was… boringly straightforward, and that’s a compliment.What I Actually LearnedConcurrency isn’t scary when the language is designed for itSimple code can still scale surprisingly wellGo’s standard library is _extremely_ capableExplicit error handling is verbose…… but clarifyingThis small project helped me understand why Go is often used for platform tooling and I/O-heavy systems.
