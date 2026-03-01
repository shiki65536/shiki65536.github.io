---
layout: default
title: "Success: true. Exit Code: 1. — When the Toolchain Shifts"
date: Sun, 01 Mar 2026 06:15:36 +0000
excerpt: "This week I got pinged from an"
link: "https://medium.com/@shiki65536/success-true-exit-code-1-when-the-toolchain-shifts-2cc5b07297fe?source=rss-374d8f1302a3------2"
image: "https://cdn-images-1.medium.com/max/1024/1*FmBzxqnnNOavEGO1t19few.png"
tags: ["software-engineering", "ci-cd-pipeline", "node", "jest", "testing"]
---
This week I got pinged from an external team because a pipeline was failing.Everything compiled. All tests passed. success: true. But the process still exited with 1.What Actually HappenedThe repo had just gone through a large dependency refresh:Jest upgradeNode upgradeInternal CDK bump(Which also pulled in a _lot_ of transitive updates.)Something subtle changed. One of our tests intentionally exercises a failure path. That path sets: process.exitCode = 1Older Jest/Node combos quietly masked that side effect. The new runtime doesn’t. So:Tests passedAssertions passedsuccess: trueBut the process still exited with 1. CI pipeline said no.The FixNot forceExit, that felt like duct tape.Instead, proper test isolation:afterEach(() =&gt; { if (typeof process.exitCode !== &quot;undefined&quot; &amp;&amp; process.exitCode !== 0) { process.exitCode = 0; }});And wired via the following in jest.config.ts:module.exports = { setupFilesAfterEnv: [&quot;&lt;rootDir&gt;/&lt;fix_code_path&gt;.js&quot;],};No hacks. Just preventing global state leakage between tests.Pipeline green again.Real LessonNothing in the business logic was broken.The dependency tree shifted. The runtime contract changed.Aggressive dependency updates don’t just upgrade features, they subtly change execution semantics.Sometimes the bugs aren’t in your code.
