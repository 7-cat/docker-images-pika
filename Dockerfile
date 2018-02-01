FROM centos:latest
MAINTAINER eva <wj.dev@qq.com>

RUN yum -y install snappy-devel protobuf-compiler protobuf-devel bzip2-devel zlib-devel bzip2 git && \
    mkdir -p /data1/download 



RUN cd /data1/download && \
    git clone https://github.com/Qihoo360/pika.git pika && \
    cd /data1/download/pika && \
    git submodule init && \
    git submodule update 



RUN cd /data1/download/pika && \
    make __REL=1 && \
    cp -f ./output/lib/libglog.so.0 /usr/lib64/ && \
    rm -f /lib64/libstdc++.so && \
    rm -f /lib64/libstdc++.so.6 && \
    ln -s /usr/local/lib64/libstdc++.so /lib64/libstdc++.so && \
    ln -s /usr/local/lib64/libstdc++.so.6 /lib64/libstdc++.so.6 && \
    cp -R ./output /usr/local/pika && \
    mkdir -p /data1/pika/log && \
    mkdir -p /data1/pika/db && \
    mkdir -p /data1/pika/dbsync && \
    mkdir -p /data1/pika/dump && \
    touch /data1/pika/pika.pid && \
    sed -i 's/thread-num\s*:.*/thread-num : 4/g' /usr/local/pika/conf/pika.conf && \
    sed -i 's/log-path\s*:.*/log-path : \/data1\/pika\/log/g' /usr/local/pika/conf/pika.conf && \
    sed -i 's/db-path\s*:.*/db-path : \/data1\/pika\/db/g' /usr/local/pika/conf/pika.conf && \
    sed -i 's/dump-path\s*:.*/dump-path : \/data1\/pika\/dump/g' /usr/local/pika/conf/pika.conf && \
    sed -i 's/log-path\s*:.*/log-path : \/data1\/pika\/log/g' /usr/local/pika/conf/pika.conf && \
    sed -i 's/pidfile\s*:.*/pidfile : \/data1\/pika\/pika.pid/g' /usr/local/pika/conf/pika.conf && \
    cd /data1 && \
    rm -Rf /data1/download && \
    yum erase -y git               

RUN cd /data1/download && \
    yum install -y wget gcc gcc-c++ make bzip2 && \
    wget -O /data1/download/gcc-6.1.0.tar.bz2 http://mirrors.ustc.edu.cn/gnu/gcc/gcc-6.1.0/gcc-6.1.0.tar.bz2 && \
    tar jxf gcc-6.1.0.tar.bz2 && \
    cd /data1/download/gcc-6.1.0 && \
    ./contrib/download_prerequisites && \
    ./configure --enable-checking=release --enable-languages=c,c++ --disable-multilib && \
    make -j4 && \
    make install && \
    yum -y erase wget gcc gcc-c++ bzip && \
    yum clean all && \
    rm -Rf /data1/download  