#!/bin/bash

#  supervisorctl start doop-datanode:\*
if [ "$SVCLIST" != "" ]
then
  services=(${SVCLIST//,/ })
  for svc in "${services[@]}"
  do
    supervisorctl start $svc
  done
fi
