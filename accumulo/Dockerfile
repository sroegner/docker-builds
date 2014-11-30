FROM sroegner/doop
MAINTAINER Steffen Roegner "steffen.roegner@gmail.com"
USER root

ENV REFRESHED_AT 2014-11-13
RUN yum -y -q upgrade
RUN yum -y install gcc-c++
ENV ACCUMULO_VERSION 1.6.1

RUN curl -L http://apache.osuosl.org/accumulo/${ACCUMULO_VERSION}/accumulo-${ACCUMULO_VERSION}-bin.tar.gz | tar xz --no-same-owner -C /usr/lib 

RUN ln -s /usr/lib/accumulo-${ACCUMULO_VERSION} /usr/lib/accumulo; \
    useradd -u 6040 -G hadoop -d /var/lib/accumulo accumulo; \
    mkdir -p /etc/accumulo /var/run/accumulo /var/lib/accumulo/conf /var/log/accumulo; \
    cp -vr /root/.ssh/ /var/lib/accumulo/; chown -R accumulo.accumulo /var/lib/accumulo/.ssh; \
    chown accumulo.accumulo /var/run/accumulo /var/lib/accumulo /var/log/accumulo; \
    chmod 700 /var/lib/accumulo/conf; \
    mv /usr/lib/accumulo/conf /usr/lib/accumulo/conf.dist; \
    rm -rf /usr/lib/accumulo/logs; \
    ln -s /var/lib/accumulo/conf /usr/lib/accumulo/conf; \
    ln -s /var/lib/accumulo/conf /etc/accumulo/conf; \
    ln -s /var/log/accumulo /usr/lib/accumulo/logs; \
    JAVA_HOME=/usr/lib/jvm/java /usr/lib/accumulo/bin/build_native_library.sh
    
COPY accumulo_profile.sh /etc/profile.d/accumulo_profile.sh
COPY accumulo.conf.templates /var/lib/accumulo/conf.templates/
COPY supervisord-accumulo.conf /var/lib/accumulo/
COPY supervisord-accumulo-tserver.conf /var/lib/accumulo/
COPY init_accumulo.sh /var/lib/accumulo/

EXPOSE 22 50095 9999 9998 9997 42424
CMD ["/usr/bin/supervisord", "-n"]
