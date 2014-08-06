hostname := namenode
thirdoctet := 20
include ../shared/Makefile.vars
include ../shared/Makefile

image:	
	sudo docker build -t=$(tag) .
	sudo docker run --hostname=$(hostname) $(tag) /docker/format-namenode.sh
	sudo docker commit --author="Steffen Roegner <steffen.roegner@gmail.com>" $$(sudo docker ps -l -q) $(tag)

