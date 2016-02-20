docker-mosquitto
================

Docker image for mosquitto

[![License](https://img.shields.io/badge/license-MIT-blue.svg)](https://raw.githubusercontent.com/chadoe/docker-cleanup-volumes/master/LICENSE)
[![Docker Stars](https://img.shields.io/docker/stars/toke/mosquitto.svg)](https://hub.docker.com/r/toke/mosquitto/)
[![Docker Pulls](https://img.shields.io/docker/pulls/toke/mosquitto.svg)](https://hub.docker.com/r/toke/mosquitto/)
[![ImageLayers Size](https://img.shields.io/imagelayers/image-size/toke/mosquitto/latest.svg)](https://hub.docker.com/r/toke/mosquitto/)
[![ImageLayers Layers](https://img.shields.io/imagelayers/layers/toke/mosquitto/latest.svg)](https://hub.docker.com/r/toke/mosquitto/)

## Setup for Data Persistence

Create three directories on your host:

* /src/mqtt/config
* /src/mqtt/data
* /src/mqtt/log

Copy the files from the config directory of this project into /src/mqtt/config. Change them as needed for your particular needs.

## Run

    docker run -ti -p 1883:1883 -p 9001:9001 toke/mosquitto

Exposes Port 1883 (MQTT) 9001 (Websocket MQTT)

Alternatively you can use volumes to make the changes
persistent and change the configuration.

    mkdir -p /srv/mqtt/config/
    mkdir -p /srv/mqtt/data/
    mkdir -p /srv/mqtt/log/
    # place your mosquitto.conf in /srv/mqtt/config/
    # NOTE: You have to change the permissions of the directories
    # to allow the user to read/write to data and log and read from
    # config directory
    # For TESTING purposes you can use chmod -R 777 /srv/mqtt/*
    # Better use "-u" with a valid user id on your docker host

    docker run -ti -p 1883:1883 -p 9001:9001 \
    -v /srv/mqtt/config:/mqtt/config:ro \
    -v /srv/mqtt/log:/mqtt/log \
    -v /srv/mqtt/data/:/mqtt/data/ \
    --name mqtt toke/mosquitto

Volumes: /mqtt/config, /mqtt/data and /mqtt/log

## Build

    git clone https://github.com/toke/docker-mosquitto.git
    cd docker-mosquitto
    docker build .

## Authors and license

docker-mosquitto was written by:

* Thomas Kerpe | [web](https://toke.de/) | [mail](mailto:web@toke.de) | [GitHub](https://github.com/toke/)

License: [BSD 3-Clause](https://tldrlegal.com/license/bsd-3-clause-license-%28revised%29)
