# This is a Dockerfile to build a head node for a cluster

# We will start from a base Alpine
FROM alpine:3.9.4

USER root

ENV SLAPD_PASSWORD goldenram
ENV SLAPD_DOMAIN ldap.golden.ram

RUN apk update

RUN apk add --no-cache openldap openrc openssh nano openldap-back-mdb

RUN wget --quiet https://raw.githubusercontent.com/linhbngo/docker-hpc/master/src/sleep.sh -O /usr/local/bin/sleep.sh

RUN ["chmod", "+x", "/usr/local/bin/sleep.sh"]

EXPOSE 389
ENTRYPOINT ["/usr/local/bin/sleep.sh"]
