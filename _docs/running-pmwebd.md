---
title: Running on PMWEBD
index: 8
---

`pmwebd` is a network daemon that binds a subset of the Performance Co-Pilot (PCP) client API (`pmapi`) to RESTful web applications using the HTTP protocol.

In addition to the API binding, `pmwebd` may be optionally configured as a simple HTTP file server, in order to server Vector itself to a web browser.

First you must download the distribution tarball and uncompress it:

```
$ wget https://bintray.com/artifact/download/netflixoss/downloads/1.1.0/vector.tar.gz
$ tar xvzf vector.tar.gz
```

Choose an unused port number on your system, such as 8080, then:

```
$ /usr/libexec/pcp/bin/pmwebd -R vector -p 8080
```

That's it! Just open your browser and point to the web server on port 8080!
