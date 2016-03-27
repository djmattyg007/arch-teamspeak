FROM djmattyg007/arch-base:2016.03.27-2
MAINTAINER djmattyg007

# Add install bash script
COPY setup/root/*.sh /root/
COPY setup/init.sh /etc/service/teamspeak3-server/run

# Run bash script to install teamspeak server
#RUN chmod +x /root/*.sh /etc/service/teamspeak3-server/run && \
#    /bin/bash /root/install.sh && \
#    rm /root/*.sh
RUN /root/install.sh && \
    rm /root/*.sh

ENTRYPOINT ["/runsvinit"]
