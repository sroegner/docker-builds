#!/bin/bash

# this relies on a container named namenode* to this datanode
NAMENODE_HOST=$(grep namenode /etc/hosts|tail -1|awk '{print $2}')
HOSTNAME=$(hostname)
IP=$(hostname -I|tr -d ' ')
CONF=/var/lib/accumulo/conf

if [ $(echo ${HOSTNAME} | grep -c namenode) -ne 0 ]
then
  type=namenode
else
  type=datanode
fi

echo "Startup $(hostname) as ${type}"

if [ "${type}" = namenode ]
then

  if [ -f /etc/hadoop/conf/core-site.xml ]
  then
    namenode_host=$(grep 8020 /etc/hadoop/conf/core-site.xml|sed 's%.*hdfs://%%'|awk -F':' '{print $1}')
  fi

  if [ "${namenode_host}" != "${HOSTNAME}" ]
  then
    /etc/hadoop/conf.templates/format-namenode.sh || :
    export ACCUMULO_INIT=true
  fi

  supervisorctl start doop-namenode:\*

  if [ "${ACCUMULO_INIT}" = true ]
  then
su hdfs << EOF
  echo
  echo "Preparing for Accumulo initialization"
  HADOOP_ROOT_LOGGER="ERROR,console" HADOOP_LIBEXEC_DIR=/usr/lib/hadoop/libexec /usr/bin/hdfs dfs -mkdir /accumulo /user/accumulo
  HADOOP_ROOT_LOGGER="ERROR,console" HADOOP_LIBEXEC_DIR=/usr/lib/hadoop/libexec /usr/bin/hdfs dfs -chown accumulo:accumulo /accumulo /user/accumulo
  HADOOP_ROOT_LOGGER="ERROR,console" HADOOP_LIBEXEC_DIR=/usr/lib/hadoop/libexec /usr/bin/hdfs dfs -ls /
EOF

    echo "The namenode is ${NAMENODE_HOST}"
    rm -rf $CONF
    cp -r ${CONF}.templates $CONF
    sed -i "s/{{ namenode_hostname }}/${NAMENODE_HOST}/g" ${CONF}/*
    sed -i "s/{{ datanode_hostname }}/${HOSTNAME}/g" ${CONF}/*
    for f in masters monitor gc tracers slaves
    do
      echo $IP > ${CONF}/$f
    done

    echo "Initializing Accumulo"
    su - accumulo -c '/usr/lib/accumulo/bin/accumulo init --instance-name accumulo --password DOCKERDEFAULT'
    supervisorctl start accumulo-master:\*
  fi
else
  rm -rf /etc/hadoop/conf /data1/hdfs/* /data1/yarn/* /data1/mapred/*
  cp -r /etc/hadoop/conf.templates /etc/hadoop/conf
  sed -i "s/{{ datanode_hostname }}/${HOSTNAME}/g" /etc/hadoop/conf/*

  if [ "NAMENODE_HOST" != "" ]
  then
    sed -i "s/{{ namenode_hostname }}/${NAMENODE_HOST}/g" /etc/hadoop/conf/*
  fi

  SSHOPTS='-p 22 -oStrictHostKeyChecking=no -oUserKnownHostsFile=/dev/null'
ssh ${SSHOPTS}  root@${NAMENODE_HOST}<<EOF
    echo "${IP} ${HOSTNAME}" >> /etc/hosts
    echo "${HOSTNAME}" >> /etc/hadoop/conf/slaves
    supervisorctl restart dnsmasq
EOF
  supervisorctl start doop-datanode:\*
fi
