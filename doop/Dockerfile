FROM sroegner/centos-base-ssh

RUN curl -L http://public-repo-1.hortonworks.com/HDP/centos6/2.x/GA/2.1-latest/hdp.repo -o /etc/yum.repos.d/hdp.repo; \
    yum -y install hadoop hadoop-hdfs hadoop-libhdfs hadoop-yarn hadoop-mapreduce hadoop-client flume zookeeper; \
    mkdir -p /data1/hdfs /data1/mapred /data1/yarn /data1/flume/spool-dir; \
    rm -vf /etc/security/limits.d/hdfs.conf /etc/security/limits.d/mapreduce.conf /etc/security/limits.d/yarn.conf; \
    chown hdfs.hadoop /data1/hdfs && \
    chown mapred.hadoop /data1/mapred && \
    chown yarn.hadoop /data1/yarn && \
    chown -R flume.flume /data1/flume && \
    useradd -d /var/lib/hadoop -g hadoop hadoop && \
    cp -r /root/.ssh /var/lib/hadoop-hdfs && chown -R hdfs.hdfs /var/lib/hadoop-hdfs/.ssh && \
    cp -r /root/.ssh /var/lib/hadoop-mapreduce && chown -R mapred.mapred /var/lib/hadoop-mapreduce/.ssh && \
    cp -r /root/.ssh /var/lib/hadoop-yarn && chown -R yarn.yarn /var/lib/hadoop-yarn/.ssh 

ADD . /docker
RUN cp -r /docker/hadoop.conf/* /etc/hadoop/conf/ && \
    echo hadoop | passwd --stdin root && \
    service sshd start; \
    mkdir -p /data1/hdfs /data1/mapred /data1/yarn && \
    chown hdfs.hadoop /data1/hdfs && \
    chown mapred.hadoop /data1/mapred && \
    chown yarn.hadoop /data1/yarn && \
    cp /docker/etc/supervisord-hdfs.conf /etc/supervisor/conf.d/hdfs.conf && \
    cp /docker/etc/supervisord-yarn.conf /etc/supervisor/conf.d/yarn.conf && \
    cp /docker/etc/supervisord-zookeeper.conf /etc/supervisor/conf.d/zookeeper.conf 

EXPOSE 22 2181 8020 50070

CMD ["/usr/bin/supervisord", "-n"]
