FROM debian:jessie

MAINTAINER Thomas Kerpe <toke@toke.de>


RUN apt-get update && apt-get install -y wget && \
    wget -q -O - http://repo.mosquitto.org/debian/mosquitto-repo.gpg.key | apt-key add - && \
    wget -q -O /etc/apt/sources.list.d/mosquitto-jessie.list http://repo.mosquitto.org/debian/mosquitto-jessie.list && \
    apt-get update && apt-get install -y mosquitto && \
    adduser --system --disabled-password --disabled-login mosquitto

COPY config /mqtt/config
RUN chown -R mosquitto:mosquitto /mqtt
VOLUME ["/mqtt/config", "/mqtt/data", "/mqtt/log"]


EXPOSE 1883 9001
CMD /usr/sbin/mosquitto -c /mqtt/config/mosquitto.conf
