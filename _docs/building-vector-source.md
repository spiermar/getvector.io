---
title: Building Vector from Source
index: 7
---

Building Vector from source and starting a development server is simple.

### Building from Source

First you need to clone the repository from GitHub:

Make sure you have NVM installed for managing node versions. This ensures you will be using the correct node version for the installation.

* [https://nodejs.org/download/](https://nodejs.org/download/)
* [https://github.com/creationix/nvm](https://github.com/creationix/nvm)

```
$ git clone https://github.com/Netflix/vector.git
$ cd vector
$ nvm use
$ npm install
$ npm run build
```

The compiled assets will be under the `dist` directory.

### Development Server

You can run Vector with a development web server and live reload:

```
$ npm run serve
```

This should start the development server on port 3000.
