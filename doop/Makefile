dnsdomain := docker.local

include ../shared/Makefile.vars
hostname_template := $(container_name).$(dnsdomain)
include ../shared/Makefile

image:	
	cp -rv ../shared/config.zk $(CURDIR)/conf.zk
	$(DOCKER_CMD) build -t=$(tag) .

cluster:
	$(DOCKER_CMD) run -d --name=consul-leader --hostname=consul.doop-cluster.local $(tag) /usr/sbin/consul agent -server -bootstrap-expect=1 -data-dir=/var/lib/consul/data -config-dir=/etc/consul-leader
	$(DOCKER_CMD) run -d --dns="$$($(DOCKER_CMD) inspect --format '{{ .NetworkSettings.IPAddress }}' consul-leader)" -e="SVCLIST=namenode,secondarynamenode" --name=$(container_name) --hostname=namenode-$(hostname_template) --link=consul-leader:consul-leader $(tag) /usr/bin/supervisord -n
	$(DOCKER_CMD) run -d --dns="$$($(DOCKER_CMD) inspect --format '{{ .NetworkSettings.IPAddress }}' consul-leader)" -e="SVCLIST=datanode" --name=$(container_name)-dn0 --hostname=dn0-$(hostname_template) --link=consul-leader:consul-leader $(tag) /usr/bin/supervisord -n

clean:
	sudo docker rm -f consul-leader || :
	sudo docker rm -f $(container_name)-dn0 || :
	sudo docker rm -f $(container_name)-dn1 || :
	sudo docker rm -f $(container_name) || :

