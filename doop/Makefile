
all:
	echo "Can do 'clean', 'image' or 'container'"

clean:
	sudo docker stop namenode || :
	sudo docker rm namenode || :

image:	
	sudo docker build -rm -t='sroegner/doop' .
	sudo docker run -u hdfs --env='JAVA_HOME=/usr/lib/java' -h=namenode sroegner/doop hadoop namenode -format
	id=$$(sudo docker ps -l -q); \
	sudo docker commit --author="Steffen Roegner <steffen.roegner@gmail.com>" --run='{"Cmd": ["/usr/bin/supervisord", "-n"], "PortSpecs": ["2181","50070"]}' "$$id" sroegner/doop

container:
	sudo docker run -d -name=namenode -h=namenode -p=2181:2181 -p=50070:50070 sroegner/doop /usr/bin/supervisord -n
	sudo docker ps 

