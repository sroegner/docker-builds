dnsdomain := docker.local
thirdoctet := 40
include ../shared/Makefile.vars
hostname_template := $(container_name).$(dnsdomain)
master_hostname := master-$(hostname_template)
include ../shared/Makefile

all:
	echo "Can do 'clean', 'image' or 'container'"

image:	clean
	$(DOCKER_CMD) build -t=$(tag) .
	$(DOCKER_CMD) run -d --name=$(container_name) --hostname=$(master_hostname) -p=127.0.0.10:2212:2212 $(tag) /usr/bin/supervisord -n
	sleep 5
	$(DOCKER_CMD) exec $(container_name) ps -ef
	$(DOCKER_CMD) exec $(container_name) /var/lib/accumulo/init_accumulo.sh
	$(DOCKER_CMD) commit --author="Steffen Roegner <steffen.roegner@gmail.com>" $(container_name) $(tag)
	$(DOCKER_CMD) rm -f $(container_name) || :

container:
	$(DOCKER_CMD) run -d --dns=127.0.0.1 --hostname=$(master_hostname) --name=$(container_name) $(tag) /usr/bin/supervisord -n
	echo IP address of $(master_hostname) is $$($(DOCKER_CMD) inspect --format '{{ .NetworkSettings.IPAddress }}' $(container_name))
	echo http://$$($(DOCKER_CMD) inspect --format '{{ .NetworkSettings.IPAddress }}' $(container_name)):50095
	echo Accumulo Proxy at $$($(DOCKER_CMD) inspect --format '{{ .NetworkSettings.IPAddress }}' $(container_name)):42424

