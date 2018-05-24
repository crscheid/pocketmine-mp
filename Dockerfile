# ########################################################################################
# POCKETMINE-MP Docker Image
#
# This is a stand-alone image that utilizes the latest version of the Pocketmine-MP PHP
# based server (https://pmmp.io/)
#
# You can run using this:
#
# Start in headless mode
# 	docker run -d -v /data/minecraft/data:/data -p 19132:19132/udp --name minecraft cscheide/pocketmine-mp
#
# Start in interactive mode
# 	docker start -ai minecraft
#
# Start creating new data
# 	docker run -d -p 19132:19132/udp --name minecraft cscheide/pocketmine-mp
#

FROM php:7-cli

MAINTAINER Christopher Scheidel <christopher.scheidel@gmail.com>

RUN apt-get update && \
	apt-get -y install wget && \
	mkdir -p /data /minecraft

# Work
WORKDIR /minecraft

# Run the install
RUN wget -q -O - https://get.pmmp.io | bash -s - -r

# Add the custom properties from our docker project
ADD server.properties /data/server.properties
ADD pocketmine.yml /data/pocketmine.yml

# Touch the remaining files
RUN touch /data/banned-ips.txt && \
	touch /data/banned-players.txt && \
	touch /data/ops.txt && \
	mkdir -p /data/players && \
	touch /data/white-list.txt && \
	mkdir -p /data/worlds && \
	mkdir -p /data/plugins && \
	mkdir -p /data/resource_packs && \
	touch /data/server.log

# Move the configuration items out of the main directory and sym link items back
RUN ln -s /data/banned-ips.txt /minecraft/banned-ips.txt && \
	ln -s /data/banned-players.txt /minecraft/banned-players.txt && \
	ln -s /data/ops.txt /minecraft/ops.txt && \
	ln -s /data/players /minecraft/players && \
	ln -s /data/pocketmine.yml /minecraft/pocketmine.yml && \
	ln -s /data/server.properties /minecraft/server.properties && \
	ln -s /data/white-list.txt /minecraft/white-list.txt && \
	ln -s /data/worlds /minecraft/worlds && \
	ln -s /data/plugins /minecraft/plugins && \
	ln -s /data/resource_packs /minecraft/resource_packs && \
	ln -s /data/server.log /minecraft/server.log


# Expose the right port
EXPOSE 19132/udp

# Set up the volume for the data
VOLUME /data

# Run the app when launched
CMD [ "bash", "/minecraft/start.sh", "--no-wizard"]
