---
layout: default
title: "Homeland Defense System: How to Stop Cats Pooping in My Backyard 1.0"
date: Sun, 10 May 2026 07:19:25 +0000
excerpt: "Built my first Raspberry Pi ba"
link: "https://medium.com/@shiki65536/homeland-defense-system-how-to-stop-cats-pooping-in-my-backyard-1-0-bf15f55de128?source=rss-374d8f1302a3------2"
image: "https://cdn-images-1.medium.com/max/1024/1*zeNzIA3rWpia92jKM6yexg.png"
tags: ["iot", "python", "side-project", "raspberry-pi", "embedded-systems"]
---
Built my first Raspberry Pi backyard deterrent system because neighborhood cats and possums apparently decided my backyard was public toilet infrastructure.What started as:motion detected → annoying sound and lights → animal leavesI never properly touched a Raspberry Pi before, so naturally it turned into:SSH setupGPIO debuggingPIR sensor tuningdebounce logiccooldown state machinesfiguring out why the sensor was detecting motion 24/7Current hardware:Raspberry Pi 3 Model B (2015)HC-SR501 PIR sensorActive buzzerLED floodlightThe funniest blocker: I thought the PIR sensor was “too sensitive”.Turns out:`H` mode continuously retriggersPIR sensors detect infrared changes, not “movement”lateral movement works much better than walking directly toward itsensor angle matters way more than expectedCurrent logic:Motion detected → buzzer and LED for 8s → cooldown for 60s → re-armHonestly, writing software that immediately affects the physical world is absurdly satisfying.Also, I’ve never seen my flatmates were so interested in my side projects.
