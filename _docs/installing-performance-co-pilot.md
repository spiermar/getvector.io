---
title: Installing Performance Co-Pilot
---

Since Vector depends on version 3.10 or higher, the packages currently available on most Linux distro repositories would not suffice. Until newer versions are available in the repositories, you should be able to install PCP from binary packages made available by the PCP project on Bintray or build it from source.

## Linux binary packages

### Deb format (Debian, Ubuntu)

To install using the PCP repo, first you need to import the key:

```
$ curl 'https://bintray.com/user/downloadSubjectPublicKey?username=pcp' | sudo apt-key add -
```

And include the correct repo URLs:

**Ubuntu (Trusty):**

```
$ echo "deb https://dl.bintray.com/pcp/trusty trusty main" | sudo tee -a /etc/apt/sources.list
```

**Debian (Jessie):**

```
$ echo "deb https://dl.bintray.com/netflixoss/jessie jessie main" | sudo tee -a /etc/apt/sources.list
```

Once that is done, you should be able to update your package list:

```
$ sudo apt-get update
```

And install the required PCP packages:

```
$ sudo apt-get install pcp pcp-webapi
```

That's it! Now PCP should be installed and running on your system!

## Building from source

To build PCP from source, get the current version of the source code:

```
$ git clone git://git.pcp.io/pcp
```

Check that pre-requisites such as libmicrohttpd headers/libraries and
pkgconfig are installed.

To automatically install build-time dependencies on a Debian-derived distro:

```
$ apt-get build-dep pcp
```

To automatically install build-time dependencies on a RedHat-derived distro:

```
$ yum-builddep -y pcp
```

Next, build and install:

```
$ cd pcp
$ ./configure --prefix=/usr --sysconfdir=/etc --localstatedir=/var --with-webapi
$ make
$ groupadd -r pcp
$ useradd -c "Performance Co-Pilot" -g pcp -d /var/lib/pcp -M -r -s /usr/sbin/nologin pcp
$ make install
```

More information on how to install Performance Co-Pilot can be found at:

[http://pcp.io/docs/installation.html#src](http://pcp.io/docs/installation.html#src)
