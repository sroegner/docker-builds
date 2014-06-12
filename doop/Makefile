box_name = $(notdir $(CURDIR))
tag := sroegner/$(box_name)

all:
	echo "Can do 'clean', 'image' or 'container'"

clean:
	rm -rvf conf.*
	sudo docker stop $(box_name) || :
	sudo docker rm $(box_name) || :

image:	
	sudo docker build -t=$(tag) .
	sudo docker run -u hdfs --env='JAVA_HOME=/usr' --hostname=namenode $(tag) /usr/lib/hadoop/bin/hdfs namenode -format
	sudo docker commit --author="Steffen Roegner <steffen@sqrrl.com>" $$(sudo docker ps -l -q) $(tag)
	sudo docker run -u root  $(tag) /usr/bin/yum clean all
	sudo docker commit --author="Steffen Roegner <steffen@sqrrl.com>" $$(sudo docker ps -l -q) $(tag)

push:
	sudo docker push $(tag)

container:
	sudo docker run -d --user=root --name=$(box_name) -h=namenode -P $(tag) /usr/bin/supervisord -n
	sleep 2
	sudo docker logs $(box_name)

ssh:
	ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -p $$(sudo docker port $(box_name) 22|awk -F':' '{print $$2}') root@localhost

erase:	clean
	sudo docker rmi $(tag)

shell:
	sudo docker run -i -t --hostname=namenode $(tag) /bin/bash

logs:
	sudo docker logs $(box_name)
