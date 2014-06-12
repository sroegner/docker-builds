box_name = $(notdir $(CURDIR))
tag := sroegner/$(box_name)
sshopts := -oStrictHostKeyChecking=no -oUserKnownHostsFile=/dev/null

all:
	echo "Can do 'clean', 'image' or 'container'"

clean:
	sudo docker stop $(box_name) || :
	sudo docker rm $(box_name) || :

image: keypair	
	sudo docker build -t=$(tag) .

push:
	sudo docker push $(tag)

keypair:
	test -f $(CURDIR)/srkey || ssh-keygen -q -t dsa -b 1024 -N '' -C 'docker ssh key' -f $(CURDIR)/srkey

container:
	sudo docker run -d --name=$(box_name) -h=namenode -P $(tag) /usr/bin/supervisord -n
	sudo docker ps 

shell:
	sudo docker run -i -t $(tag) /bin/bash

ssh:
	ssh $(sshopts) -p $$(sudo docker port $(box_name) 22|awk -F':' '{print $$2}') root@localhost

