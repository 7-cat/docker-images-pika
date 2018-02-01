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
    yum -y install git

COPY . /data/pika

WORKDIR /data/pika

RUN sh /data/pika/build.sh

VOLUME /data/pika

EXPOSE 9221

ENTRYPOINT ./output/bin/pika -c ./pika.conf