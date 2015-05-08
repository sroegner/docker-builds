all:
	echo "Can do 'clean', 'erase', 'image', 'push', 'shell' or 'container' (and then 'ssh', and 'logs')"

clean:
	rm -rvf conf.*
	$(DOCKER_CMD) stop $(container_name) || :
	$(DOCKER_CMD) rm $(container_name) || :

image:	
	$(DOCKER_CMD) build -t=$(tag) .

push:
	$(DOCKER_CMD) push -f $(tag)

container:
	$(DOCKER_CMD) run -d --name=$(container_name) $(volumes) \
			--hostname=$(hostname) $(tag) /usr/bin/supervisord -n
ssh:
	ssh $(sshopts) root@$$(docker inspect --format '{{ .NetworkSettings.IPAddress }}' $(container_name))

exec:
	$(DOCKER_CMD) exec -i -t $(container_name) /bin/bash

shell:
	$(DOCKER_CMD) run -i -t $(tag) /bin/bash

erase: clean
	$(DOCKER_CMD) rmi $(tag) 

logs:
	$(DOCKER_CMD) logs $(container_name)

info:
	echo "Buildinfo for $(tag)"

