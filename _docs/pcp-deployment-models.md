---
title: PCP Deployment Models
index: 9
---

You have a choice about whether to run the PCP `pmwebd` and `pmcd` services on each node, or a central `pmwebd` "proxy" that connects to nodes running only `pmcd`.

The Vector `hostname` and drop-down `hostspec` fields specify the various combinations:

1. Per-node `pmwebd` and `pmcd`

    This increases the minimum installation footprint.  Set `hostname` to the the `pmwebd` host:port (default 44323), and leave the `hostspec` at the default `localhost`.

2. Central `pmwebd`, per-node `pmcd`

    This may add latency due to the intermediate hop.  Set `hostname` field to point to the `pmwebd` host:port (default 44323), and the `hostspec` to the target host name, or more general `pcp://` URL that may contain authentication, container, or proxying directives.

    See the [PMCD Host Specification](pmcd-host-specification) page for more details.
