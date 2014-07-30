box_name = $(notdir $(CURDIR))
tag := sroegner/$(box_name)
hostname := firefox-vnc

all:
	echo "Can do 'clean', 'image' or 'container'"

clean:
	rm -rvf conf.*
	sudo docker stop $(box_name) || :
	sudo docker rm $(box_name) || :

image:	
	sudo docker build -t=$(tag) .

push:
	sudo docker push $(tag)

container:
	sudo docker run -d --user=root --name=$(box_name) --hostname=$(hostname) -P $(tag) /usr/bin/supervisord -n
	sleep 2
	sudo docker logs $(box_name)

ssh:
	ssh -X -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -p $$(sudo docker port $(box_name) 22|awk -F':' '{print $$2}') root@localhost

firefox:
	ssh  -i $(CURDIR)/../centos-base-ssh/srkey -X -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -p $$(sudo docker port $(box_name) 22|awk -F':' '{print $$2}') root@localhost firefox

erase:	clean
	sudo docker rmi $(tag)

shell:
	sudo docker run -i -t --hostname=$(hostname) $(tag) /bin/bash

logs:
	sudo docker logs $(box_name)
