all:
	echo "Can do 'clean', 'image' or 'container'"
clean:
	sudo docker stop saltmaster
	sudo docker rm saltmaster

image:	
	sudo docker build -rm -t='sroegner/saltmaster' .

container:
	sudo docker run \
	-v="$$(pwd)/saltfiles/salt:/etc/salt" \
	-v="$$(pwd)/saltfiles/srv:/srv" \
	-name=saltmaster \
	-p='127.0.0.10:4505:4505' \
	-p='127.0.0.10:4506:4506' \
	-p='2244:22' \
	-d sroegner/saltmaster
	sudo docker ps 
	sleep 3
	sudo docker logs $$(sudo docker ps -l -q)
