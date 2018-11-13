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

FROM ubuntu:latest

MAINTAINER Christopher Scheidel <christopher.scheidel@gmail.com>

# Install dependencies
RUN apt-get update && \
	apt-get -y install wget && \
	rm -rf /var/lib/apt/lists/*

# Make the directory we will need
RUN	mkdir -p /data /minecraft
WORKDIR /minecraft

# Grab the pre-built PHP 7.2 distribution from PMMP
RUN wget -q -O - https://jenkins.pmmp.io/job/PHP-7.2-Aggregate/lastSuccessfulBuild/artifact/PHP-7.2-Linux-x86_64.tar.gz > /minecraft/PHP-7.2-Linux-x86_64.tar.gz && \
  cd /minecraft && \
	tar -xvf PHP-7.2-Linux-x86_64.tar.gz && \
	rm PHP-7.2-Linux-x86_64.tar.gz

# Grab the Specific version PHAR
RUN wget -q -O - https://github.com/pmmp/PocketMine-MP/releases/download/3.2.7/PocketMine-MP.phar > /minecraft/PocketMine-MP.phar

# Grab the start script and make it executable
RUN wget -q -O - https://raw.githubusercontent.com/pmmp/PocketMine-MP/master/start.sh > /minecraft/start.sh && \
  chmod +x /minecraft/start.sh

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
