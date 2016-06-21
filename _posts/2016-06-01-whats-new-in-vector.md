---
layout: post
title:  "What’s new in Vector: Containers, Docker, and more."
date:   2016-06-01 08:00:00 -0700
categories: blog release
---

Today, we're excited to introduce a new release of Vector, our instance performance analysis tool. This one is a little bigger than our usual releases, and includes a few new features. That's why we're bumping the minor version number from 1.0.x to 1.1.x. It also took a bit longer and included more changes, and that was mainly because some of the new features required multiple new components working together to be truly useful for users.

Here's a quick summary of what's new and improved.

### Container Support

<img src="{{ '/images/blog/container_dashboard.png' | prepend: site.baseurl }}" alt="Container Dashboard" width="100%" />

A few container-specific widgets were added to the previous version of Vector, but turned off by default. In this release, we added a lot more features specifically designed for engineers working with containers, aiming to provide a better overall solution.

Our approach was to collect metrics from the host, instead of directly from agents running in the containers, like many other solutions opted for. This decision was mainly driven by the fact that containers can provide different levels of isolation depending on the configuration used, and since that isolation is not complete, it's important, from a performance perspective, to look at the entire host, and all it's containers, to have a full picture.

To start, we created several widgets to help users visualize resource utilization on containers, including CPU, Memory, Disk and Network I/O.

<img src="{{ '/images/blog/container_menu.png' | prepend: site.baseurl }}" alt="Container Menu" width="50%" />

In the CPU dimension, the following widgets were added:

* **Per-container CPU Utilization.** Current CPU utilization.
* **Per-container CPU Scheduler.** Current values for CPU shares and period. See [Docker run reference](https://docs.docker.com/engine/reference/run/) for more details.
* **Per-container CPU Headroom.** Current CPU utilization, and soft (or physical) CPU usage limit.
* **Per-container Throttled CPU.** CGroup throttled CPU time.

<img src="{{ '/images/blog/container_memory_widgets.png' | prepend: site.baseurl }}" alt="Container Memory Widgets" width="100%" />

For memory, the following widgets were added:

* **Per-container Memory Usage.** Container memory usage in Mb.
* **Total Container Memory Usage.** Memory consumed by containers in Mb, compared to host used and free memory.
* **Per-container Memory Headroom.** Current container memory usage, and soft (or physical) memory usage limit.
* **Per-container Memory Utilization.** Relative container memory usage usage relative to max usage, soft or physical.

At this point, we have limited visibility into network and disk metrics, but two widgets are already available.

* **Container Disk IOPS.** Read and write disk IOPS.
* **Container Disk Throughput.** Read and write disk throughput expressed in bytes.

For both disk widgets, two versions were added, one reporting `cgroup.blkio.all.throttle.*` metrics and the other `cgroup.blkio.all.*`. We labeled the former as `(Throttled)`. In this particular case, `throttled` doesn't mean throttled I/O, but just a different metrics being pulled.

#### Container Filters

We know that working on hosts with several containers can be difficult, that's why we also added two filtering options, while trying to keep the flow simple. Vector still works the same way. You use the hostname to connect to a host that has containers running. From that, you should be able expand the hostname menu and get access to the two new filters. The first one is an open-text filter, that will be applied to all container widgets, to filter the entries in each graph. This is specially useful if you have a set of containers running, that belong to the same class, and have a similar name. The second filter is a drop-down list, that gets populated with the name of all containers running in that host. From there, you can select a single container you would like to analyze. If you prefer, there's also a hook for an external container name resolver.

<img src="{{ '/images/blog/container_filter.png' | prepend: site.baseurl }}" alt="Container Filter" width="50%" />

We also added a filter to the Network Throughput and Packets widgets. The filter allows the user to filter specific network interfaces, with an open-text input, which is extremely useful if you use different network interfaces for your containers.

<img src="{{ '/images/blog/local_filter.png' | prepend: site.baseurl }}" alt="Local Filter" width="50%" />

On top of all these new features, we also created a predefined "container" dashboard, with common container-specific widgets in it. Just use the "/#/containers" path to load it!

### Docker Image

There are two components to Vector: the agent software that runs on every host, and a single web server that loads the Vector dashboard software in your browser. The web server software can now be deployed as a Docker image, which some may find easier than building Vector from source, or downloading a build and deploying a web server. So now we have an [official](https://hub.docker.com/r/netflixoss/vector/) Docker image!

Just pull 'netflixoss/vector' to get up and running!

```
docker run \
  -d \
  --name vector \
  -p 80:80 \
  netflixoss/vector:latest
```

*You still need to load the agent software on each monitored host for the Vector dashboard to connect to.*

And what could be easier than loading a Docker image? How about not having to do anything! Another option is to just load Vector from our public web server. More about that in the next section!

### New Site

Although not directly related to the release, we also launched a new website for Vector. Previously, most of the documentation around Vector was kept under the repository wiki on GitHub. This worked great so far, but the new website gives us more flexibility around how things are presented and organized.
The new website also allows us to publish and have a central source for news and blog posts related to Vector. Subscribe to the RSS feed to keep updated!
Since Vector is a static, client-side application, that runs completely in the user's browser, there's no reason why we couldn't host it ourselves, so users could try it out before deploying it themselves. Check [vectoross.io/demo](http://vectoross.io/demo) to try the latest version!

### Other Improvements and Bug Fixes

* Replaced [angular-flash](https://github.com/wmluke/angular-flash) that is no longer being maintained with [toastr](https://github.com/CodeSeven/toastr)
* Upgraded Angular to 1.4, along with most other dependencies. In the next release, Vector should be upgraded to Angular 1.5.
* Upgraded all Gulp plugins and tasks, following the latest [gulp-angular](https://github.com/Swiip/generator-gulp-angular) generator.
* Refactored the project structure to make it more maintainable. Components are now the primary building blocks.
* Retry fetching context before giving up when HTTP 400 is returned by PCP.
* Temporarily removed disk latency heatmap widget. It was not being used and required a PMDA that was never made public.
* If metric pulling is stopped for any reason, and the browser tab goes out of focus, then back in focus, don't try to start pulling metrics before context is updated.
* General code cleanup. Removed dead code. Moved configuration flags from controllers to the appropriate services.

A complete list of changes can be found [here](https://github.com/Netflix/vector/compare/v1.0.3...v1.1.0).

Lastly, we would like to thank all contributors, [hc000](https://github.com/hc000), [tregoning](https://github.com/tregoning) and [ot8844](https://github.com/ot8844).
