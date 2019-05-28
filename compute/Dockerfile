# This is a Dockerfile to build a head node for a cluster

# We will start from a base CentOS7
FROM centos:centos7

COPY ./compute.sh /usr/local/bin
ENTRYPOINT ["/usr/local/bin/compute.sh"]
