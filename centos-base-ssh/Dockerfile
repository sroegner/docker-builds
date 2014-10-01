# centos:centos6
# adding some packages and a jdk all needed in hadoop
# + openssh server run by supervisor

FROM sroegner/centos-base:6
MAINTAINER Steffen Roegner "steffen.roegner@gmail.com"
USER root

ENV REFRESHED_AT 2014-09-30
ENV JAVA_HOME /usr
ENV JAVA /usr/bin/java

RUN yum -y -q upgrade; \
    yum -y install openssl snappy snappy-devel lzo lzo-devel unzip sudo telnet curl python-pip openssh-server rsync which tar git bind-utils tcpdump strace java-1.7.0-openjdk-devel.x86_64; \
    yum clean all; \
    pip install supervisor 

RUN mkdir -p /root/.ssh; \
    chmod 700 /root/.ssh; \
    mkdir -p /var/run/sshd; \
    chmod 700 /var/run/sshd; \
    sed -i "s/GSSAPIAuthentication yes/GSSAPIAuthentication no/" /etc/ssh/sshd_config; \
    sed -i "s/#Port 22/Port 2212/" /etc/ssh/sshd_config; \
    /etc/init.d/sshd start; \
    ssh-keygen -q -t dsa -f /root/.ssh/id_dsa -N '' && cat /root/.ssh/id_dsa.pub > /root/.ssh/authorized_keys; \
    chmod 600 /root/.ssh/authorized_keys; \
    mkdir -p /etc/supervisor/conf.d /var/log/supervisor

COPY supervisord-sshd.conf /etc/supervisor/conf.d/sshd.conf
COPY supervisord.conf /etc/

EXPOSE 22

CMD ["/usr/bin/supervisord", "-n"]
