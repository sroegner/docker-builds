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
	sudo docker run -d --name=$(box_name) -p=127.0.0.12:2211:22 $(tag) /usr/bin/supervisord -n
	sudo docker ps 

shell:
	sudo docker run -i -t $(tag) /bin/bash

ssh:
	ssh -i $(CURDIR)/srkey -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -p 2211 root@127.0.0.12

erase:	clean
	sudo docker rmi $(tag)

