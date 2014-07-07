box_name = $(notdir $(CURDIR))
tag := sroegner/$(box_name)

all:
	echo "Can do 'clean', 'image' or 'container'"

clean:
	sudo docker stop $(box_name) || :
	sleep 2
	sudo docker rm $(box_name) || :

image:	
	sudo docker build -t=$(tag) .
	sudo docker run -d --name=accbuild --hostname=namenode -p=127.0.0.10:2244:22 $(tag) /usr/bin/supervisord -n
	sleep 5
	ssh -i dotssh/accumulo -p 2244 root@127.0.0.10 /docker/init_accumulo.sh
	sudo docker commit --author="Steffen Roegner <steffen.roegner@gmail.com>" accbuild $(tag)
	sudo docker stop accbuild || :
	sleep 2
	sudo docker rm accbuild || :

container:
	sudo docker run -d --name=$(box_name) --hostname=namenode -p=127.0.0.10:2244:22 -p=127.0.0.10:2181:2181 -p=127.0.0.10:50070:50070 -p=127.0.0.10:50095:50095 $(tag) /usr/bin/supervisord -n
	sudo docker ps 

ssh:
	ssh -i dotssh/accumulo -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -p 2244 root@127.0.0.10

erase:	clean
	sudo docker rmi $(tag)

push:
	sudo docker push $(tag)

