FROM centos:7
MAINTAINER Steffen Roegner "steffen.roegner@gmail.com"
USER root

ENV JAVA_HOME=/usr
ENV HADOOP_HOME=/usr/hdp/current/hadoop-client
ENV HADOOP_HDFS_HOME=/usr/hdp/current/hadoop-hdfs-client
ENV HADOOP_MAPRED_HOME=/usr/hdp/current/hadoop-mapreduce-client
ENV HADOOP_YARN_HOME=/usr/hdp/current/hadoop-yarn-client
ENV HADOOP_LIBEXEC_DIR=/usr/hdp/current/hadoop-client/libexec
ENV CONSUL_VERSION=0.5.0

ENV REFRESHED_AT 2015-03-29

RUN rpm -ivh http://epel.mirror.constant.com/7/x86_64/e/epel-release-7-5.noarch.rpm; \
    yum -y -q upgrade; \
    yum -y install python-pip snappy lzo rsync which tar bind-utils java-1.7.0-openjdk-devel unzip; \
    yum clean all; \
    pip install supervisor 

RUN curl -L http://public-repo-1.hortonworks.com/HDP/centos6/2.x/GA/2.2.0.0/hdp.repo -o /etc/yum.repos.d/hdp.repo; \
    yum -y install hadoop hadoop-hdfs hadoop-libhdfs hadoop-yarn hadoop-mapreduce hadoop-client zookeeper 
    
RUN mkdir -p /data1/hdfs /data1/mapred /data1/yarn /var/log/hadoop /var/log/hadoop-yarn /var/log/supervisor /var/log/consul /var/lib/consul/data /var/lib/consul/ui /etc/consul /etc/consul-leader /var/lib/zookeeper; \
    chown hdfs.hadoop /data1/hdfs && \
    chown mapred.hadoop /data1/mapred && \
    chown yarn.hadoop /data1/yarn; \
    chown zookeeper.hadoop /var/lib/zookeeper; \
    chmod 775 /var/log/hadoop; chgrp hadoop /var/log/hadoop; \
    curl -L https://github.com/kelseyhightower/confd/releases/download/v0.9.0/confd-0.9.0-linux-amd64 -o /usr/sbin/confd && \
    curl -L https://dl.bintray.com/mitchellh/consul/${CONSUL_VERSION}_linux_amd64.zip -o /tmp/c.zip && \
    curl -L https://dl.bintray.com/mitchellh/consul/${CONSUL_VERSION}_web_ui.zip -o /tmp/ui.zip && \
    unzip /tmp/c.zip -d /usr/sbin && \
    unzip /tmp/ui.zip -d /var/lib/consul/ui && \
    chmod 755 /usr/sbin/confd

COPY supervisord.conf /etc/
COPY hadoop /etc/hadoop/conf
COPY conf.zk/zookeeper-env.sh /etc/zookeeper/conf/
COPY conf.zk/zoo.cfg /etc/zookeeper/conf/
COPY check_hadoop.sh /usr/local/sbin/
COPY bootstrap-node.conf /etc/supervisor/conf.d/
COPY bootstrap-node.sh /usr/local/sbin/
COPY hadoop-group.conf /etc/supervisor/conf.d/
COPY consul/consul.conf /etc/supervisor/conf.d/
COPY consul /etc/consul/
COPY consul/consul.json /etc/consul-leader/

USER hdfs
RUN HADOOP_ROOT_LOGGER="WARN,console" /usr/bin/hdfs namenode -format
USER root
VOLUME /etc/hadoop/conf
