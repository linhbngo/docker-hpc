# This is a Dockerfile to build a head node for a cluster

# We will start from a base Alpine
FROM alpine:3.9.4

USER root

RUN apk update

RUN apk add --no-cache perl libc-dev linux-headers bash

RUN apk add --no-cache openrc openssh nano openldap-clients

#RUN apk add --no-cache gcc g++ make
#RUN  wget --quiet https://download.open-mpi.org/release/open-mpi/v4.0/openmpi-4.0.1.tar.gz && \
#  gunzip -c openmpi-4.0.1.tar.gz | tar xf - && \
#  cd openmpi-4.0.1 && \
#  ./configure --prefix=/software/openmpi/4.0.1 && \
#  make all install

RUN wget --quiet https://raw.githubusercontent.com/linhbngo/docker-hpc/master/src/sleep.sh -O /usr/local/bin/sleep.sh

RUN ["chmod", "+x", "/usr/local/bin/sleep.sh"]

ENTRYPOINT ["/usr/local/bin/sleep.sh"]
