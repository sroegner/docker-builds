all:
	echo "Can do 'clean', 'erase', 'image', 'push', 'shell' or 'container' (and then 'ssh', and 'logs')"

clean:
	rm -rvf conf.*
	rm -vf $(CIDFILE)
	$(DOCKER_CMD) stop $(box_name) || :
	$(DOCKER_CMD) rm $(box_name) || :

image:	
	$(DOCKER_CMD) build -t=$(tag) .

push:
	$(DOCKER_CMD) push $(tag)

container:
	$(DOCKER_CMD) run -d --name=$(box_name) $(volumes) \
			--hostname=$(hostname) \
			--publish=$(IP):22:22 \
			--publish=$(IP):80:80 \
			--publish=$(IP):443:443 \
			--publish=$(IP):3000:3000 \
			--cidfile=$(CIDFILE) \
			$(tag) /usr/bin/supervisord -n
	$(DOCKER_CMD) ps 

ssh:
	ssh -i $(CURDIR)/../centos-base-ssh/srkey root@$(IP)

shell:
	$(DOCKER_CMD) run -i -t $(tag) /bin/bash

erase: clean
	$(DOCKER_CMD) rmi $(tag) 

logs:
	$(DOCKER_CMD) logs $(box_name)

