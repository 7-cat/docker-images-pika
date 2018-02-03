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
    git clone https://github.com/Qihoo360/pika.git /tmp/code --depth 1 && \
    cd /tmp/code &&\
    make && \
    mkdir /pika && \
    mv /tmp/code/output /pika && \
    rm -rf /tmp/code &&\
    yum -y remove snappy-devel protobuf-devel gflags-devel glog-devel gcc-c++ make git && yum clean all 

# COPY . /pika

WORKDIR /pika

# RUN sh /pika/build.sh

# VOLUME /data/pika

# EXPOSE 9221

#ENTRYPOINT /pika/output/bin/pika -c /pika/pika.conf

ENTRYPOINT tail -f /pika/test.txt