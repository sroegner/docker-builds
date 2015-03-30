#!/bin/bash

#  supervisorctl start doop-datanode:\*
if [ "$SVCLIST" != "" ]
then
  services=(${SVCLIST//,/ })
  for svc in "${services[@]}"
  do
    svccheck=/etc/consul/services/${svc}_service.json
    [ -f $svccheck ] && cp $svccheck /etc/consul
    supervisorctl start $svc
  done
fi

supervisorctl restart consul

