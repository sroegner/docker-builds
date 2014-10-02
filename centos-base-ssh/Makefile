hostname := centos-base
thirdoctet := 11
include ../shared/Makefile.vars
tag := "$(reg)/$(box_name):6"
include ../shared/Makefile

image:
	cp ../shared/insecure.pub $(CURDIR)/
	$(DOCKER_CMD) build -t=$(tag) .

