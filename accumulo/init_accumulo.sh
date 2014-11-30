#!/bin/bash

if [ -f /etc/hadoop/conf/core-site.xml ]
then
  namenode_host=$(grep 8020 /etc/hadoop/conf/core-site.xml|sed 's%.*hdfs://%%'|awk -F':' '{print $1}')
fi

if [ "${namenode_host}" != "$(hostname)" ]
then
  supervisorctl stop all
  /etc/hadoop/conf.templates/format-namenode.sh
fi

supervisorctl start all

su - hdfs << EOF
echo
echo "Preparing for Accumulo initialization"
JAVA_HOME=/usr HADOOP_ROOT_LOGGER="ERROR,console" HADOOP_LIBEXEC_DIR=/usr/lib/hadoop/libexec /usr/lib/hadoop-hdfs/bin/hdfs dfs -mkdir /accumulo /user/accumulo
JAVA_HOME=/usr HADOOP_ROOT_LOGGER="ERROR,console" HADOOP_LIBEXEC_DIR=/usr/lib/hadoop/libexec /usr/lib/hadoop-hdfs/bin/hdfs dfs -chown accumulo:accumulo /accumulo /user/accumulo
JAVA_HOME=/usr HADOOP_ROOT_LOGGER="ERROR,console" HADOOP_LIBEXEC_DIR=/usr/lib/hadoop/libexec /usr/lib/hadoop-hdfs/bin/hdfs dfs -ls /
EOF

NAMENODE_HOST=$(grep master /etc/hosts|tail -1|awk '{print $2}')
HOSTNAME=$(hostname)
IP=$(hostname -I)
CONF=/var/lib/accumulo/conf

echo "The namenode is ${NAMENODE_HOST}"
echo "This host is $HOSTNAME"
rm -rf $CONF
cp -r ${CONF}.templates $CONF

if [ "NAMENODE_HOST" != "" ]
then
  sed -i "s/{{ master_hostname }}/${NAMENODE_HOST}/g" ${CONF}/*
fi

for f in masters monitor gc tracers slaves
do
  echo $HOSTNAME > ${CONF}/$f
done

echo
echo "Initializing Accumulo"
su - accumulo -c '/usr/lib/accumulo/bin/accumulo init --instance-name accumulo --password DOCKERDEFAULT'
mv /var/lib/accumulo/supervisord-accumulo.conf /etc/supervisor/conf.d/accumulo.conf
mv /var/lib/accumulo/supervisord-accumulo-tserver.conf /etc/supervisor/conf.d/accumulo-tserver.conf

