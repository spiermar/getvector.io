---
layout: post
title:  "Extending Vector with eBPF to inspect host and container performance."
date:   2019-04-10 08:00:00 -0700
categories: blog release
---

Today we are excited to announce latency heatmaps and improved container support for our on-host monitoring solution — Vector — to the broader community. Vector is open source and in use by multiple companies. These updates also bring other user experience improvements and a fresher technology stack.

Here's a quick summary of what's new and improved.

### Introducing BCC and eBPF visualisations

<img src="{{ '/images/blog/bcc-bpf.gif' | prepend: site.baseurl }}" alt="BCC BPF widgets" width="100%" />

Andreas Gerstmayr has done fantastic work with developing a PCP PMDA for BCC, allowing BCC tool output to be read from Vector, and adding visualizations to Vector to view this data. Vector can now show these from BCC/eBPF:

* Block and filesystem (ext4, xfs, zfs) latency heat maps
* Block IO top processes
* Active TCP session data such as top users, session life, retransmits ..
* Snoops: block IO, exec()
* Scheduler run queue latency

#### Integrated multiple host and container metrics

For a more complex set of use cases, being able to view metrics simultaneously from multiple containers on a host or both the container and the host may be necessary. You can now render charts from multiple hosts and containers on a single chart, and resize them so that it makes sense.

<img src="{{ '/images/blog/multiple-host-cpu.gif' | prepend: site.baseurl }}" alt="CPU across multiple hosts" width="50%" />

#### Getting the latest

As usual, the quickest way to get started is to use the Docker container:
```
docker run \
  -d \
  --name vector \
  -p 80:80 \
  netflixoss/vector:latest
```

*You still need to load the agent software on each monitored host for the Vector dashboard to connect to.*
