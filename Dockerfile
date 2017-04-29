# ########################################################################################
# POCKETMINE-MP Docker Image
#
# This is a stand-alone image that utilizes the latest version of the Pocketmine-MP PHP
# based server
#
# docker run --name minecraft -p 19132:19132/udp -d php:7-cli /bin/sh -c "while true; do sleep 60; done"
#

FROM php:7-cli

MAINTAINER Christopher Scheidel <christopher.scheidel@gmail.com>

RUN apt-get update && \
	apt-get install wget && \
	useradd minecraft \
	mkdir -p /minecraft \
	chown minecraft /minecraft \

# Work
WORKDIR /minecraft

# Run the install
RUN su minecraft && \
	wget -q -O - https://get.pmmp.io | bash -s -

ADD server.properties /minecraft/
ADD pocketmine.yml /minecraft/

# Expose the right port
EXPOSE 19132/udp

# Run the app when launched
CMD [ "bash", "/minecraft/start.sh", "--no-wizard"]