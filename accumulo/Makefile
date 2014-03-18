
all:
	echo "Can do 'clean', 'image' or 'container'"

clean:
	sudo docker stop accmaster || :
	sudo docker rm accmaster || :

image:	
	sudo docker build -rm -t='sroegner/accumulo' .
	sudo docker run -u accumulo -h=namenode sroegner/accumulo ls
	id=$$(sudo docker ps -l -q); \
	sudo docker commit --author="Steffen Roegner <steffen.roegner@gmail.com>" --run='{"Cmd": ["/usr/bin/supervisord", "-n"], "PortSpecs": ["2181","50070"]}' "$$id" sroegner/doop

container:
	sudo docker run -d -name=accmaster -h=accmaster -p=2181:2181 -p=50070:50070 sroegner/doop /usr/bin/supervisord -n
	sudo docker ps 

