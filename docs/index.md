---
layout: page
title: Documentation
url: /docs/
---

### What is Vector?

Vector is an open source host-level performance monitoring framework which exposes hand-picked, high-resolution system and application metrics to every engineer’s browser. Having the right metrics available on demand and at a high resolution is key to understanding how a system behaves and correctly troubleshooting performance issues. Logging onto a system and running a large number of commands from the shell is an option, but the complexity typically involved can be a barrier for engineers wishing to adopt it as a long-term solution. Also, traditional centralized system monitoring solutions are often complex to set up, especially for one-off or ad-hoc usage, where such solutions would be an overkill.

Vector provides a simple way for users to visualize and analyze system and application-level metrics in near real-time. It leverages the battle tested open source system monitoring framework, Performance Co-Pilot (PCP),  layering on top a flexible and user-friendly UI. The UI polls metrics at up to 1 second resolution, rendering the data in completely configurable dashboards that simplify cross-metric correlation and analysis.
PCP’s stateless model makes it lightweight and robust. Its overhead on hosts is negligible as clients are responsible for keeping track of state, sampling rate, and computation. Additionally, metrics are not aggregated across hosts or persisted outside of the user’s browser session, keeping the framework light. Vector requires only your local browser and PCP installed on the host you wish to monitor. No intermediate collector, server, or database infrastructure is required.
