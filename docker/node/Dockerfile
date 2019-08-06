FROM ubuntu:18.04

ENV DEBIAN_FRONTEND noninteractive

RUN sed -i 's/archive.ubuntu.com/mirrors.tuna.tsinghua.edu.cn/g' /etc/apt/sources.list
RUN rm -rf /etc/apt/apt.conf.d/docker-clean && apt-get update
# Install Jepsen dependencies
RUN apt-get install -y openssh-server sudo \
    curl faketime iproute2 iptables iputils-ping libzip4 \
    logrotate man man-db net-tools ntpdate psmisc python rsyslog \
    sudo unzip vim wget apt-transport-https \
    && apt-get remove -y --purge --auto-remove systemd

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN mkdir /var/run/sshd
RUN echo 'root:root' |chpasswd
RUN sed -ri 's/^#?PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -ri 's/^#?UsePAM\s+.*/UsePAM no/' /etc/ssh/sshd_config

RUN mkdir -p /root/.ssh && chmod 700 /root/.ssh
Add authorized_keys /root/.ssh/authorized_keys
RUN chmod 600 /root/.ssh/authorized_keys

ADD run.sh /run.sh
RUN chmod +x /*.sh

EXPOSE 22

CMD ["/run.sh"]
