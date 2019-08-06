FROM ubuntu:18.04

ENV LEIN_ROOT true

# Jepsen dependencies
RUN sed -i 's/archive.ubuntu.com/mirrors.tuna.tsinghua.edu.cn/g' /etc/apt/sources.list
RUN apt-get -y -q update && \
    apt-get -y -q install software-properties-common && \
    add-apt-repository ppa:openjdk-r/ppa && \
    apt-get -y -q update && \
            apt-get install -qqy dos2unix openjdk-8-jdk libjna-java git gnuplot \
            wget iputils-ping zip unzip

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN wget https://raw.githubusercontent.com/technomancy/leiningen/stable/bin/lein && \
    mv lein /usr/bin && \
    chmod +x /usr/bin/lein && \
    lein self-install

# without --dev flag up.sh copies jepsen to these subfolders
# with --dev flag they are empty until mounted
COPY jepsen/jepsen /jepsen/jepsen/
RUN if [ -f /jepsen/jepsen/project.clj ]; then cd /jepsen/jepsen && lein install; fi
COPY jepsen /jepsen/

RUN mkdir -p /root/.ssh && chmod 700 /root/.ssh && echo > /root/.ssh/known_hosts && \
    echo 'StrictHostKeyChecking no' > ~/.ssh/config
ADD id_rsa /root/.ssh/id_rsa
ADD id_rsa.pub /root/.ssh/id_rsa.pub
RUN chmod 600 /root/.ssh/id_rsa && chmod 644 /root/.ssh/id_rsa.pub

ADD ./bashrc /root/.bashrc
ADD ./init.sh /init.sh
RUN dos2unix /init.sh /root/.bashrc && chmod +x /init.sh

CMD /init.sh
