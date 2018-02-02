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

#RUN sh /pika/build.sh

RUN mkdir -p /data/pika/log && \
    mkdir -p /data/pika/db && \
    mkdir -p /data/pika/dbsync && \
    mkdir -p /data/pika/dump && \
    sed -i 's/thread-num\s*:.*/thread-num : 4/g' /pika/pika.conf && \
    sed -i 's/log-path\s*:.*/log-path : \/data\/pika\/log/g' /pika/pika.conf && \
    sed -i 's/db-path\s*:.*/db-path : \/data\/pika\/db/g' /pika/pika.conf && \
    sed -i 's/db-sync-path\s*:.*/db-sync-path : \/data\/pika\/dbsync/g' /pika/pika.conf && \
    sed -i 's/dump-path\s*:.*/dump-path : \/data\/pika\/dump/g' /pika/pika.conf 
#sed -i 's/pidfile\s*:.*/pidfile : \/data\/pika\/pika.pid/g' /pika/conf/pika.conf
RUN echo "222" && ls /pika
RUN cat /pika/pika.conf

VOLUME /data/pika

EXPOSE 9221

ENTRYPOINT /pika/output/bin/pika -c /pika/pika.conf