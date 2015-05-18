include ../shared/Makefile.vars
include ../shared/Makefile

container:
	$(DOCKER_CMD) run -d --name=$(container_name) $(tag)
	echo go to http://$$(docker inspect --format '{{ .NetworkSettings.IPAddress }}' $(container_name)):9200/_plugin/head

shell:
	$(DOCKER_CMD) run -t -i --rm --name=$(container_name)-shell $(tag) /usr/bin/bash
