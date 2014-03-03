FROM centos

RUN yum -y install http://dl.fedoraproject.org/pub/epel/6/i386/epel-release-6-8.noarch.rpm
RUN yum -y update
RUN yum -y install openssh-server python-devel python-pip zlib-devel gcc supervisor git tar passwd salt-master salt-minion python-halite --enablerepo=epel
RUN pip install GitPython
RUN mkdir -p /var/run/sshd && chmod 700 /var/run/sshd
RUN mkdir -p /var/cache/salt
RUN service sshd start
RUN echo saltmaster | passwd --stdin root

VOLUME /etc/salt
VOLUME /srv

EXPOSE 22
EXPOSE 4505
EXPOSE 4506

ADD ./supervisord.conf /etc/supervisord.conf
CMD ["/usr/bin/supervisord", "-n"]
