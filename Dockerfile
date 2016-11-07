FROM djmattyg007/arch-runit-base:2016.11.07-1
MAINTAINER djmattyg007

ENV TS3IMAGE_VERSION=2016.11.07-1

# Add install bash script
COPY setup/root/*.sh /root/
COPY setup/init.sh /etc/service/teamspeak3-server/run

# Run bash script to install teamspeak server
RUN /root/install.sh && \
    rm /root/*.sh

ENTRYPOINT ["/usr/bin/init"]
