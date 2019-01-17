FROM centos:7

RUN yum -y update && yum clean all

RUN mkdir -p /go && chmod -R 777 /go && \
    yum -y install git golang nmap-ncat curl wget && yum clean all

ENV GOPATH /go

RUN mkdir -p /opt/ofelia

ENV OFELIA_VERSION v0.2.2
ADD https://github.com/mcuadros/ofelia/releases/download/${OFELIA_VERSION}/ofelia_${OFELIA_VERSION}_linux_amd64.tar.gz /opt/
RUN tar zxvf /opt/ofelia_${OFELIA_VERSION}_linux_amd64.tar.gz  -C /opt/ofelia/ && cp /opt/ofelia/ofelia_linux_amd64/ofelia /opt/ofelia/
COPY conf.ini /opt/ofelia/

WORKDIR /opt/ofelia

