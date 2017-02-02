# Dockerized GeoServer based on Tomcat 9 and alpine linux

A simple docker container that runs Geoserver on alpine linux and tomcat 9 influenced 
by this project: https://github.com/kartoza/docker-geoserver

This image is based on the official [tomcat 9](https://hub.docker.com/_/tomcat/) alpine image,
using jre8 and [Java Advanced Imaging](https://java.net/projects/jai) plugins

## Getting the image

Pull the image from Docker Hub using docker's pull command:

```shell
docker pull hbarel/docker-geoserver
```
(replace <version number> with the relevent version)


Build the image yourself:

```shell
docker build -t geoserver git://github.com/hbarel/docker-geoserver
```

### Run

To run a container do:
```shell
docker run --name "geoserver" -p 8080:8080 -d -t hbarel/docker-geoserver
```

Then, navigate to localhost:8080/geoserver/web

**Note:** The default geoserver user is 'admin' and the password is 'geoserver'.
It's highly recommend that you change these as soon as you first log in.

## Storing data on the host rather than the container.
Docker volumes can be used to persist your data.

```shell
mkdir -p ~/geoserver_data
docker run -d -v $HOME/geoserver_data:/opt/geoserver/data_dir hbarel/docker-geoserver
```

You need to ensure the ``geoserver_data`` directory has sufficient permissions
for the docker process to read / write it.

### Notes
* This image removes the Tomcat extras files and managment tools. Those are unneccesory for 
the GeoServer application and pose a security risk.
* this is an Alpha version. While this has been tested in a lab environment, it hasn't been
tested in a production setup, so proceed with care.

## TODO
* Enable https on tomcat as an option when running a container