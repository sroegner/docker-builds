# centos-base
# adding some essential packages and a jdk
# ready openssh server

FROM centos

RUN yum -y update && \
    rpm -Uvh http://dl.fedoraproject.org/pub/epel/6/i386/epel-release-6-8.noarch.rpm && \
    yum -y install openssl snappy snappy-devel lzo lzo-devel sudo telnet curl python-pip openssh-server rsync passwd which && \
    yum clean all && \
    pip install supervisor && \
    cd /usr/lib && curl -L -b gpw_e24=http%3A%2F%2Fwww.oracle.com -b oraclelicense=accept-securebackup-cookie http://download.oracle.com/otn-pub/java/jdk/7u51-b13/jdk-7u51-linux-x64.tar.gz | tar xz && \
    ln -s $(ls -1d /usr/lib/jdk1.7*|head -1) /usr/lib/java && \
    echo 'export JAVA_HOME=/usr/lib/java' > /etc/profile.d/java.sh && \
    echo 'export PATH=$JAVA_HOME/bin:$PATH' >> /etc/profile.d/java.sh

ADD . /docker
RUN mkdir -p /root/.ssh; \
    chmod 700 /root/.ssh; \
    cp -v /docker/srkey.pub /root/.ssh/authorized_keys; \
    chmod 600 /root/.ssh/authorized_keys && \
    mkdir -p /var/run/sshd && \
    chmod 700 /var/run/sshd && \
    echo changeme | passwd --stdin root && \
    /etc/init.d/sshd start && \
    mkdir -p /etc/supervisor/conf.d /var/log/supervisor && \
    cp /docker/supervisord-sshd.conf /etc/supervisor/conf.d/sshd.conf && \
    cp /docker/supervisord.conf /etc/

EXPOSE 22

CMD ["/usr/bin/supervisord", "-n"]
