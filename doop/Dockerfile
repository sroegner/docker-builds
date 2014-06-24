FROM sroegner/centos-base-ssh

RUN cd /usr/lib && \
    curl -L http://public-repo-1.hortonworks.com/HDP/centos6/2.x/updates/2.1.2.1/tars/hadoop-2.4.0.2.1.2.1-471.tar.gz | tar xz; \
    curl -L http://apache.osuosl.org/zookeeper/zookeeper-3.4.5/zookeeper-3.4.5.tar.gz | tar xz; \
    ln -s /usr/lib/hadoop-2.4.0.2.1.2.1-471 /usr/lib/hadoop; \
    chown -R root.root /usr/lib/hadoop-2.4.0.2.1.2.1-471; \
    mkdir -p /etc/hadoop/conf /var/lib/hadoop /var/log/hadoop /var/run/hadoop; \
    rm -rf /usr/lib/hadoop/conf; rm -rf /usr/lib/hadoop/logs; \
    ln -s /etc/hadoop/conf /usr/lib/hadoop/conf; \
    ln -s /var/log/hadoop /usr/lib/hadoop/logs; \
    chown -R root.root /usr/lib/zookeeper-3.4.5; \
    ln -s /usr/lib/zookeeper-3.4.5 /usr/lib/zookeeper; \
    mkdir -p /etc/zookeeper/conf /var/run/zookeeper /var/lib/zookeeper /var/log/zookeeper; \
    rm -rf /usr/lib/zookeeper/conf; rm -rf /usr/lib/zookeeper/logs; \
    ln -s /etc/zookeeper/conf /usr/lib/zookeeper/conf; \
    ln -s /var/log/zookeeper /usr/lib/zookeeper/logs; \
    ln -sf /usr/lib64/libsnappy.so /usr/lib/hadoop/lib/native/.

ADD . /docker
RUN cp -r /docker/hadoop/conf.doop/* /etc/hadoop/conf && \
    cp -r /docker/zoo.cfg /etc/zookeeper/conf && \
    cp -r /docker/zookeeper-env.sh /etc/zookeeper/conf && \
    echo hadoop | passwd --stdin root && \
    service sshd start; \
    mkdir -p /data1/hdfs /data1/mapred /data1/yarn && \
    groupadd -g 6000 hadoop && \
    useradd -u 6001 -G 6000 hdfs && \
    useradd -u 6002 -G 6000 mapred && \
    useradd -u 6003 -G 6000 yarn && \
    useradd -u 6030 -G 6000 zookeeper && \
    chmod 775 /var/log/hadoop /var/lib/hadoop /var/run/hadoop && \
    chgrp hadoop /var/log/hadoop /var/lib/hadoop /var/run/hadoop && \
    chown zookeeper.zookeeper /var/run/zookeeper /var/log/zookeeper /var/lib/zookeeper && \
    chown hdfs.hadoop /data1/hdfs && \
    chown mapred.hadoop /data1/mapred && \
    chown yarn.hadoop /data1/yarn && \
    cp /docker/etc/supervisord-hdfs.conf /etc/supervisor/conf.d/hdfs.conf && \
    cp /docker/etc/supervisord-zookeeper.conf /etc/supervisor/conf.d/zookeeper.conf 

EXPOSE 22 2181 8020 50070

CMD ["/usr/bin/supervisord", "-n"]
