#!/bin/bash

NAMENODE_HOST=$(grep namenode /etc/hosts|tail -1|awk '{print $2}')
HOSTNAME=$(hostname)
IP=$(hostname -I)

rm -rf /etc/hadoop/conf
cp -r /etc/hadoop/conf.templates /etc/hadoop/conf
sed -i "s/{{ datanode_hostname }}/${HOSTNAME}/g" /etc/hadoop/conf/*
if [ "NAMENODE_HOST" != "" ]
then
  sed -i "s/namenode/namenode ${NAMENODE_HOST}/g" /etc/hosts
  sed -i "s/{{ namenode_hostname }}/${NAMENODE_HOST}/g" /etc/hadoop/conf/*
fi

SSHOPTS='-p 2212 -oStrictHostKeyChecking=no -oUserKnownHostsFile=/dev/null'
ssh ${SSHOPTS}  root@${NAMENODE_HOST}<<EOF
  echo "${IP} ${HOSTNAME}" >> /etc/hosts
  echo "${HOSTNAME}" >> /etc/hadoop/conf/slaves
  supervisorctl restart dnsmasq
EOF

exit 0

