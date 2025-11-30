---
layout: default
title: " Duplication ≠ Duplication — The Kafka Connect S3 Sink Identity Crisis"
date: Sun, 30 Nov 2025 09:45:59 +0000
excerpt: "🤯 Duplication ≠ Duplication — "
link: "https://medium.com/@shiki65536/duplication-duplication-the-kafka-connect-s3-sink-identity-crisis-aae63969e215?source=rss-374d8f1302a3------2"
image: "https://cdn-images-1.medium.com/max/500/1*Y1hf9VCKk6lwF-Yb9vUDeg.jpeg"
tags: ["s3", "kafka-connect", "kafka"]
---
🤯 Duplication ≠ Duplication — The Kafka Connect S3 Sink Identity CrisisThis week I finally understood what “duplication” really means in S3 Sink.Wrong test:Set `flush.size=1` → “Spam the same payload every minute via AKHQ”Senior:“That’s not duplication. Duplication = same Kafka record (topic+partition+offset) processed twice.”The moment I realized **Payload ≠ Offset**, everything clicked.Real duplication triggers:Task crash before offset commitRebalance steals partition earlyPoll timeout after processingAll produce identical records → connector can write twice.My old config (95% safe):flush.size=1rotate.schedule.interval.ms=null # explicitly disabled (never use it for per-message sinks)# no rotate.interval.ms → tiny risk windowpartition.field.name=order_idBulletproof config (2025 standard):flush.size=1rotate.schedule.interval.ms=null # explicitly disabled (never use it for per-message sinks)rotate.interval.ms=30000 # 30 seconds sweet spotpartition.field.name=order_idTL;DRSame payload ≠ duplicationSame offset twice = duplicationflush.size=1 + rotate.interval.ms=30000 + explicit rotate.schedule.interval.ms=null = sleep peacefully.
