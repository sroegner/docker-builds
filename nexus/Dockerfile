FROM sroegner/centos-base-ssh

RUN mkdir /tmp/nexus && \
    cd /tmp/nexus && \
    curl -L http://www.sonatype.org/downloads/nexus-latest-bundle.tar.gz | tar xz

RUN useradd -m -d /srv/nexus nexus

RUN mv -v $(ls -1d /tmp/nexus/nex*|head -1) /srv/nexus/ && \
    ln -s $(ls -1d /srv/nexus/nexus-*|head -1) /srv/nexus/nexus-server && \
    mv -v /tmp/nexus/sonatype-work /srv/nexus && \
    chown -R nexus:nexus /srv/nexus/*
    
ADD . /docker
RUN cp /docker/supervisord-nexus.conf /etc/supervisor/conf.d/nexus.conf; \
    cp /docker/nexus.properties /srv/nexus/nexus-server/conf/nexus.properties

EXPOSE 22 8081

CMD ["/usr/bin/supervisord", "-n"]
