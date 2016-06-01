---
layout: post
title:  "What’s new in Vector: Containers, Docker, and more."
date:   2016-06-01 08:00:00 -0700
categories: blog release
---

Today, we’re excited to introduce a new release of Vector. This one is a little bigger than our usual releasee, and includes a few new additions, so we're bumping the minor version number from 1.0.x to 1.1.x. It also took a bit longer and included more changes than the usual release. That was mainly because some of the additions required multiple new components working together to be truly useful for users, and that required more changes than usual.

Here's a quick summary of what's new and improved.

### Container Support

* container support
	* container-specific dashboard
	* all container widgets
	* container name filter
	* container name resolver
	* container selection
	* network widget local filters
	* issues with network and disk metrics

### Docker Image

For many, deploying a Docker image is much easier than building Vector from source or downloading a build and deploying to a web server. That's why we now have an [official](https://hub.docker.com/r/netflixoss/vector/) Docker image!

Just pull 'netflixoss/vector' to get up and running!

```
docker run \
  -d \
  --name vector \
  -p 80:80 \
  netflixoss/vector:latest
```

### New Site

Although not directly related to the release, we also launched a new website for Vector. Previously, most of the documentation around Vector was kept under the repository wiki on GitHub. This worked great so far, but the new website gives us more flexibility around how things are presented and organized.
The new website also allows us to publish and have a central source for news and blog posts related to Vector. Subscribe to the RSS feed to keep updated!
Since Vector is a static, client-side application, that runs completely in the user's browser, there's no reason why we couldn't host it ourselves, so users could try it out before deploying it themselves. Check [latest.vectoross.io](http://latest.vectoross.io) to try the latest version!

### Other Improvements and Bug Fixes

* Replaced [angular-flash](https://github.com/wmluke/angular-flash) that is no longer being maintained with [toastr](https://github.com/CodeSeven/toastr)
* Upgraded Angular to 1.4, along with most other dependencies. In the next release, Vector should be upgraded to Angular 1.5.
* Upgraded all Gulp plugins and tasks, following the latest [gulp-angular](https://github.com/Swiip/generator-gulp-angular) generator.
* Refactored the project structure to make it more maintainable. Components are now the primary building blocks.
* Retry fetching context before giving up when HTTP 400 is returned by PCP.
* Removed disk latency heatmap widget. It was not being used and required a PMDA that was never made public.
* If metric pulling is stopped for any reason, and the browser tab goes out of focus, then back in focus, don't try to start pulling metrics before context is updated.
* General code cleanup. Removed dead code. Moved configuration flags from controllers to the appropriate services.

A complete list of changes can be found [here](https://github.com/Netflix/vector/compare/v1.0.3...v1.1.0).

Lastly, we would like to thank all contributors, [hc000](https://github.com/hc000), [tregoning](https://github.com/tregoning) and [ot8844](https://github.com/tregoning).
