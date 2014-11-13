dnsdomain := docker.local
thirdoctet := 40
include ../shared/Makefile.vars
hostname_template := $(container_name).$(dnsdomain)
include ../shared/Makefile

image:	
	cp -rv ../shared/config.supervisor $(CURDIR)/conf.supervisor
	cp -rv ../shared/config.zk $(CURDIR)/conf.zk
	$(DOCKER_CMD) build -t=$(tag) .
	$(DOCKER_CMD) run --hostname=namenode --env="JAVA_HOME=/usr" $(tag) /etc/hadoop/conf.templates/format-namenode.sh
	$(DOCKER_CMD) commit --author="Steffen Roegner <steffen.roegner@gmail.com>" $$($(DOCKER_CMD) ps -l -q) $(tag)

image-datanode:	
	$(DOCKER_CMD) build -t=$(tag)-datanode $(CURDIR)/datanode

container:
	$(DOCKER_CMD) run --user=root -d \
			--name=$(container_name) \
			--hostname=namenode-$(hostname_template) \
			$(tag) /usr/bin/supervisord -n
	sleep 3
	ssh $(sshopts) -p 2212 root@$$($(DOCKER_CMD) inspect --format '{{ .NetworkSettings.IPAddress }}' $(container_name)) /etc/supervisor/run_namenode.sh
	$(DOCKER_CMD) inspect --format '{{ .NetworkSettings.IPAddress }}' $(container_name) 

container-dnode1:
	$(DOCKER_CMD) run --user=root -d \
			--link=$(container_name):namenode-$(hostname_template) \
			--name=$(container_name)-dnode1 \
			--hostname=dnode1-$(hostname_template) \
			$(tag)-datanode /usr/bin/supervisord -n
	$(DOCKER_CMD) inspect --format '{{ .NetworkSettings.IPAddress }}' $(container_name)-dnode1 

container-dnode2:
	$(DOCKER_CMD) run --user=root -d \
			--link=$(container_name):namenode-$(hostname_template) \
			--name=$(container_name)-dnode2 \
			--hostname=dnode2-$(hostname_template) \
			$(tag)-datanode /usr/bin/supervisord -n
	$(DOCKER_CMD) inspect --format '{{ .NetworkSettings.IPAddress }}' $(container_name)-dnode2 

container-dnode3:
	$(DOCKER_CMD) run --user=root -d \
			--link=$(container_name):namenode-$(hostname_template) \
			--name=$(container_name)-dnode3 \
			--hostname=dnode3-$(hostname_template) \
			$(tag)-datanode /usr/bin/supervisord -n
	$(DOCKER_CMD) inspect --format '{{ .NetworkSettings.IPAddress }}' $(container_name)-dnode3 

container-dnode4:
	$(DOCKER_CMD) run --user=root -d \
			--link=$(container_name):namenode-$(hostname_template) \
			--name=$(container_name)-dnode4 \
			--hostname=dnode4-$(hostname_template) \
			$(tag)-datanode /usr/bin/supervisord -n
	$(DOCKER_CMD) inspect --format '{{ .NetworkSettings.IPAddress }}' $(container_name)-dnode4 

push-datanode:
	$(DOCKER_CMD) push $(tag)-datanode

clean:
	sudo docker rm -f $(container_name)-dnode1 || :
	sudo docker rm -f $(container_name)-dnode2 || :
	sudo docker rm -f $(container_name)-dnode3 || :
	sudo docker rm -f $(container_name)-dnode4 || :
	sudo docker rm -f $(container_name) || :

