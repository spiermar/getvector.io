---
title: Getting Started
index: 2
---

<img src="{{ '/images/screenshot.png' | prepend: site.baseurl }}" alt="Vector screenshot" width="100%" />

### Installing PCP

In order to get started, you should first install [Performance Co-Pilot (PCP)](http://pcp.io/) version 3.10+ on each host you plan to monitor. PCP will collect the metrics and make them available for Vector.  The pmcd (port tcp/44321) and/or pmwebd (port tcp/44323) services need to be running on each host, with the network ports exposed.

Optional monitoring agents can also be installed in order to collect specific metrics that are not supported by PCP's system agent.

See [Installing Performance Co-Pilot](installing-performance-co-pilot) for install instructions.

Once PCP is installed, you should be able to run Vector and connect to the monitored host.

### Running Vector

Vector is a **static web application** that runs completely inside the users's browser. You should be able to run it using the development server or deploy it to any web server, like Apache or Nginx.

The following guides should help you get started:

* [Deploying to a Web Server](deploying-web-server) - Instructions about deploying Vector to a web server.
* [Deploying with Docker](deploying-docker) - Instructions about starting a Docker container running Vector.
* [Deploying to Amazon S3](deploying-amazon-s3) - Instructions about deploying Vector using Amazon's S3.
* [Running on PMWEBD](running-pmwebd) - Instructions on how to run Vector using PCP's PMWEBD.
* [Building Vector from Source](building-vector-source) - Instructions on how to build Vector from source and start the development server locally.
