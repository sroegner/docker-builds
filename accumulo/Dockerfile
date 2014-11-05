FROM sroegner/doop

RUN curl -L http://apache.cs.utah.edu/accumulo/1.5.2/accumulo-1.5.2-bin.tar.gz -o /tmp/acc.tgz && \
    tar xzf /tmp/acc.tgz -C /usr/lib && rm -vf /tmp/acc.tgz && id 
RUN ln -s /usr/lib/accumulo-1.5.2 /usr/lib/accumulo; \
    mkdir -p /etc/accumulo/conf /var/run/accumulo /var/lib/accumulo /var/log/accumulo; \
    useradd -u 6040 -G hadoop accumulo; \
    chown accumulo.accumulo /var/run/accumulo /var/lib/accumulo /var/log/accumulo; \
    rm -rf /usr/lib/accumulo/conf; rm -rf /usr/lib/accumulo/logs; \
    ln -s /etc/accumulo/conf /usr/lib/accumulo/conf; \
    ln -s /var/log/accumulo /usr/lib/accumulo/logs; 
    
ADD . /docker
ADD accumulo_profile.sh /etc/profile.d/accumulo_profile.sh
RUN cp -vr /docker/accumulo.conf/* /etc/accumulo/conf/; \
    mkdir -p /root/.ssh /home/accumulo/.ssh; \
    chmod 700 /root/.ssh /home/accumulo/.ssh; \
    cp -vr /docker/dotssh/* /root/.ssh/; \
    cp -vr /docker/dotssh/* /home/accumulo/.ssh/ ;\
    chown -R accumulo.accumulo /home/accumulo/.ssh

EXPOSE 22 2181 50070 50095 
CMD ["/usr/bin/supervisord", "-n"]
