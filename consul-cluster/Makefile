box_name = $(notdir $(CURDIR))
tag := sroegner/$(box_name):3.1
sshopts := -oStrictHostKeyChecking=no -oUserKnownHostsFile=/dev/null
data_dir := /var/lib/consul/data
ui_dir := /var/lib/consul/ui/dist

all:
	echo "Can do 'clean', 'image' or 'container'"

image:
	sudo docker build -t=$(tag) .

push:
	sudo docker push $(tag)

shell:
	sudo docker run -i -t $(tag) /bin/bash

clean:
	sudo docker stop server1 || :
	sudo docker rm server1 || :
	sudo docker stop server2 || :
	sudo docker rm server2 || :
	sudo docker stop server3 || :
	sudo docker rm server3 || :
	sudo docker stop server4 || :
	sudo docker rm server4 || :
	sudo docker stop agent1 || :
	sudo docker rm agent1 || :
	sudo docker stop agent2 || :
	sudo docker rm agent2 || :
	sudo docker stop agent3 || :
	sudo docker rm agent3 || :

erase:	clean
	sudo docker rmi $(tag)

cluster:
	sudo docker run -d --dns=localhost --env='SRV_ARGS=-server -bootstrap' --name=server1 --hostname=server1 -p=127.0.0.20:2211:22 -p=127.0.0.20:8600:53 -p=127.0.0.20:8500:8500 $(tag) /usr/bin/supervisord -n
	sudo docker run -d --link=server1:peer --env='SRV_ARGS=-server -join=peer' --name=server2 --hostname=server2 -p=127.0.0.21:2211:22 -p=127.0.0.21:8500:8500 $(tag) /usr/bin/supervisord -n
	sudo docker run -d --link=server2:peer --env='SRV_ARGS=-server -join=peer' --name=server3 --hostname=server3 -p=127.0.0.22:2211:22 -p=127.0.0.22:8500:8500 $(tag) /usr/bin/supervisord -n
	sudo docker run -d --link=server3:peer --env='SRV_ARGS=-join=peer' --name=agent1 --hostname=agent1 -p=127.0.0.23:2211:22 -p=127.0.0.23:8500:8500 $(tag) /usr/bin/supervisord -n
	sudo docker run -d --link=agent1:peer --env='SRV_ARGS=-join=peer' --name=agent2 --hostname=agent2 -p=127.0.0.24:2211:22 -p=127.0.0.24:8500:8500 $(tag) /usr/bin/supervisord -n
	sudo docker run -d --link=agent2:peer --env='SRV_ARGS=-join=peer' --name=agent3 --hostname=agent3 -p=127.0.0.25:2211:22 -p=127.0.0.25:8500:8500 $(tag) /usr/bin/supervisord -n

cluster-noquorum2:
	sudo docker run -d --dns=localhost --env='SRV_ARGS=-server -bootstrap' --name=server1 --hostname=server1 -p=127.0.0.20:2211:22 -p=127.0.0.20:8600:53 -p=127.0.0.20:8500:8500 $(tag) /usr/bin/supervisord -n
	sudo docker run -d --link=server1:peer --env='SRV_ARGS=-server -join=peer' --name=server2 --hostname=server2 -p=127.0.0.21:2211:22 -p=127.0.0.21:8500:8500 $(tag) /usr/bin/supervisord -n
	sudo docker run -d --link=server1:peer --env='SRV_ARGS=-join=peer' --name=agent2 --hostname=agent2 -p=127.0.0.24:2211:22 -p=127.0.0.24:8500:8500 $(tag) /usr/bin/supervisord -n
	sudo docker run -d --link=agent2:peer --env='SRV_ARGS=-join=peer' --name=agent3 --hostname=agent3 -p=127.0.0.25:2211:22 -p=127.0.0.25:8500:8500 $(tag) /usr/bin/supervisord -n

cluster-noquorum4:
	sudo docker run -d --dns=localhost --env='SRV_ARGS=-server -bootstrap' --name=server1 --hostname=server1 -p=127.0.0.20:2211:22 -p=127.0.0.20:8600:53 -p=127.0.0.20:8500:8500 $(tag) /usr/bin/supervisord -n
	sudo docker run -d --link=server1:peer --env='SRV_ARGS=-server -join=peer' --name=server2 --hostname=server2 -p=127.0.0.21:2211:22 -p=127.0.0.21:8500:8500 $(tag) /usr/bin/supervisord -n
	sudo docker run -d --link=server2:peer --env='SRV_ARGS=-server -join=peer' --name=server3 --hostname=server3 -p=127.0.0.22:2211:22 -p=127.0.0.22:8500:8500 $(tag) /usr/bin/supervisord -n
	sudo docker run -d --link=server3:peer --env='SRV_ARGS=-server -join=peer' --name=server4 --hostname=server4 -p=127.0.0.26:2211:26 -p=127.0.0.26:8500:8500 $(tag) /usr/bin/supervisord -n
	sudo docker run -d --link=server3:peer --env='SRV_ARGS=-join=peer' --name=agent1 --hostname=agent1 -p=127.0.0.23:2211:22 -p=127.0.0.23:8500:8500 $(tag) /usr/bin/supervisord -n
	sudo docker run -d --link=agent1:peer --env='SRV_ARGS=-join=peer' --name=agent2 --hostname=agent2 -p=127.0.0.24:2211:22 -p=127.0.0.24:8500:8500 $(tag) /usr/bin/supervisord -n

server1:
	ssh -i $(CURDIR)/srkey -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -p 2211 root@127.0.0.20

agent1:
	ssh -i $(CURDIR)/srkey -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -p 2211 root@127.0.0.23
