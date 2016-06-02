---
title: Building Vector from Source
index: 7
---

Building Vector from source and starting a development server is simple.

### Building from Source

First you need to clone the repository from GitHub:

```
$ git clone https://github.com/Netflix/vector.git
$ cd vector
$ git checkout stable // optional. if you prefer the latest stable code.
```

Make sure you have Node.JS, npm and Bower installed on your system. Bower is a package management system for client-side programming, optimized for the front-end development.

* [https://nodejs.org/download/](https://nodejs.org/download/)
* [http://bower.io/#install-bower](http://bower.io/#install-bower)

Gulp is an automated task runner and includes facilities to assemble a self-contained static webapp directory.

* [https://github.com/gulpjs/gulp/blob/master/docs/getting-started.md](https://github.com/gulpjs/gulp/blob/master/docs/getting-started.md)

Install all dependencies and start the Gulp build task:

```
$ npm install
$ bower install
$ gulp build
```

The compiled assets will be under the `dist` directory.

### Development Server

You can run Vector with Gulp's development web server and live reload. In order to start Gulp’s web server, just execute the serve task:

```
$ gulp serve
```

This should start the development server on port 3000.
