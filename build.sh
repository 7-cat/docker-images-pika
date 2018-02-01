#!/bin/sh

git clone https://github.com/Qihoo360/pika.git /tmp/code --depth 1
cd /tmp/code
make
echo "----ls /tmp"
ls /tmp
echo "---lls /tmp/code"
ls /tmp/code
echo "---ls /tmp/code/output"
ls /tmp/code/output
mv /tmp/code/output /pika

rm -rf /tmp/code

yum -y remove snappy-devel protobuf-devel gflags-devel glog-devel gcc-c++ make git && yum clean all 
