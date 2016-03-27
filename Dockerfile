FROM djmattyg007/arch-base:2016.03.27-1
MAINTAINER djmattyg007

# Add install bash script
ADD setup/root/*.sh /root/

# Run bash script to install teamspeak server
RUN chmod +x /root/*.sh && \
    /bin/bash /root/install.sh && \
    rm /root/*.sh

RUN mkdir /etc/service/teamspeak3-server
ADD setup/init.sh /etc/service/teamspeak3-server/run

# add teamspeak script for application (custom script required to cd to sql lib)
#ADD setup/nobody/*.sh /home/nobody/

ENTRYPOINT ["/runsvinit"]
