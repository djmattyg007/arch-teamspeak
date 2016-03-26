FROM djmattyg007/arch-base
MAINTAINER djmattyg007

# add install bash script
ADD setup/root/*.sh /root/

# add teamspeak script for application (custom script required to cd to sql lib)
ADD setup/nobody/*.sh /home/nobody/

# install app
#############

# make executable and run bash scripts to install app
RUN chmod +x /root/*.sh /home/nobody/*.sh && \
	/bin/bash /root/install.sh

ENTRYPOINT ["/runsvinit"]
