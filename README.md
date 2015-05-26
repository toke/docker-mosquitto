docker-mosquitto
================

Docker image for mosquitto

## Run

    docker run -tip 1883:1883 toke/mosquitto

Exposes Port 1883

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
    
    docker run -ti --rm -p 1883:1883 \
    -v /srv/mqtt/config:/mqtt/config:ro \
    -v /srv/mqtt/log:/mqtt/log \
    -v /srv/mqtt/data/:/mqtt/data/ \
    --name mqtt toke/mosquitto 


Volumes: /mqtt/config, /mqtt/data and /mqtt/log




