---
title: Deploying with Docker
index: 3
---

We provide an official Docker image for Vector. You can pull it directly from Docker Hub and start a container with running Vector.

### With Caddy (recommended):

```
docker run \
  -d \
  --name vector \
  -p 80:80 \
  netflixoss/vector:latest
```

### With Nginx:

The Vector Docker image is only used as a volume.

#### Start vector-storage

```

docker run  \
-d \
--name vector-storage \
netflixoss/vector:latest true
```

#### Start vector-nginx

```
docker run \
-d \
--name vector-nginx \
--volumes-from vector-storage \
-p 80:80 \
nginx:latest
```
