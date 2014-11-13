FROM sroegner/centos-base-ssh:6
MAINTAINER Steffen Roegner "steffen.roegner@gmail.com"
USER root

ENV REFRESHED_AT 2014-09-30
RUN yum -y -q upgrade
RUN curl -L http://public-repo-1.hortonworks.com/HDP/centos6/2.x/GA/2.1-latest/hdp.repo -o /etc/yum.repos.d/hdp.repo; \
    yum -y install hadoop hadoop-hdfs hadoop-libhdfs hadoop-yarn hadoop-mapreduce hadoop-client flume zookeeper dnsmasq
    
RUN mkdir -p /data1/hdfs /data1/mapred /data1/yarn /data1/flume/spool-dir /var/log/hadoop; \
    rm -vf /etc/security/limits.d/hdfs.conf /etc/security/limits.d/mapreduce.conf /etc/security/limits.d/yarn.conf; \
    chown hdfs.hadoop /data1/hdfs && \
    chown mapred.hadoop /data1/mapred && \
    chown yarn.hadoop /data1/yarn && \
    chown -R flume.flume /data1/flume && \
    useradd -d /var/lib/hadoop -g hadoop hadoop && \
    usermod -G hadoop,hdfs yarn

RUN su - hdfs -c "ssh-keygen -q -t dsa -f /var/lib/hadoop-hdfs/.ssh/id_dsa -N '' 2>/dev/null && cat /var/lib/hadoop-hdfs/.ssh/id_dsa.pub >> /var/lib/hadoop-hdfs/.ssh/authorized_keys"; \
    su - mapred -c "ssh-keygen -q -t dsa -f /var/lib/hadoop-mapreduce/.ssh/id_dsa -N '' 2>/dev/null && cat /var/lib/hadoop-mapreduce/.ssh/id_dsa.pub >> /var/lib/hadoop-mapreduce/.ssh/authorized_keys"; \
    su - yarn -c "ssh-keygen -q -t dsa -f /var/lib/hadoop-yarn/.ssh/id_dsa -N '' 2>/dev/null && cat /var/lib/hadoop-yarn/.ssh/id_dsa.pub >> /var/lib/hadoop-yarn/.ssh/authorized_keys"

    
COPY hadoop /etc/hadoop/conf.templates/
COPY conf.zk/zookeeper-env.sh /etc/zookeeper/conf/
COPY conf.zk/zoo.cfg /etc/zookeeper/conf/
COPY conf.supervisor /etc/supervisor/conf.d/
COPY dnsmasq.conf /etc/
COPY run_namenode.sh /etc/supervisor/

EXPOSE 53 8020 8010 50010 50020 50070 42425 43130 19888 50095 50096 2181 9999 9998 9997 8025 8030 8042 8050 8141 10200 8088 8188

CMD ["/usr/bin/supervisord", "-n"]

