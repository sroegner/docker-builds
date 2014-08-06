hostname := firefox-vnc
thirdoctet := 30
include ../shared/Makefile.vars
include ../shared/Makefile


firefox:	clean container
	ssh  -i $(CURDIR)/../centos-base-ssh/srkey -X -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no root@$(IP) firefox

