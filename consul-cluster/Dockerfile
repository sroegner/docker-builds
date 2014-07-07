# centos-base
# adding some essential packages and a jdk
# ready openssh server

FROM sroegner/centos-base-ssh

RUN mkdir -p /var/log/consul /etc/consul /var/lib/consul/data /var/lib/consul/ui /var/lib/consul/scripts && \
    curl -L https://dl.bintray.com/mitchellh/consul/0.3.0_linux_amd64.zip -o /tmp/c.zip && \
    curl -L https://dl.bintray.com/mitchellh/consul/0.3.0_web_ui.zip -o /tmp/ui.zip && \
    unzip /tmp/c.zip -d /usr/sbin && \
    unzip /tmp/ui.zip -d /var/lib/consul/ui

ADD . /docker
RUN cp -v /docker/consul.conf /etc/supervisor/conf.d/; \
    cp -v /docker/*.json /etc/consul; \
    cp -v /docker/checkscripts/* /var/lib/consul/scripts

EXPOSE 22 8400 8500 8600

CMD ["/usr/bin/supervisord", "-n"]
