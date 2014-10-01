# Docker Builds

A collection of docker projects for daily use - generally testing. The general idea includes the use of a Makefile for interaction with and automated configuration of images and containers:

* directory name is the box name (from which the image and container names are derived)
* general make commands include
  * _image_: yes - make an image
  * _container_: create a new container
  * _ssh_: log into a running container (if supervisor/sshd are running)
  * _shell_: run a shell container using the current image
  * _logs_
  * _clean_: stop and remove container(s), remove temporary files
  * _erase_: clean + remove the image

Some of the projects have more make commands available. To avoid collisions as good as possible any container will only bind to one specific loopback IP. Worked into IP determination is - among other things - the environment variable EXECUTOR_NUMBER (defaulting to 0) which if set inside a jenkins job allows for parallel execution of the same container without bind conflicts.

## centos-base-ssh

All other projects build on top of this. OpenJDK7, ssh (running on port 2212) on top of CentOS 6.

## zookeeper

Just runs a single zookeeper process, no ssh.

## doop

Fully configured HDP-2.1 namenode (runs sshd, namenode, secondarynamenode, resourcemanager, nodemanager, jobhistory and zookeeper via supervisor). The processes can be restarted via supervisorctl, the setup is ready to run map/reduce jobs.

### additional data nodes

The additional doop-datanode image allows attachment of multiple additional datanode/nodemanager containers.

    make container
    make container-dnode1
    make container-dnode2

will yield 

![alt text](https://github.com/sroegner/docker-builds/raw/master/doop/doop-cluster.png "doop cluster with two datanode containers")

