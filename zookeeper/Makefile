hostname := centos-base
thirdoctet := 20
include ../shared/Makefile.vars
tag := "$(reg)/$(box_name):6"
include ../shared/Makefile

image:
	cp -r ../shared/config.supervisor conf.supervisor
	cp -r ../shared/config.zk conf.zk
	$(DOCKER_CMD) build -t=$(tag) .

container:
	$(DOCKER_CMD) run -d --name=$(container_name) --publish=$(IP):2181:2181 $(tag)
	$(DOCKER_CMD) ps 


