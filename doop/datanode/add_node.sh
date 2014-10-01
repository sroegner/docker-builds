#!/bin/bash

HOSTNAME=$(hostname)
IP=$(hostname -I)

ssh -p 2212 -oStrictHostKeyChecking=no -oUserKnownHostsFile=/dev/null  root@namenode<<EOF
  echo "${IP} ${HOSTNAME}" >> /etc/hosts
#  echo "$HOSTNAME" >> /etc/hadoop/conf/dfs.hosts
#  supervisorctl restart namenode
EOF

sleep 10

