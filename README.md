Docker Toolbox
==================================

[![docker toolbox logo](https://cloud.githubusercontent.com/assets/251292/9585188/2f31d668-4fca-11e5-86c9-826d18cf45fd.png)](https://www.docker.com/toolbox)

The Docker Toolbox installs everything you need to get started with
Docker on Mac OS X and Windows, including:

|                        | Mac    | Windows     |
|------------------------|--------|-------------|
| Docker Client / Engine | Client | Client      |
| Docker Machine         | Yes    | Yes         |
| Docker Compose         | Yes    | Coming Soon |
| Docker Kitematic       | Yes    | Yes         |
| VirtualBox 5.0         | Yes    | Yes         |
| Delivery Format        | .pkg   | .exe        |


## Installation and documentation

Documentation for Mac [is available
here](https://docs.docker.com/mac/started/).

Documentation for Windows [is available here](https://docs.docker.com/windows/started/). *Note:* Some Windows computers may not have VT-X enabled by default. It is required for VirtualBox. To enable VT-X, please see the guide [here.](http://www.howtogeek.com/213795/how-to-enable-intel-vt-x-in-your-computers-bios-or-uefi-firmware).

Toolbox is currently unavailable for Linux; To get started with Docker on Linux, please follow the Linux [Getting Started Guide](https://docs.docker.com/linux/started/).

## Building the Docker Toolbox

Toolbox installers are built using Docker, so you'll need a Docker host set up. For example, using [Docker Machine](https://github.com/docker/machine):

```
$ docker-machine create -d virtualbox toolbox
$ eval "$(docker-machine env toolbox)"
```

Then, to build the Toolbox for both platforms:

```
make
```

Build for a specific platform:

```
make osx
```

or

```
make windows
```

The resulting installers will be in the `dist` directory.

## Frequently Asked Questions

**Do I have to install VirtualBox?**

No, you can deselect VirtualBox during installation. It is bundled in case you want to have a working environment for free.
