# This is a Dockerfile to build a head node for a cluster

# We will start from a base CentOS7
FROM centos:centos7

RUN yum update -y

RUN yum install -y wget perl gcc gcc-c++ make cmake && /
  wget --quiet https://download.open-mpi.org/release/open-mpi/v4.0/openmpi-4.0.1.tar.gz && /
  gunzip -c openmpi-4.0.1.tar.gz | tar xf - && /
  ./configure --prefix=/opt/openmpi/4.0.1 && /
  make all install
COPY ./head.sh /usr/local/bin
ENTRYPOINT ["/usr/local/bin/head.sh"]
