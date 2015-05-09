tag=docker.io/sroegner/accumulo
container_name=accumulo-cluster-0
# the link to the leader allows the consul agents inside the containers
# to communicate - every node has the consul web ui on port 8500
link_arg="--link=consul-leader:consul-leader"

if [ "$1" = "-clean" ]
then
  echo cleaning up as requested
  docker rm -f consul-leader
	for c in namenode zk0 tserver0 tserver1 tserver2 master proxy
	do
		docker rm -f ${container_name}-${c}
	done
fi

# start a single (not recommended) consul leader container
echo start consul leader
docker run -d --name=consul-leader \
              --hostname=consul.node.doop.local ${tag} \
							/usr/sbin/consul agent -server -bootstrap-expect=1 \
							-data-dir=/var/lib/consul/data -config-dir=/etc/consul-leader

# need the ip of the consul server as the dns address used by all others
dns_ip=$(docker inspect --format '{{ .NetworkSettings.IPAddress }}' consul-leader)

echo start hdfs
# start the namenode, secondarynamenode and a datanode process
# the datanode process is a compromise to allow accumulo init to create dfs objects
docker run -d --dns=${dns_ip} --dns-search=node.doop.local \
              --hostname=namenode.node.doop.local ${link_arg} \
              -e="SVCLIST=namenode,secondarynamenode,datanode" \
							--name=${container_name}-namenode ${tag} /usr/bin/supervisord -n

echo start a zookeeper container before init
docker run -d --dns=${dns_ip} --dns-search=node.doop.local \
              --hostname=zookeeper.node.doop.local ${link_arg} \
              -e="SVCLIST=zookeeper" \
              --name=${container_name}-zk0  ${tag} /usr/bin/supervisord -n

echo hdfs needs a moment to become available
sleep 20
# now we can go back to the namenode and run accumulo init
# this will create some state in dfs and zookeeper
docker exec ${container_name}-namenode /usr/lib/accumulo/bin/init_accumulo.sh

echo start tservers
# ready to start some tablet servers
docker run -d --dns=${dns_ip} --dns-search=node.doop.local \
              --hostname=tserver0.node.doop.local ${link_arg} \
							-e="SVCLIST=datanode,accumulo-tserver" \
							--name=${container_name}-tserver0 ${tag} /usr/bin/supervisord -n

docker run -d --dns=${dns_ip} --dns-search=node.doop.local \
              --hostname=tserver1.node.doop.local ${link_arg} \
							-e="SVCLIST=datanode,accumulo-tserver" \
							--name=${container_name}-tserver1 ${tag} /usr/bin/supervisord -n

docker run -d --dns=${dns_ip} --dns-search=node.doop.local \
              --hostname=tserver2.node.doop.local ${link_arg} \
							-e="SVCLIST=datanode,accumulo-tserver" \
							--name=${container_name}-tserver2 ${tag} /usr/bin/supervisord -n

echo start accumulo master
docker run -d --dns=${dns_ip} --dns-search=node.doop.local \
							--hostname=master.node.doop.local ${link_arg} \
							-e="SVCLIST=accumulo-master,accumulo-monitor,accumulo-gc,accumulo-tracer" \
							--name=${container_name}-master ${tag} /usr/bin/supervisord -n

echo start accumulo proxy
docker run -d --dns=${dns_ip} --dns-search=node.doop.local \
							--hostname=proxy.node.doop.local ${link_arg} \
							-e="SVCLIST=accumulo-proxy" \
							--name=${container_name}-proxy ${tag} /usr/bin/supervisord -n

sleep 20
# creating an accumulo user should now work

echo create user alfred with password batman
docker exec ${container_name}-tserver0 /tmp/add_user.sh alfred batman
echo
master_ip=$(docker inspect --format '{{ .NetworkSettings.IPAddress }}' ${container_name}-master)
echo "Accumulo Monitor is at http://${master_ip}:50095"
echo "Check cluster service health at http://${dns_ip}:8500"
echo
echo -e "Login to accumulo with \n\t docker exec -it ${container_name}-tserver0 su - accumulo -c \"/usr/lib/accumulo/bin/accumulo shell -u alfred -p batman\""
echo
