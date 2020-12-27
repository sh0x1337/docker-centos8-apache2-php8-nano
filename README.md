# docker-centos8-apache-php74-nano
Docker Container with CentOS 8 running Apache2, PHP7.4, crond, composer, pagespeed and nano
First Test
# Pull

```
docker pull sh0x1337/docker-centos8-apache-php74-nano
```

# Running Container

```
docker run -v /opt/docker/docker_test/data:/var/www/page  --restart=always -d -it sh0x1337/docker-centos8-apache-php74-nano
```

# Attach Container

```
docker exec sh0x1337/docker-centos8-apache-php74-nano /bin/bash
