FROM sroegner/doop

RUN yum -y install rsync
RUN rpm -Uvh --nodeps http://apache.osuosl.org/accumulo/1.5.1/accumulo-1.5.1-bin.rpm

RUN cp -r /docker/accumulo.conf/* /opt/accumulo/accumulo-1.5.1/conf/

EXPOSE 2181
EXPOSE 50070
EXPOSE 50095

CMD ["/usr/bin/supervisord", "-n"]
