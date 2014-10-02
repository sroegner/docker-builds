hostname := firefox-vnc
thirdoctet := 39
include ../shared/Makefile.vars
include ../shared/Makefile


firefox:	clean container
	ssh -X $(sshopts) root@$(IP) firefox

