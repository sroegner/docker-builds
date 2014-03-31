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
	sudo docker run -u hdfs --env='JAVA_HOME=/usr/lib/java' -h=namenode $(tag) /usr/lib/hadoop/bin/hdfs namenode -format
	sudo docker run -u root --hostname=namenode $(tag):latest /usr/bin/yum clean all
	sudo docker commit --author="Steffen Roegner <steffen@sqrrl.com>" --run='{"Cmd": ["/usr/bin/supervisord", "-n"], "PortSpecs": ["22","2181","50070", "8088"]}' $$(sudo docker ps -l -q) $(tag)

push:
	sudo docker push $(tag)

container:
	sudo docker run -d --name=$(box_name) -h=namenode -P $(tag) /usr/bin/supervisord -n
	sudo docker logs $(box_name)

erase:	clean
	sudo docker rmi $(tag)

shell:
	sudo docker run -i -t --hostname=namenode $(tag) /bin/bash

