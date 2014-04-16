box_name = $(notdir $(CURDIR))
tag := sroegner/$(box_name)

all:
	echo "Can do 'clean', 'image' or 'container'"

clean:
	sudo docker stop $(box_name) || :
	sudo docker rm $(box_name) || :

image:	
	sudo docker build -t=$(tag) .

push:
	sudo docker push $(tag)

container:
	sudo docker run -d --user=root --name=$(box_name) -h=nexus-test -p=127.0.0.10:8081:8081 -p=127.0.0.10::22 $(tag) /usr/bin/supervisord -n
	sleep 2
	sudo docker logs $(box_name)
	echo
	echo "Nexus will be available at http://$$(sudo docker port nexus 8081)"

ssh:
	ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -p $$(sudo docker port $(box_name) 22|awk -F':' '{print $$2}') root@127.0.0.10

erase:	clean
	sudo docker rmi $(tag)

shell:
	sudo docker run -i -t --hostname=nexus-test $(tag) /bin/bash

logs:
	sudo docker logs $(box_name)

