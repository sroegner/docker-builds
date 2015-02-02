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

