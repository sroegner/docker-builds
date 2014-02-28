
all:
	echo "Can do 'clean', 'image' or 'container'"

clean:
	sudo docker stop namenode || :
	sudo docker rm namenode || :

image:	
	sudo docker build -rm -t='sroegner/doop' .
	sudo docker run -u hdfs --env='JAVA_HOME=/usr/lib/java' -h=namenode sroegner/doop hadoop namenode -format
	sudo docker ps -l -q | xargs -i sudo docker commit {} sroegner/doop

container:
	sudo docker run -d -name=namenode -h=namenode -p=8020:8020 -p=50070:50070 sroegner/doop /usr/bin/supervisord -n
	sudo docker ps 

