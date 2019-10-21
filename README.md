# Supported tags and respective `Dockerfile` links

* `3.6.1`, `3.6`, [(3.6/Dockerfile)](https://github.com/crscheid/pocketmine-mp/blob/master/3.6/Dockerfile)
* `3.8.2`, `3.8`, [(3.8/Dockerfile)](https://github.com/crscheid/pocketmine-mp/blob/master/3.8/Dockerfile)
* `3.9.5`, `3.9`, `latest` [(3.9/Dockerfile)](https://github.com/crscheid/pocketmine-mp/blob/master/3.9/Dockerfile)

# [![PocketMine-MP](http://cdn.pocketmine.net/img/PocketMine-MP-h.png)](https://pmmp.io)


This is a Docker image of the [PocketMine-MP server](https://www.pmmp.io/) written in PHP, a highly customizable, open source server software for Minecraft: Pocket Edition written in PHP. More documentation regarding the server itself can be found at the [PMMP website](https://www.pmmp.io/) directly.

## Versions

The latest version is PocketMine-MP 3.9.5 [Github Release](https://github.com/pmmp/PocketMine-MP/releases/tag/3.9.5). Versions are also maintained for 3.8.x and 3.6.x branches. Versions of this Docker image are tracked against PocketMine-MP's versioning scheme. Since this is not an official PocketMine-MP project, there may be a lag between new version releases of PocketMine-MP and this image.

The `latest` image will always track the most recent release.

## Contributing

If you wish to contribute to this Docker image definition, please submit an issue and a pull request here or follow the discussion on the open issue on PocketMine-MP:  [Create Docker container for easier distribution](https://github.com/pmmp/PocketMine-MP/issues/928)

## How to use PocketMine-MP

To learn how to use PocketMine-MP, please visit their [documentation site](http://pmmp.readthedocs.org/). This image definition is not meant to replace the great documentation that the PocketMine team has already provided.

## How to use this Docker image

### Starting with default data

To start with no mapped data, simple utilize the docker run command below. This will launch a new container with the default data present.

`docker run -d -p 19132:19132/udp --name minecraft cscheide/pocketmine-mp:latest`

### Starting with existing data

To persist data, ensure your configuration and data files are present in a volume and map a volume to `/data`.

`docker run -d -v /your/directory/with/data:/data -p 19132:19132/udp --name minecraft cscheide/pocketmine-mp:latest`

See the data management section below for more detail.

### Starting in a terminal that you can reattach to

To start the server with a TTY that you can reconnect to later

`docker run -ti -p 19132:19132/udp --name minecraft cscheide/pocketmine-mp:latest`

When you are done with your session, type `Ctrl-P` followed by `Ctrl-Q`. To reattach to the session use

`docker attach minecraft`

## Data Management

Since PocketMine-MP relies on some static data to configure and store information about the world, this image assumes the presence of a data volume located at `/data` which expects the following:

* `banned-ips.txt`
* `banned-players.txt`
* `ops.txt`
* `players` directory
* `plugins` directory
* `pocketmine.yml`
* `resource_packs` directory
* `server.properties`
* `server.log`
* `white-list.txt`
* `worlds` directory

If you are starting a new world, you can simply start the server with the instructions above under "Starting with default data". If you are using an existing world, you must map that data into the container using Dockers volume mapping as illustrated above in "Starting with existing data".

If you would to copy the default data into a local folder than you can then use in the future, perform the following while your server is running. This assumes your container is called `minecraft` and the local directory you wish to store your data in is at `/directory/to/store/data`. You may wish to alter these values as appropriate.

```
docker cp minecraft:/data /directory/to/store/data
docker stop minecraft
`docker run -d -v /directory/to/store/data:/data -p 19132:19132/udp --name new_minecraft cscheide/pocketmine-mp:latest`
```

The above commands will copy the default data out of the container named "minecraft" into a directory. It will then stop the old minecraft container and start a "new_minecraft" container that utilizes your local data instead.

**Important Note**: Periodically, PocketMine-MP will release new features that require/expect new data items. If you are using your own data folder, these may not be present and may cause errors. If you suspect this to be the case you can always create a fresh container and compare your files to the default files in the /data folder.

## How to Update To Latest Version

This image is automatically updated when there are pushes to the `master` branch or when there are versions tagged from the [source repository](https://github.com/crscheid/pocketmine-mp).

First, pull the latest image down with Docker.

```
docker pull cscheide/pocketmine-mp:latest
```

The stop your existing container and recreate a new container.

```
docker stop minecraft
docker run -d -v /directory/to/store/data:/data -p 19132:19132/udp --name new_minecraft cscheide/pocketmine-mp:latest
```

You may also choose to remove your old container if you have all of your data preserved.

```
docker rm -v minecraft
```

**Important Note**: If you are not mapping data, please be careful as your configuration, worlds, and plugins may be removed when you remove the container.
