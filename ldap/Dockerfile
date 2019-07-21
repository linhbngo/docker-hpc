# This is a Dockerfile to build a head node for a cluster

# We will start from a base Ubuntu 18.04
FROM ubuntu:18.04

USER root

ENV SLAPD_PASSWORD goldenram
ENV SLAPD_DOMAIN ldap.golden.ram

RUN apt-get update

RUN apt-get install -yqq wget

RUN wget --quiet https://raw.githubusercontent.com/linhbngo/docker-hpc/master/src/sleep.sh -O /usr/local/bin/sleep.sh

RUN ["chmod", "+x", "/usr/local/bin/sleep.sh"]

EXPOSE 389 80 443
ENTRYPOINT ["/usr/local/bin/sleep.sh"]
