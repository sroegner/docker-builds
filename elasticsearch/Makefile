include ../shared/Makefile.vars
include ../shared/Makefile

container:
	$(DOCKER_CMD) run -d --name=$(container_name) $(tag)

shell:
	$(DOCKER_CMD) run -t -i --name=$(container_name) $(tag) /usr/bin/bash
