FROM sroegner/docker-centos-salt

ADD saltfiles/salt /etc/salt
ADD saltfiles/srv /srv

RUN mkdir -p /var/cache/salt
# the sleeps are supposed to help salt-master to materialize 
# the gitfs remotes in the master file and receive the key
# request from the local minion process
RUN /usr/bin/salt-master -d && \
    /usr/bin/salt-minion -d && \
    sleep 10; \
    /usr/bin/salt-key -A -y; \
    sleep 20; \
    /usr/bin/salt \* state.highstate

EXPOSE 2181
USER zookeeper
CMD ["/usr/lib/zookeeper/bin/zkServer.sh", "start-foreground"]
