
all:
	echo "Can do 'clean', 'image' or 'container'"

clean:
	sudo docker stop accmaster || :
	sleep 2
	sudo docker rm accmaster || :

image:	
	sudo docker build -rm -t='sroegner/accumulo' .
	sudo docker run -d --name=accbuild -h=namenode -p=127.0.0.10:2244:22 sroegner/accumulo /usr/bin/supervisord -n
	sleep 5
	ssh -i dotssh/accumulo -p 2244 root@127.0.0.10 /docker/init_accumulo.sh
	sudo docker commit --author="Steffen Roegner <steffen.roegner@gmail.com>" --run='{"Cmd": ["/usr/bin/supervisord", "-n"], "PortSpecs": ["2181","50070","50095","22"]}' accbuild sroegner/accumulo
	sudo docker stop accbuild || :
	sleep 2
	sudo docker rm accbuild || :

container:
	sudo docker run -d --name=accmaster -h=namenode -p=127.0.0.10:2244:22 -p=127.0.0.10:2181:2181 -p=127.0.0.10:50070:50070 -p=127.0.0.10:50095:50095 sroegner/accumulo /usr/bin/supervisord -n
	sudo docker ps 

