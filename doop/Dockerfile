FROM centos

RUN yum clean all && rpm -Uvh http://dl.fedoraproject.org/pub/epel/6/i386/epel-release-6-8.noarch.rpm
RUN yum -y install openssl snappy snappy-devel lzo lzo-devel sudo telnet curl python-pip openssh-server rsync passwd which

RUN cd /usr/lib && curl -L http://public-repo-1.hortonworks.com/HDP/centos5/2.x/updates/2.0.6.1/tars/hadoop-2.2.0.2.0.6.0-102.tar.gz | tar xz
RUN cd /usr/lib && curl -L http://apache.osuosl.org/zookeeper/zookeeper-3.4.5/zookeeper-3.4.5.tar.gz | tar xz

RUN ln -s /usr/lib/hadoop-2.2.0.2.0.6.0-102 /usr/lib/hadoop; \
    mkdir -p /etc/hadoop/conf /var/lib/hadoop /var/log/hadoop /var/run/hadoop; \
    rm -rf /usr/lib/hadoop/conf; rm -rf /usr/lib/hadoop/logs; \
    ln -s /etc/hadoop/conf /usr/lib/hadoop/conf; \
    ln -s /var/log/hadoop /usr/lib/hadoop/logs; \
    ln -s /usr/lib/zookeeper-3.4.5 /usr/lib/zookeeper; \
    mkdir -p /etc/zookeeper/conf /var/run/zookeeper /var/lib/zookeeper /var/log/zookeeper; \
    rm -rf /usr/lib/zookeeper/conf; rm -rf /usr/lib/zookeeper/logs; \
    ln -s /etc/zookeeper/conf /usr/lib/zookeeper/conf; \
    ln -s /var/log/zookeeper /usr/lib/zookeeper/logs; 

RUN pip install supervisor

RUN curl -L -b gpw_e24=http%3A%2F%2Fwww.oracle.com -b oraclelicense=accept-securebackup-cookie http://download.oracle.com/otn-pub/java/jdk/7u51-b13/jdk-7u51-linux-x64.tar.gz > /tmp/jdk.tgz && tar xzf /tmp/jdk.tgz -C /usr/lib && rm -f /tmp/jdk.tgz

RUN ln -s $(ls -1d /usr/lib/jdk1.7*|head -1) /usr/lib/java && echo "export JAVA_HOME=/usr/lib/java" > /etc/profile.d/java.sh

RUN ln -sf /usr/lib64/libsnappy.so /usr/lib/hadoop/lib/native/.

ADD . /docker
RUN cp -r /docker/hadoop/conf.doop/* /etc/hadoop/conf
RUN cp -r /docker/zoo.cfg /etc/zookeeper/conf
RUN cp -r /docker/zookeeper-env.sh /etc/zookeeper/conf

RUN mkdir -p /var/run/sshd && chmod 700 /var/run/sshd && echo hadoop | passwd --stdin root
RUN service sshd start

RUN mkdir -p /etc/supervisor/conf.d /data1/hdfs /data1/mapred /data1/yarn && \
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
    chown yarn.hadoop /data1/yarn 

RUN cp /docker/etc/supervisord-hdfs.conf /etc/supervisor/conf.d/hdfs.conf && \
    cp /docker/etc/supervisord-zookeeper.conf /etc/supervisor/conf.d/zookeeper.conf && \
    cp /docker/etc/supervisord-sshd.conf /etc/supervisor/conf.d/sshd.conf && \
    cp /docker/etc/supervisord.conf /etc/

EXPOSE 22
EXPOSE 2181
EXPOSE 50070

CMD ["/usr/bin/supervisord", "-n"]
