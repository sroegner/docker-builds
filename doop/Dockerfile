FROM centos

RUN yum clean all && rpm -Uvh http://dl.fedoraproject.org/pub/epel/6/i386/epel-release-6-8.noarch.rpm
RUN wget -nv http://public-repo-1.hortonworks.com/HDP/centos6/2.x/updates/2.0.6.1/hdp.repo -O /etc/yum.repos.d/hdp.repo 

RUN yum -y install hadoop hadoop-hdfs hadoop-libhdfs hadoop-yarn hadoop-mapreduce hadoop-client openssl snappy snappy-devel lzo lzo-devel hadoop-lzo hadoop-lzo-native sudo telnet curl python-pip openssh-server
RUN pip install supervisor

RUN curl -L -b gpw_e24=http%3A%2F%2Fwww.oracle.com -b oraclelicense=accept-securebackup-cookie http://download.oracle.com/otn-pub/java/jdk/7u51-b13/jdk-7u51-linux-x64.tar.gz > /tmp/jdk.tgz && tar xzf /tmp/jdk.tgz -C /usr/lib && rm -f /tmp/jdk.tgz

RUN ln -s $(ls -1d /usr/lib/jdk1.7*|head -1) /usr/lib/java && echo "export JAVA_HOME=/usr/lib/java" > /etc/profile.d/java.sh

RUN ln -sf /usr/lib64/libsnappy.so /usr/lib/hadoop/lib/native/.

ADD . /docker
RUN cp -r /docker/hadoop/conf.doop /etc/hadoop && \
    cp /etc/hadoop/conf/hadoop-env.sh /etc/hadoop/conf.doop && \
    rm -f /etc/hadoop/conf && \
    ln -sf /etc/hadoop/conf.doop /etc/hadoop/conf

RUN mkdir -p /var/run/sshd /var/cache/salt && chmod 700 /var/run/sshd && echo hadoop | passwd --stdin root
RUN service sshd start

RUN mkdir -p /etc/supervisor/conf.d /data1/hdfs /data1/mapred /data1/yarn && \
    chown hdfs.hadoop /data1/hdfs && \
    chown mapred.hadoop /data1/mapred && \
    chown yarn.hadoop /data1/yarn 

RUN cp /docker/etc/supervisord-hdfs.conf /etc/supervisor/conf.d/hdfs.conf && \
    cp /docker/etc/supervisord-zookeeper.conf /etc/supervisor/conf.d/zookeeper.conf && \
    cp /docker/etc/supervisord-sshd.conf /etc/supervisor/conf.d/sshd.conf && \
    cp /docker/etc/supervisord.conf /etc/

EXPOSE 22
EXPOSE 2181
EXPOSE 50070

CMD ["/usr/bin/supervisord", "-n"]
