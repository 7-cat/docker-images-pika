FROM centos:latest
MAINTAINER eva <wj.dev@qq.com>

RUN rpm -ivh https://mirrors.ustc.edu.cn/epel/epel-release-latest-7.noarch.rpm && \
    yum -y update && \
    yum -y install snappy-devel && \
    yum -y install protobuf-devel && \
    yum -y install gflags-devel && \
    yum -y install glog-devel && \
    yum -y install gcc-c++ && \
    yum -y install make && \
    yum -y install git && \
    mkdir /pika

COPY . /pika

WORKDIR /pika

RUN sh /pika/build.sh

VOLUME /data/pika

EXPOSE 9221

ENTRYPOINT /pika/output/bin/pika -c /pika/pika.conf