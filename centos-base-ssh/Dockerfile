# centos:centos6
# adding some packages and a jdk all needed in hadoop
# + openssh server run by supervisor

FROM centos:centos6

RUN yum -y update && \
    rpm -Uvh http://dl.fedoraproject.org/pub/epel/6/i386/epel-release-6-8.noarch.rpm && \
    yum -y install openssl snappy snappy-devel lzo lzo-devel unzip sudo telnet curl python-pip openssh-server rsync which tar git bind-utils tcpdump strace java-1.7.0-openjdk-devel.x86_64 && \
    yum clean all && \
    pip install supervisor 

ADD . /docker
RUN mkdir -p /root/.ssh; \
    chmod 700 /root/.ssh; \
    cp -v /docker/srkey.pub /root/.ssh/authorized_keys; \
    chmod 600 /root/.ssh/authorized_keys && \
    mkdir -p /var/run/sshd && \
    chmod 700 /var/run/sshd && \
    /etc/init.d/sshd start && \
    mkdir -p /etc/supervisor/conf.d /var/log/supervisor && \
    cp /docker/supervisord-sshd.conf /etc/supervisor/conf.d/sshd.conf && \
    cp /docker/supervisord.conf /etc/

EXPOSE 22

CMD ["/usr/bin/supervisord", "-n"]
