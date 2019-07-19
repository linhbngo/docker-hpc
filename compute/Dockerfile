# This is a Dockerfile to build a head node for a cluster

# We will start from a base Alpine
FROM alpine:3.9.4

USER root

RUN apk update

RUN wget --quiet https://raw.githubusercontent.com/linhbngo/docker-hpc/master/src/sleep.sh -O /usr/local/bin/sleep.sh

#COPY ./compute.sh /usr/local/bin/compute.sh
RUN ["chmod", "+x", "/usr/local/bin/sleep.sh"]
ENTRYPOINT ["/usr/local/bin/sleep.sh"]
