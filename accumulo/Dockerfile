FROM sroegner/doop

RUN cd /usr/lib && curl -L http://apache.osuosl.org/accumulo/1.5.1/accumulo-1.5.1-bin.tar.gz | tar xz
RUN ln -s /usr/lib/accumulo-1.5.1 /usr/lib/accumulo; \
    mkdir -p /etc/accumulo/conf /var/run/accumulo /var/lib/accumulo /var/log/accumulo; \
    useradd -u 6040 -G hadoop accumulo; \
    chown accumulo.accumulo /var/run/accumulo /var/lib/accumulo /var/log/accumulo; \
    rm -rf /usr/lib/accumulo/conf; rm -rf /usr/lib/accumulo/logs; \
    ln -s /etc/accumulo/conf /usr/lib/accumulo/conf; \
    ln -s /var/log/accumulo /usr/lib/accumulo/logs; 
    
ADD . /docker
RUN cp -vr /docker/accumulo.conf/* /etc/accumulo/conf/; \
    mkdir -p /root/.ssh /home/accumulo/.ssh; \
    chmod 700 /root/.ssh /home/accumulo/.ssh; \
    cp -vr /docker/dotssh/* /root/.ssh/; \
    cp -vr /docker/dotssh/* /home/accumulo/.ssh/ ;\
    chown -R accumulo.accumulo /home/accumulo/.ssh

EXPOSE 22
EXPOSE 2181
EXPOSE 50070
EXPOSE 50095

CMD ["/usr/bin/supervisord", "-n"]
