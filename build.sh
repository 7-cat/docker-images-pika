#!/bin/sh

git clone https://github.com/Qihoo360/pika.git /tmp/code --depth 1
cd /tmp/code
make
mv /tmp/code/output /data/pika

rm -rf /tmp/code

yum -y remove snappy-devel protobuf-devel gflags-devel glog-devel gcc-c++ make git && yum clean all 
