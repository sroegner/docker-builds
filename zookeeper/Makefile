
all:
	echo "Can do 'clean', 'image' or 'container'"

clean:
	sudo docker stop zookeeper
	sudo docker rm zookeeper

image:	
	sudo docker build -t='sroegner/zookeeper' .

container:
	sudo docker run -name=zookeeper -h=zookeeper -p 127.0.0.10:2181:2181 -d sroegner/zookeeper
	sudo docker ps 

commit:
	sudo docker commit -author="Steffen Roegner <steffen.roegner@gmail.com>" \
			-run='{"Cmd": ["/usr/lib/zookeeper/bin/zkServer.sh", "start-foreground"], "PortSpecs": ["2181"]}' \
			$$(sudo docker ps -q zookeeper) \
			sroegner/zookeeper

