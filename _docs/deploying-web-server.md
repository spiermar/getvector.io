---
title: Deploying to a Web Server
index: 4
---

Since Vector is just a static application, you should be able to easily deploy it to any web server.

The Vector distribution tarball, containing all its dependencies, can be found on Bintray:

[https://bintray.com/netflixoss/downloads/vector/view](https://bintray.com/netflixoss/downloads/vector/view)

The only thing you need to do is download and uncompress the gzip tarball into your web server directory.

For example, using Ubuntu with Apache 2:

```
$ cd /var/www/html
$ sudo wget https://bintray.com/artifact/download/netflixoss/downloads/1.1.0/vector.tar.gz
$ sudo tar xvzf vector.tar.gz
```

That's it! Just open your browser and point to the web server. Apache should run by default on port 80!
