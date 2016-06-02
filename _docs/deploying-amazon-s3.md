---
title: Deploying to Amazon S3
index: 5
---

You can deploy Vector to an Amazon S3 bucket. This way you don't need to provision a dedicated instance for hosting. Follow instructions listed below:

1. On Amazon's S3 console, select the S3 bucket you want to use to host Vector.
2. Under "properties", "Static Website Hosting", select "Enable Website Hosting".
5. Take note of the S3 "endpoint". This is the address you will type in your the browser.
6. Download Vector distribution from Bintray: $ wget https://bintray.com/artifact/download/netflixoss/downloads/1.1.0/vector.tar.gz
7. Uncompress the distribution file: $ tar xvzf vector.tar.gz
8. Upload the assets to the S3 bucket using s3cmd: $ s3cmd put --recursive * s3://S3-BUCKET/
9. Open your browser and type in the S3 endpoint address.

_S3 stores CSS files as binary octet-stream MIME-type instead of CSS. You need to change the CSS files MIME-type to text/css in order for the browser to draw the UI correctly. Go to the AWS S3 console and select files in the Vector styles folder: main-*.css and vendor-*.css. Change "Metadata", "Key: Content-Type" to "Value: text/css"._
