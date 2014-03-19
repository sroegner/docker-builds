
all:
	echo "Can do 'clean', 'image' or 'container'"

clean:
	sudo docker stop accmaster || :
	sudo docker rm accmaster || :

image:	
	sudo docker build -rm -t='sroegner/accumulo' .
	#sudo docker run -h=namenode sroegner/accumulo "/usr/bin/supervisord && /opt/accumulo/accumulo-1.5.1/bin/accumulo init --instance-name=accumulo --password=secret"
	#id=$$(sudo docker ps -l -q); \
	#sudo docker commit --author="Steffen Roegner <steffen.roegner@gmail.com>" --run='{"Cmd": ["/usr/bin/supervisord", "-n"], "PortSpecs": ["2181","50070"]}' "$$id" sroegner/accumulo

container:
	sudo docker run -d --name=accmaster -h=namenode -p=127.0.0.10:2244:22 -p=127.0.0.10:2181:2181 -p=127.0.0.10:50070:50070 -p=127.0.0.10:50095:50095 sroegner/accumulo /usr/bin/supervisord -n
	sudo docker ps 

