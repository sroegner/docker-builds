FROM sroegner/centos-base-ssh:6
MAINTAINER Steffen Roegner 'steffen.roegner@gmail.com'

RUN curl -L http://public-repo-1.hortonworks.com/HDP/centos6/2.x/GA/2.1-latest/hdp.repo -o /etc/yum.repos.d/hdp.repo; \
    yum -y install zookeeper

COPY conf.supervisor/zookeeper.conf /etc/supervisor/conf.d/
COPY conf.zk/zookeeper-env.sh /etc/zookeeper/conf/
COPY conf.zk/zoo.cfg /etc/zookeeper/conf/

EXPOSE 2181

#CMD ["/usr/bin/supervisord", "-n"]
USER zookeeper
ENTRYPOINT ["/usr/lib/zookeeper/bin/zkServer.sh", "start-foreground"]

