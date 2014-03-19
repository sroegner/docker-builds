FROM sroegner/doop

RUN cd /usr/lib && curl -L http://apache.osuosl.org/accumulo/1.5.1/accumulo-1.5.1-bin.tar.gz | tar xz
RUN ln -s /usr/lib/accumulo-1.5.1 /usr/lib/accumulo; \
    mkdir -p /etc/accumulo/conf /var/lib/accumulo /var/log/accumulo; \
    rm -rf /usr/lib/accumulo/conf; rm -rf /usr/lib/accumulo/logs; \
    ln -s /etc/accumulo/conf /usr/lib/accumulo/conf; \
    ln -s /var/log/accumulo /usr/lib/accumulo/logs; 
    
ADD . /acc_docker
RUN cp -vr /acc_docker/accumulo.conf/* /etc/accumulo/conf/
RUN mkdir -p /root/.ssh ; \
    chmod 700 /root/.ssh ; \
    cp -vr /acc_docker/dotssh/* /root/.ssh/

EXPOSE 22
EXPOSE 2181
EXPOSE 50070
EXPOSE 50095

CMD ["/usr/bin/supervisord", "-n"]
