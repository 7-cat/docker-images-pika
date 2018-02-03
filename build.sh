#!/bin/sh

git clone https://github.com/Qihoo360/pika.git /tmp/code --depth 1
cd /tmp/code

make

mv /tmp/code/output /pika

mkdir -p /data/pika/log && \
    mkdir -p /data/pika/db && \
    mkdir -p /data/pika/dbsync && \
    mkdir -p /data/pika/dump && \
    sed -i 's/thread-num\s*:.*/thread-num : 4/g' /pika/pika.conf && \
    sed -i 's/log-path\s*:.*/log-path : \/data\/pika\/log/g' /pika/pika.conf && \
    sed -i 's/db-path\s*:.*/db-path : \/data\/pika\/db/g' /pika/pika.conf && \
    sed -i 's/db-sync-path\s*:.*/db-sync-path : \/data\/pika\/dbsync/g' /pika/pika.conf && \
    sed -i 's/dump-path\s*:.*/dump-path : \/data\/pika\/dump/g' /pika/pika.conf 
#sed -i 's/pidfile\s*:.*/pidfile : \/data\/pika\/pika.pid/g' /pika/conf/pika.conf

rm -rf /tmp/code

yum -y remove snappy-devel protobuf-devel gflags-devel glog-devel gcc-c++ make git && yum clean all 
