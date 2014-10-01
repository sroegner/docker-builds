hostname := namenode
thirdoctet := 40
include ../shared/Makefile.vars
include ../shared/Makefile

image:	
	cp -rv ../shared/config.supervisor $(CURDIR)/conf.supervisor
	cp -rv ../shared/config.zk $(CURDIR)/conf.zk
	$(DOCKER_CMD) build -t=$(tag) .
	$(DOCKER_CMD) run --hostname=$(hostname) --env="JAVA_HOME=/usr" $(tag) /tmp/format-namenode.sh
	$(DOCKER_CMD) commit --author="Steffen Roegner <steffen.roegner@gmail.com>" $$($(DOCKER_CMD) ps -l -q) $(tag)

image-datanode:	
	$(DOCKER_CMD) build -t=$(tag)-datanode $(CURDIR)/datanode

container:
	$(DOCKER_CMD) run --user=root -d \
			--publish="$(IP):8020:8020" \
			--publish="$(IP):8010:8010" \
			--publish="$(IP):8042:8042" \
			--publish="$(IP):8088:8088" \
			--publish="$(IP):50070:50070" \
			--publish="$(IP):19888:19888" \
			--publish="$(IP):2181:2181" \
			--publish="$(IP):2212:2212" \
			--name=$(container_name) \
			--hostname=$(hostname) \
			$(tag) /usr/bin/supervisord -n
	$(DOCKER_CMD) ps 

container-dnode1:
	$(DOCKER_CMD) run --user=root -d \
			--publish="127.10.$(thirdoctet).21:8010:8010" \
			--publish="127.10.$(thirdoctet).21:8042:8042" \
			--publish="127.10.$(thirdoctet).21:8088:8088" \
			--publish="127.10.$(thirdoctet).21:2212:2212" \
			--link=$(container_name):namenode \
			--name=$(container_name)-dnode1 \
			--hostname=dnode1 \
			$(tag)-datanode /usr/bin/supervisord -n
	$(DOCKER_CMD) ps 

container-dnode2:
	$(DOCKER_CMD) run --user=root -d \
			--publish="127.10.$(thirdoctet).22:8010:8010" \
			--publish="127.10.$(thirdoctet).22:8042:8042" \
			--publish="127.10.$(thirdoctet).22:8088:8088" \
			--publish="127.10.$(thirdoctet).22:2212:2212" \
			--link=$(container_name):namenode \
			--name=$(container_name)-dnode2 \
			--hostname=dnode2 \
			$(tag)-datanode /usr/bin/supervisord -n
	$(DOCKER_CMD) ps 

container-dnode3:
	$(DOCKER_CMD) run --user=root -d \
			--publish="127.10.$(thirdoctet).23:8010:8010" \
			--publish="127.10.$(thirdoctet).23:8042:8042" \
			--publish="127.10.$(thirdoctet).23:8088:8088" \
			--publish="127.10.$(thirdoctet).23:2212:2212" \
			--link=$(container_name):namenode \
			--name=$(container_name)-dnode3 \
			--hostname=dnode3 \
			$(tag)-datanode /usr/bin/supervisord -n
	$(DOCKER_CMD) ps 

push-datanode:
	$(DOCKER_CMD) push $(tag)-datanode

clean:
	sudo docker rm -f $(container_name)-dnode1 || :
	sudo docker rm -f $(container_name)-dnode2 || :
	sudo docker rm -f $(container_name)-dnode3 || :
	sudo docker rm -f $(container_name)-dnode4 || :
	sudo docker rm -f $(container_name) || :

