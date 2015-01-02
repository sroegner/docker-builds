# centos:centos6
# adding some packages and a jdk all needed in hadoop
# + openssh server run by supervisor

#FROM sroegner/centos-base:6
FROM centos:centos6
MAINTAINER Steffen Roegner "steffen.roegner@gmail.com"
USER root

ENV REFRESHED_AT 2014-10-02
ENV JAVA_HOME /usr
ENV JAVA /usr/bin/java

RUN rpm -ivh http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
#RUN curl -b oraclelicense=accept-securebackup-cookie -L http://download.oracle.com/otn-pub/java/jdk/7u71-b14/jdk-7u71-linux-x64.rpm -O; \
#    rpm -ivh jdk-7u71-linux-x64.rpm && rm -rf jdk-7u71-linux-x64.rpm

RUN yum -y -q upgrade; \
    yum -y install python-pip openssl snappy snappy-devel lzo lzo-devel unzip sudo telnet openssh-server rsync which tar git bind-utils passwd java-1.7.0-openjdk-devel; \
    yum clean all; \
    pip install supervisor 

RUN mkdir -p /root/.ssh; \
    chmod 700 /root/.ssh; \
    mkdir -p /var/run/sshd; \
    chmod 700 /var/run/sshd; \
    sed -i "s/GSSAPIAuthentication yes/GSSAPIAuthentication no/" /etc/ssh/sshd_config; \
    sed -i "s/#Port 22/Port 2212/" /etc/ssh/sshd_config; \
    /etc/init.d/sshd start; \
    ssh-keygen -q -t dsa -f /root/.ssh/id_dsa -N '' -C 'keypair generated during docker build' && cat /root/.ssh/id_dsa.pub > /root/.ssh/authorized_keys; \
    chmod 600 /root/.ssh/authorized_keys; \
    echo changeme | passwd --stdin root; \
    mkdir -p /etc/supervisor/conf.d /var/log/supervisor

COPY supervisord-sshd.conf /etc/supervisor/conf.d/sshd.conf
COPY supervisord.conf /etc/
COPY insecure.pub /tmp/

RUN cat /tmp/insecure.pub >> /root/.ssh/authorized_keys

EXPOSE 2212

CMD ["/usr/bin/supervisord", "-n"]
