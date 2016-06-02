---
title: Getting Started
index: 2
---

![Screenshot](img/screenshot.png)

In order to get started, you should first install [Performance Co-Pilot (PCP)](http://pcp.io/) version 3.10+ on each host you plan to monitor. PCP will collect the metrics and make them available for Vector.  The pmcd (port tcp/44321) and/or pmwebd (port tcp/44323) services need to be running on each host, with network ports exposed.

Optional monitoring agents can also be installed in order to collect specific metrics that are not supported by PCP's system agent.

Vector depends on Performance Co-Pilot (PCP) to collect metrics on each host you plan to monitor.
See [Installing Performance Co-Pilot](Installing-Performance-Co-Pilot) for install instructions.
Once PCP is installed, you should be able to run Vector and connect to the target host.

## PCP deployment models

You have a choice about whether to run the PCP `pmwebd` and `pmcd` services on each node,
or a central `pmwebd` "proxy" that connects to nodes running only `pmcd`.  The Vector `Hostname` and drop-down `hostspec` fields specify the various combinations:

1. Per-node pmwebd and pmcd

    This increases the minimum installation footprint.  Set `Hostname` to the the `pmwebd` host:port (default 44323), and leave the `Hostspec` at the default `localhost`.

2. Central pmwebd, per-node pmcd

    This may add latency due to the intermediate hop.  Set `Hostname` field to point to the `pmwebd` host:port (default 44323), and the `Hostspec` to the target host name, or more general `pcp://` URL that may contain authentication, container, or proxying directives.  (Host names/addresses are interpreted from the point of view of the `pmwebd` server.)  See the [PCPintro man page](http://www.pcp.io/man/man1/pcpintro.1.html) **PMCD HOST SPECIFICATION** section for details.

## Vector

Vector is a **static web application** that runs inside the client's browser. It can run locally or deployed to any HTTP server available, like Apache or Nginx.

### Running Locally

To run in locally, first clone the repo:

```
$ git clone https://github.com/Netflix/vector.git
$ cd vector
$ git checkout stable // optional. if you prefer the latest stable code.
```

Make sure you have Node.js, npm and Bower installed on your system. Bower is a package management system for client-side programming, optimized for the front-end development.

[https://nodejs.org/download/](https://nodejs.org/download/)

[http://bower.io/#install-bower](http://bower.io/#install-bower)

Gulp is an automated task runner and includes facilities to assemble a self-contained static webapp directory.

[https://github.com/gulpjs/gulp/blob/master/docs/getting-started.md](https://github.com/gulpjs/gulp/blob/master/docs/getting-started.md)

Install all dependencies, then assemble the static webapp under the `dist/` directory:

```
$ npm install
$ bower install
$ gulp build
```

#### Running With Gulp

You can run Vector with Gulp's development web server with live reload. In order to start Gulp’s web server.  Execute the serve task:

```
$ gulp serve
```

This should start the development server on port 3000.

#### Running with Python's SimpleHTTPServer

You can also run Vector with Python's SimpleHTTPServer:

```

$ cd dist
$ python -m SimpleHTTPServer 8080
```

Then open Vector on your browser:

[http://localhost:8080](http://localhost:8080)

#### Running on PMWEBD

The PCP pmwebd process can serve both static webapp files, plus the `PMWEBAPI` used to feed it live data.  Choose an unused TCP port number on your system, such as 8080, then:

```
/usr/libexec/pcp/bin/pmwebd -R dist -p 8080
```

And direct your web browser to [http://localhost:8080/index.html#/?host=localhost:8080](http://localhost:8080#/?host=localhost:8080)

And enter the hostname from the server you plan on monitoring. That's it!

### Deploying with Docker

With [Caddy](https://github.com/mholt/caddy) (recommended):

```
docker run \
  -d \
  --name vector \
  -p 80:80 \
  netflixoss/vector:latest
```

With nginx (vector Docker image is only used as a volume):

```
# start vector-storage
docker run  \
  -d \
  --name vector-storage \
  netflixoss/vector:latest true

# start vector-nginx
docker run \
  -d \
  --name vector-nginx \
  --volumes-from vector-storage \
  -p 80:80 \
  nginx:latest
```

### Deploying to a Amazon S3

You can deploy Vector assets to Amazon S3 bucket. This way you don't need to provision Amazon instance for hosting vector assets. Follow instructions listed below:

* Select S3 bucket where you want to host vector assets in amazon console. Click S3 bucket "Properties" and select "Static Website Hosting". Click radio button "Enable website hosting" Note S3 "Endpoint", This is the address you type into the browser.
* Download vector assets: $ wget https://bintray.com/artifact/download/netflixoss/downloads/1.0.3/vector.tar.gz
* gunzip and untar vector.tar.gz
* Upload to S3 bucket using s3cmd: $s3cmd put --recursive * s3://S3-BUCKET/
* Open browser and type the S3 "Endpoint" address.
* If the pcp (pmwebd) service is not running on a default port, you can specify the port number with the hostname or IP address in vector: myserver.net:port

_NOTE: S3 stores vector css files as binary octet-stream MIME-type instead of css. You need to change vector css files to MIME-type to text/css in order for browser to draw vector page correctly. To perform this task, go to aws console and select files in vector styles folder: main-b5*.css and vendor-44*.css. Change "Metadata" "Key: Content-Type" to "Value: text/css". Click save._

### Deploying to a web server (Nginx, Apache)

Since Vector is just a static application, you should be able to easily deploy it to any web server. The Vector distribution tarball, containing all dependencies, can be found on Bintray:

[[https://bintray.com/netflixoss/downloads/vector/view]]

With that, the only thing you need is to download and uncompress the gzip tarball into your web server directory. For example, using Ubuntu and Apache 2.

```
$ sudo apt-get install apache2
$ cd /var/www/html
$ sudo wget https://bintray.com/artifact/download/netflixoss/downloads/1.0.3/vector.tar.gz
$ sudo tar xvzf vector.tar.gz
```

That's it! Just open your browser and point to your server. Apache should run by default on port 80.
