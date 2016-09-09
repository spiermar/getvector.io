---
title: CPU Flame Graphs
index: 11
---

At this point, support for [CPU Flame Graphs](http://www.brendangregg.com/FlameGraphs/cpuflamegraphs.html) in Vector is *not ideal*. It depends on a *hackish* PMDA and lacks proper support. A new solution is being developed, but it's not ready yet. The development can be followed via these two issues:

* [#7](https://github.com/Netflix/vector/issues/7)
* [#74](https://github.com/Netflix/vector/issues/74)

**WARNING:** Use at your own risk.

## Installation

* Install the `Generic PMDA` according to instructions available at [https://github.com/spiermar/generic-pmda](https://github.com/spiermar/generic-pmda).
* Once the PMDA is working, just set the `enableCpuFlameGraph` option to `true` in the `app/index.config.js` file.
