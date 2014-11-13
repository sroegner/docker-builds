all:
	echo "Can do 'clean', 'erase', 'image', 'push', 'shell' or 'container' (and then 'ssh', and 'logs')"

clean:
	rm -rvf conf.*
	$(DOCKER_CMD) stop $(container_name) || :
	$(DOCKER_CMD) rm $(container_name) || :

image:	
	$(DOCKER_CMD) build -t=$(tag) .

push:
	$(DOCKER_CMD) push $(tag)

container:
	$(DOCKER_CMD) run -d --name=$(container_name) $(volumes) \
			--hostname=$(hostname) \
			--publish=$(IP):2212:2212 \
			--publish=$(IP):80:80 \
			--publish=$(IP):443:443 \
			--publish=$(IP):3000:3000 \
			--cidfile=$(CIDFILE) \
			$(tag) /usr/bin/supervisord -n
	$(DOCKER_CMD) ps 

ssh:
	ssh $(sshopts) -p 2212 root@$$(docker inspect --format '{{ .NetworkSettings.IPAddress }}' $(container_name))

shell:
	$(DOCKER_CMD) run -i -t $(tag) /bin/bash

erase: clean
	$(DOCKER_CMD) rmi $(tag) 

logs:
	$(DOCKER_CMD) logs $(container_name)

info:
	echo "Buildinfo for $(tag)"

