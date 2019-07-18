# This is a Dockerfile to build a head node for a cluster

# We will start from a base CentOS7
FROM alpine:3.9.4

USER root

RUN apk update

RUN apk add --no-cache perl gcc g++ make libc-dev linux-headers bash

RUN  wget --quiet https://download.open-mpi.org/release/open-mpi/v4.0/openmpi-4.0.1.tar.gz && \
  gunzip -c openmpi-4.0.1.tar.gz | tar xf - && \
  cd openmpi-4.0.1 && \
  ./configure --prefix=/software/openmpi/4.0.1 && \
  make all install

COPY ./head.sh /usr/local/bin
ENTRYPOINT ["/usr/local/bin/head.sh"]
