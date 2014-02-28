FROM centos

RUN yum -y install http://dl.fedoraproject.org/pub/epel/6/i386/epel-release-6-8.noarch.rpm
RUN wget -nv http://public-repo-1.hortonworks.com/HDP/centos6/2.x/updates/2.0.6.1/hdp.repo -O /etc/yum.repos.d/hdp.repo 

RUN yum -y install hadoop hadoop-hdfs hadoop-libhdfs hadoop-yarn hadoop-mapreduce hadoop-client openssl snappy snappy-devel lzo lzo-devel hadoop-lzo hadoop-lzo-native sudo telnet curl python-pip
RUN pip install supervisor

RUN curl -L -b gpw_e24=http%3A%2F%2Fwww.oracle.com http://download.oracle.com/otn-pub/java/jdk/7u45-b18/jdk-7u45-linux-x64.tar.gz > /tmp/jdk.tgz && tar xzf /tmp/jdk.tgz -C /usr/lib && rm -f /tmp/jdk.tgz

RUN ln -s $(ls -1d /usr/lib/jdk1.7*|head -1) /usr/lib/java && echo "export JAVA_HOME=/usr/lib/java" > /etc/profile.d/java.sh

RUN ln -sf /usr/lib64/libsnappy.so /usr/lib/hadoop/lib/native/.

ADD . /docker
RUN cp -r /docker/hadoop/conf.doop /etc/hadoop && \
    cp /etc/hadoop/conf/hadoop-env.sh /etc/hadoop/conf.doop && \
    rm -f /etc/hadoop/conf && \
    ln -sf /etc/hadoop/conf.doop /etc/hadoop/conf

RUN mkdir -p /data1/hdfs /data1/mapred /data1/yarn && \
    chown hdfs.hadoop /data1/hdfs && \
    chown mapred.hadoop /data1/mapred && \
    chown yarn.hadoop /data1/yarn 

RUN ln -sf /docker/supervisord.conf /etc/supervisord.conf

EXPOSE 8020
EXPOSE 50070

