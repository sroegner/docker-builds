FROM sroegner/centos-base-ssh:7
MAINTAINER Steffen Roegner "steffen.roegner@gmail.com"
USER root

ENV HADOOP_HOME=/usr/lib/hadoop
ENV HADOOP_HDFS_HOME=/usr/lib/hadoop-hdfs
ENV HADOOP_MAPRED_HOME=/usr/lib/hadoop-mapreduce
ENV HADOOP_YARN_HOME=/usr/lib/hadoop-yarn
ENV HADOOP_LIBEXEC_DIR=/usr/lib/hadoop/libexec

RUN curl -L http://public-repo-1.hortonworks.com/HDP/centos6/2.x/GA/2.1-latest/hdp.repo -o /etc/yum.repos.d/hdp.repo; \
    yum -y install hadoop hadoop-hdfs hadoop-libhdfs hadoop-yarn hadoop-mapreduce hadoop-client flume zookeeper dnsmasq
    
RUN mkdir -p /data1/hdfs /data1/mapred /data1/yarn /data1/flume/spool-dir /var/log/hadoop; \
    chown hdfs.hadoop /data1/hdfs && \
    chown mapred.hadoop /data1/mapred && \
    chown yarn.hadoop /data1/yarn

RUN ssh-keygen -q -t dsa -b 1024 -N '' -f /root/.ssh/id_dsa 2>/dev/null; \
    cat /root/.ssh/id_dsa.pub > /root/.ssh/authorized_keys; \
    chmod 600 /root/.ssh/authorized_keys

RUN su - hdfs -c "ssh-keygen -q -t dsa -f /var/lib/hadoop-hdfs/.ssh/id_dsa -N '' 2>/dev/null && cat /var/lib/hadoop-hdfs/.ssh/id_dsa.pub >> /var/lib/hadoop-hdfs/.ssh/authorized_keys"; \
    su - mapred -c "ssh-keygen -q -t dsa -f /var/lib/hadoop-mapreduce/.ssh/id_dsa -N '' 2>/dev/null && cat /var/lib/hadoop-mapreduce/.ssh/id_dsa.pub >> /var/lib/hadoop-mapreduce/.ssh/authorized_keys"; \
    su - yarn -c "ssh-keygen -q -t dsa -f /var/lib/hadoop-yarn/.ssh/id_dsa -N '' 2>/dev/null && cat /var/lib/hadoop-yarn/.ssh/id_dsa.pub >> /var/lib/hadoop-yarn/.ssh/authorized_keys"

    
COPY hadoop /etc/hadoop/conf.templates/
COPY conf.zk/zookeeper-env.sh /etc/zookeeper/conf/
COPY conf.zk/zoo.cfg /etc/zookeeper/conf/
COPY hadoop-group.conf /etc/supervisor/conf.d/
COPY bootstrap-node.conf /etc/supervisor/conf.d/
COPY dnsmasq.conf /etc/
COPY run_namenode.sh /etc/supervisor/
COPY bootstrap-node.sh /usr/local/sbin/
# EXPOSE 53 8010 8020 50010 50020 50070 50075 43130 2181 8025 8030 8042 8050 8141 8088 8188 10200 19888 

CMD ["/usr/bin/supervisord", "-n"]

