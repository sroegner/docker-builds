dnsdomain := docker.local

include ../shared/Makefile.vars
hostname_template := $(container_name).$(dnsdomain)
master_hostname := namenode-$(hostname_template)
include ../shared/Makefile

all:
	echo "Can do 'clean', 'image' or 'container'"

image:
	$(DOCKER_CMD) build -t=$(tag) .

container:
	$(DOCKER_CMD) run -d --dns=127.0.0.1 --hostname=$(master_hostname) --name=$(container_name) $(tag) /usr/bin/supervisord -n
	echo IP address of $(master_hostname) is $$($(DOCKER_CMD) inspect --format '{{ .NetworkSettings.IPAddress }}' $(container_name))
	echo http://$$($(DOCKER_CMD) inspect --format '{{ .NetworkSettings.IPAddress }}' $(container_name)):50095
	echo Accumulo Proxy at $$($(DOCKER_CMD) inspect --format '{{ .NetworkSettings.IPAddress }}' $(container_name)):42424

cluster:
	$(DOCKER_CMD) run -d --name=consul-leader --hostname=consul.node.doop.local $(tag) /usr/sbin/consul agent -server -bootstrap-expect=1 -data-dir=/var/lib/consul/data -config-dir=/etc/consul-leader
	$(DOCKER_CMD) run -d --dns-search=node.doop.local --hostname=namenode.node.doop.local --dns="$$($(DOCKER_CMD) inspect --format '{{ .NetworkSettings.IPAddress }}' consul-leader)" -e="SVCLIST=namenode,secondarynamenode,datanode" --name=$(container_name) --link=consul-leader:consul-leader $(tag) /usr/bin/supervisord -n
	sleep 1
	$(DOCKER_CMD) run -d --dns-search=node.doop.local --hostname=resourcemanager.node.doop.local --dns="$$($(DOCKER_CMD) inspect --format '{{ .NetworkSettings.IPAddress }}' consul-leader)" -e="SVCLIST=resourcemanager" --name=$(container_name)-rm --link=consul-leader:consul-leader $(tag) /usr/bin/supervisord -n
	$(DOCKER_CMD) run -d --dns-search=node.doop.local --hostname=zookeeper.node.doop.local --dns="$$($(DOCKER_CMD) inspect --format '{{ .NetworkSettings.IPAddress }}' consul-leader)" -e="SVCLIST=zookeeper" --name=$(container_name)-zk0 --link=consul-leader:consul-leader $(tag) /usr/bin/supervisord -n
	sleep 30
	$(DOCKER_CMD) exec $(container_name) ps -fC java
	$(DOCKER_CMD) exec $(container_name) /usr/lib/accumulo/bin/init_accumulo.sh
	$(DOCKER_CMD) run -d --dns-search=node.doop.local --hostname=tserver0.node.doop.local --dns="$$($(DOCKER_CMD) inspect --format '{{ .NetworkSettings.IPAddress }}' consul-leader)" -e="SVCLIST=datanode,nodemanager,accumulo-tserver" --name=$(container_name)-tserver0 --link=consul-leader:consul-leader $(tag) /usr/bin/supervisord -n
	$(DOCKER_CMD) run -d --dns-search=node.doop.local --hostname=tserver1.node.doop.local --dns="$$($(DOCKER_CMD) inspect --format '{{ .NetworkSettings.IPAddress }}' consul-leader)" -e="SVCLIST=datanode,nodemanager,accumulo-tserver" --name=$(container_name)-tserver1 --link=consul-leader:consul-leader $(tag) /usr/bin/supervisord -n
	$(DOCKER_CMD) run -d --dns-search=node.doop.local --hostname=master.node.doop.local --dns="$$($(DOCKER_CMD) inspect --format '{{ .NetworkSettings.IPAddress }}' consul-leader)" -e="SVCLIST=accumulo-master,accumulo-monitor,accumulo-gc,accumulo-tracer" --name=$(container_name)-master --link=consul-leader:consul-leader $(tag) /usr/bin/supervisord -n
	echo http://$$($(DOCKER_CMD) inspect --format '{{ .NetworkSettings.IPAddress }}' $(container_name)-master):50095

clean:
	sudo docker rm -f consul-leader || :
	sudo docker rm -f $(container_name)-zk0 || :
	sudo docker rm -f $(container_name)-rm || :
	sudo docker rm -f $(container_name)-tserver0 || :
	sudo docker rm -f $(container_name)-tserver1 || :
	sudo docker rm -f $(container_name)-master || :
	sudo docker rm -f $(container_name) || :

exec-consul:
	$(DOCKER_CMD) exec -i -t consul-leader /bin/bash

exec-dn0:
	$(DOCKER_CMD) exec -i -t $(container_name)-dn0 /bin/bash

exec-dn1:
	$(DOCKER_CMD) exec -i -t $(container_name)-dn1 /bin/bash


