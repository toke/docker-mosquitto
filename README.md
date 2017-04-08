docker-mosquitto
================

Docker image for mosquitto

[![Docker Stars](https://img.shields.io/docker/stars/toke/mosquitto.svg)](https://hub.docker.com/r/toke/mosquitto/)
[![Docker Pulls](https://img.shields.io/docker/pulls/toke/mosquitto.svg)](https://hub.docker.com/r/toke/mosquitto/)
[![](https://images.microbadger.com/badges/image/toke/mosquitto.svg)](https://microbadger.com/images/toke/mosquitto "Get your own image badge on microbadger.com")


## Run

    docker run -ti -p 1883:1883 -p 9001:9001 toke/mosquitto

Exposes Port 1883 (MQTT) 9001 (Websocket MQTT)

## Running with persistence


### Local directories / External Configuration

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

    # Copy the files from the config directory of this project
    # into /src/mqtt/config. Change them as needed for your
    # particular needs.

    docker run -ti -p 1883:1883 -p 9001:9001 \
    -v /srv/mqtt/config:/mqtt/config:ro \
    -v /srv/mqtt/log:/mqtt/log \
    -v /srv/mqtt/data/:/mqtt/data/ \
    --name mqtt toke/mosquitto

Volumes: /mqtt/config, /mqtt/data and /mqtt/log

### Docker Volumes for persistence

Using [Docker Volumes](https://docs.docker.com/engine/userguide/containers/dockervolumes/) for persistence.

Create a named volume:

    docker volume create --name mosquitto_data

Now it can be attached to docker by using `-v mosquitto_data:/mqtt/data` in the
Example above. Be aware that the permissions within the volumes
are most likely too restrictive.

## Start with systemd

As an example this how you run the container with systemd.
The example uses a docker volume named `mosquitto_data` (see above).

    [Unit]
    Description=Mosquitto MQTT docker container
    Requires=docker.service
    Wants=docker.service
    After=docker.service

    [Service]
    Environment=EXT_IP=123.123.123.123
    Restart=always
    ExecStart=/usr/bin/docker run -v /srv/mqtt/config:/mqtt/config -v /srv/mqtt/log:/mqtt/log -v mosquitto_data:/mqtt/data/ -p ${EXT_IP}:1883:1883 -p ${EXT_IP}:8883:8883 -p 127.0.0.1:9001:9001 --name mqtt toke/mosquitto
    ExecStop=/usr/bin/docker stop -t 2 mqtt
    ExecStopPost=/usr/bin/docker rm -f mqtt

    [Install]
    WantedBy=local.target


## Build

    git clone https://github.com/toke/docker-mosquitto.git
    cd docker-mosquitto
    docker build .

## Other Containers

The puprose of this Container was to provide a configurable and dsecent mosquitto broker.
The Eclipse Mosquitto Project now provides a very similar Container:
[Eclipse Mosquitto Container](https://hub.docker.com/_/eclipse-mosquitto/) It should be
easy to migrate to it.

## Authors and license

docker-mosquitto was written by:

* **Thomas Kerpe** | [web](https://toke.de/) | [mail](mailto:web@toke.de) | [GitHub](https://github.com/toke/)
* With contributions from:
 * [Andrea Pinazzi](https://github.com/onip)
 * [m0se](https://github.com/m0se)
 * [David Medinets](https://github.com/medined)
 * [Gavin de Kock](https://github.com/gavindekock)
 * [Raphael Ahrens](https://github.com/tantSinnister)

License: [BSD 3-Clause](https://tldrlegal.com/license/bsd-3-clause-license-%28revised%29)


## Contact

Contact: Thomas Kerpe [toke@toke.de](mailto:toke@toke.de)

OpenPGP fingerprint: `B5AD 7FCB 270D A762 46D2  A8F2 B0E6 5607 ABE5 7238`
