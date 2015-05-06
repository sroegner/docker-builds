#!/bin/bash

su - hdfs << EOF
echo
echo "Preparing for Accumulo initialization"
JAVA_HOME=/usr HADOOP_ROOT_LOGGER="ERROR,console" /usr/bin/hdfs dfs -mkdir -p /user /tmp
JAVA_HOME=/usr HADOOP_ROOT_LOGGER="ERROR,console" /usr/bin/hdfs dfs -mkdir /accumulo /user/accumulo
JAVA_HOME=/usr HADOOP_ROOT_LOGGER="ERROR,console" /usr/bin/hdfs dfs -chown accumulo:accumulo /accumulo /user/accumulo
JAVA_HOME=/usr HADOOP_ROOT_LOGGER="ERROR,console" /usr/bin/hdfs dfs -ls /
EOF

echo "Initializing Accumulo"
su - accumulo -c '/usr/lib/accumulo/bin/accumulo init --instance-name accumulo --password DOCKERDEFAULT'
#mv /var/lib/accumulo/supervisord-accumulo.conf /etc/supervisor/conf.d/accumulo.conf
#mv /var/lib/accumulo/supervisord-accumulo-tserver.conf /etc/supervisor/conf.d/accumulo-tserver.conf

