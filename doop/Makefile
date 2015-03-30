dnsdomain := docker.local

include ../shared/Makefile.vars
hostname_template := $(container_name).$(dnsdomain)
include ../shared/Makefile

image:	
	cp -rv ../shared/config.zk $(CURDIR)/conf.zk
	$(DOCKER_CMD) build -t=$(tag) .

cluster:
	$(DOCKER_CMD) run -d --name=consul-leader $(tag) /usr/sbin/consul agent -server -bootstrap-expect=1 -data-dir=/var/lib/consul/data -config-dir=/etc/consul-leader
	sleep 3
	$(DOCKER_CMD) run -d --dns-search=doop.local --dns="$$($(DOCKER_CMD) inspect --format '{{ .NetworkSettings.IPAddress }}' consul-leader)" -e="SVCLIST=namenode,secondarynamenode" --name=$(container_name) --link=consul-leader:consul-leader $(tag) /usr/bin/supervisord -n
	sleep 10
	$(DOCKER_CMD) run -d --dns-search=doop.local --dns="$$($(DOCKER_CMD) inspect --format '{{ .NetworkSettings.IPAddress }}' consul-leader)" -e="SVCLIST=resourcemanager" --name=$(container_name)-rm --link=consul-leader:consul-leader $(tag) /usr/bin/supervisord -n
	sleep 10
	dig @$$($(DOCKER_CMD) inspect --format '{{ .NetworkSettings.IPAddress }}' consul-leader) namenode.service.doop.local ANY
	$(DOCKER_CMD) run -d --dns-search=doop.local --dns="$$($(DOCKER_CMD) inspect --format '{{ .NetworkSettings.IPAddress }}' consul-leader)" -e="SVCLIST=datanode,nodemanager" --name=$(container_name)-dn0 --link=consul-leader:consul-leader $(tag) /usr/bin/supervisord -n
	$(DOCKER_CMD) run -d --dns-search=doop.local --dns="$$($(DOCKER_CMD) inspect --format '{{ .NetworkSettings.IPAddress }}' consul-leader)" -e="SVCLIST=datanode,nodemanager" --name=$(container_name)-dn1 --link=consul-leader:consul-leader $(tag) /usr/bin/supervisord -n

clean:
	sudo docker rm -f consul-leader || :
	sudo docker rm -f $(container_name)-rm || :
	sudo docker rm -f $(container_name)-dn0 || :
	sudo docker rm -f $(container_name)-dn1 || :
	sudo docker rm -f $(container_name) || :

exec-consul:
	$(DOCKER_CMD) exec -i -t consul-leader /bin/bash

exec-dn0:
	$(DOCKER_CMD) exec -i -t $(container_name)-dn0 /bin/bash

exec-dn1:
	$(DOCKER_CMD) exec -i -t $(container_name)-dn1 /bin/bash

info:
	$(DOCKER_CMD) inspect --format '{{ .NetworkSettings.IPAddress }}' consul-leader
	$(DOCKER_CMD) inspect --format '{{ .NetworkSettings.IPAddress }}' $(container_name)
	$(DOCKER_CMD) inspect --format '{{ .NetworkSettings.IPAddress }}' $(container_name)-dn0
	$(DOCKER_CMD) inspect --format '{{ .NetworkSettings.IPAddress }}' $(container_name)-dn1
	$(DOCKER_CMD) inspect --format '{{ .NetworkSettings.IPAddress }}' $(container_name)-rm

consul-logs:
	$(DOCKER_CMD) logs -f consul-leader

