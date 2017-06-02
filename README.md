# PocketMine-MP Docker Container

# [![PocketMine-MP](http://cdn.pocketmine.net/img/PocketMine-MP-h.png)](https://pmmp.io)

This is a dockerized version of the [PocketMine-MP server](https://www.pmmp.io/) written in PHP, a highly customisable, open source server software for Minecraft: Pocket Edition written in PHP. More documentation regarding the server itself can be found at their website directly.

## How to use PocketMine-MP

To learn how to use PocketMine-MP, please visit their [documentation site](http://pmmp.readthedocs.org/). This image definition is not meant to replace the great documentation that the PocketMine team has already completed.

## How to use this Docker image

### Starting with default data

To start with no mapped data, simple utilize the docker run command below. This will launch a new container with the default data present.

`docker run -d -p 19132:19132/udp --name minecraft cscheide/minecraft-pe:latest`

### Starting while persisting data

To persist data, ensure your configuration and data files are present in a volume and map a volume to `/data`.

`docker run -d -v /your/directory/with/data:/data -p 19132:19132/udp --name minecraft cscheide/minecraft-pe:latest`

See the data management section below for more detail.

## Data Management

Since PocketMine-MP relies on some static data to configure and store information about the world, this image assumes the presence of a data volume located at `/data`. The following files will be referenced from `/data`:

* `banned-ips.txt`
* `banned-players.txt`
* `ops.txt`
* `players` directory
* `worlds` directory
* `pocketmine.yml`
* `server.properties`
* `white-list.txt`

To persist your data, simply map a volume to `/data` when you launch the container.

## How to Update To Latest Version

This image is updated when I perform the build to DockerHub. At present the current version supported is:

To update to the latest version yourself you can either follow the [Manual Update Instructions](https://pmmp.readthedocs.io/en/rtfd/update.html#) or you can simple download a copy of the [PocketMine-MP Docker Container](https://github.com/crscheid/pocketmine-mp) from GitHub and build the image yourself. This process will automatically grab the latest version.

`docker build --no-cache -t your-image-name pocketmine-mp/.`

Then run the above commands utilizing your own image.

`docker run -d -p 19132:19132/udp --name minecraft your-image-name`
