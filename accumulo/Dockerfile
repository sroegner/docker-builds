FROM sroegner/doop

RUN yum -y install rsync
RUN rpm -Uvh --nodeps http://apache.osuosl.org/accumulo/1.5.1/accumulo-1.5.1-bin.rpm
RUN echo -e "1\n2"|/opt/accumulo/accumulo-1.5.1/bin/bootstrap_config.sh
RUN sed -i 's%path/to%usr/lib%g' /opt/accumulo/accumulo-1.5.1/conf/accumulo-env.sh

EXPOSE 2181
EXPOSE 50070
EXPOSE 50095

CMD ["/usr/bin/supervisord", "-n"]
