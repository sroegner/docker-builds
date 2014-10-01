FROM sroegner/doop

RUN rm -vf /etc/supervisor/conf.d/hdfs-namenode.conf; \
    rm -vf /etc/supervisor/conf.d/yarn-resourcemanager.conf; \
    rm -vf /etc/supervisor/conf.d/jobhistory.conf; \
    rm -vf /etc/supervisor/conf.d/zookeeper.conf; \
    rm -vrf /data1/hdfs/name* /data1/hdfs/data/*

COPY add_node.sh /etc/supervisor/add_node
COPY add_node.conf /etc/supervisor/conf.d/add_node.conf

EXPOSE 8010 50010 50020 19888 8025 8030 8042 8050 8141 10200 8188


CMD ["/usr/bin/supervisord", "-n"]

