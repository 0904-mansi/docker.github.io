+++
title = "Upgrade Trusted Registry and the CS Engine"
description = "Upgrade Trusted Registry and the CS Engine"
keywords = ["docker, documentation, about, technology, hub, upgrade, enterprise, pin, patch, migrate, Docker Trusted Registry, Docker commercially supported Engine"]
[menu.main]
parent="workw_dtr_install"
+++


# Upgrade the Trusted Registry and the CS Engine

This document describes the steps to upgrade Docker Trusted Registry and the
commercially supported Engine (CS Engine). When you first install, the general
order is to install the CS Engine, then install the Trusted Registry. However,
when you upgrade, you reverse that order. Ensure when upgrading the Trusted
Registry, that you also upgrade to the latest CS Engine.

The CS Engine has three upgrade paths which are described in this document:

* [**Legacy**: versions 1.6.x to 1.9.x onwards](#upgrade-legacy-to-the-latest-version")
* [**Major to major upgrades**: versions 1.9.0 to 1.10.x](#upgrade-major-to-major-versions")
* [**Minor to minor upgrades**: versions 1.10 to 1.10.x](#upgrade-minor-to-minor-versions")

## Upgrade Docker Trusted Registry

Periodic upgrades to the Trusted Registry trigger a notification to appear in
your Admin dashboard if you have enabled Upgrade checking. This is located in
the General > Settings section of the Trusted Registry Admin dashboard. To
perform this upgrade, you should schedule it during your downtime and allow
about 15 minutes.

To upgrade, perform the following steps:

1. Load the Trusted Registry Dashboard in your browser and navigate to > Settings > Updates.

2. Click Updates in the Settings nav bar. You can see the currently installed version and a message stating that the version is either current or an update is
available. If an update is available, the message states: System Update
Available and an enabled button displays Update to version X.X.X.

3. Click Update to start the update process. The process may take longer than what the message indicates. To check the status of the install, SSH into the Trusted Registry host through a command line:

    ```
      $ sudo docker logs -f $(sudo docker ps -a --no-trunc | grep 'manager execute-upgrade' | head -n1 | awk '{print $1}')
    ```

4. Refresh your screen to see the latest changes.

      The Dashboard displays a message that the upgrade successfully completed and that you need to upgrade to the latest CS Engine.

### What is updated in the Trusted Registry?

The Trusted Registry pulls new container images from Docker Hub. Then it deploys those containers. Finally, it stops and removes the old containers.

If the CS Engine is upgraded first, then the Trusted Registry can still be
upgraded from a command line by running the following command. Ensure to put the
correct version that you want.

```
$ sudo bash -c "$(sudo docker run docker/trusted-registry:1.3.3 upgrade 1.4.3)"
```

## Upgrade to the latest version of the CS Engine

This section describes the three upgrade paths depending on your currently
installed CS Engine version.

Whichever path you select, you must first stop the Trusted Registry prior to
upgrading the CS Engine. Run `docker ps` to verify which version you have, then
ensure the following command contains your version.

    `$ sudo bash -c "$(sudo docker run docker/trusted-registry:1.4.3 stop)"`

>**WARNING**: If you stop the CS Engine, while the Trusted Registry is running, the Trusted Registry may not perform as expected and you must restart it.

### Upgrade legacy to the latest version

Legacy is versions prior to 1.9.0. The following steps describe how to upgrade
from prior versions to 1.10.0. The installation mechanism for versions prior to
1.9.0 are incompatible with 1.9.0 onwards. So you must uninstall your earlier
version before upgrading to a current version.

Next, following the instructions that are based on your operating system.

#### CentOS 7.1 & RHEL 7.0/7.1 (YUM-based systems)

Perform the following commands in your terminal to remove your current CS
Engine, and install the new version.

1. Remove the current CS Engine:

    `$ sudo yum remove docker-engine-cs`

2. Add Docker's public key for CS packages:

    ```
    $ sudo rpm --import "https://sks-keyservers.net/pks/lookup?op=get&search=0xee6d536cf7dc86e2d7d56f59a178ac6c6238f52e"
    ```

3. Install yum-utils if necessary:

    `$ sudo yum install -y yum-utils`

4. Add the repository for the new version and disable the old one. Also, ensure in the following code snippet that you have the OS that you want.

    ```
    $ sudo yum-config-manager --add-repo https://packages.docker.com/1.10/yum/repo/main/centos/7
    $ sudo yum-config-manager --disable 'Docker_cs*'
    ```
5. Install the new package:

    `$ sudo yum install docker-engine`

6. Enable the Docker daemon as a service and then start it.

    ```
    $ sudo systemctl enable docker.service
    $ sudo systemctl start docker.service
    ```

7. Verify that the CS Engine is running:

      `$ sudo docker info`


8. Now you can restart the Trusted Registry.  

    ```
    $ sudo bash -c "$(sudo docker run docker/trusted-registry restart)"
    ```

#### Ubuntu 14.04 LTS (APT-based systems)

Perform the following commands in your terminal to remove your current CS
Engine, and install the new version.

1. Remove the current Engine:

    `$ sudo apt-get remove docker-engine-cs`

2. Add Docker's public key for CS packages:

    ```
    $ curl -s 'https://sks-keyservers.net/pks/lookup?op=get&search=0xee6d536cf7dc86e2d7d56f59a178ac6c6238f52e' | sudo apt-key add --import
    ```

3. Install the HTTPS helper for apt (your system may already have it):

      `$ sudo apt-get update && sudo apt-get install apt-transport-https`

4. Install additional virtual drivers not in the base image.

      `$ sudo apt-get install -y linux-image-extra-virtual`

      You may need to reboot your server after updating the LTS kernel.

5. Add the repository for the new version:

    ```
    $ echo "deb https://packages.docker.com/1.10/apt/repo ubuntu-trusty main" | sudo tee /etc/apt/sources.list.d/docker.list
    ```

      Modify the "ubuntu-trusty" string for your flavor of ubuntu or debian as seen in the following options.

      * debian-jessie (Debian 8)
      * debian-stretch (future release)
      * debian-wheezy (Debian 7)
      * ubuntu-precise (Ubuntu 12.04)
      * ubuntu-trusty (Ubuntu 14.04)
      * ubuntu-utopic (Ubuntu 14.10)
      * ubuntu-vivid (Ubuntu 15.04)
      * ubuntu-wily (Ubuntu 15.10)


6. Install the new package:		

       `$ sudo apt-get update && sudo apt-get install docker-engine`


7. Verify that the CS Engine is running:

      `$ sudo docker info`


8. Restart the Trusted Registry:  

     `$ sudo bash -c "$(sudo docker run docker/trusted-registry restart)"`


### Upgrade major to major versions

Use these directions in upgrading major to major versions of the CS Engine, such
as 1.9.0 to 1.10.0. Perform the following steps depending on your type of
system.

#### CentOS 7.1 & RHEL 7.0/7.1 (YUM-based systems)


1. Add the repository. Notice in the following code that it gets the latest version of the CS Engine. Each time you either install or upgrade, ensure that the you are requesting the version and the OS that you want.

    ```
    $ sudo yum-config-manager --add-repo https://packages.docker.com/1.10/yum/repo/main/centos/7
    ```

2. Install the new package:

        `$ sudo yum update docker-engine`


3. Verify that the CS Engine is running:

    `$ sudo docker info`


4. Restart the Trusted Registry:  

    `$ sudo bash -c "$(sudo docker run docker/trusted-registry restart)"`

#### Ubuntu 14.04 LTS (APT-based systems)


1. Add the repository for the new version.

    ```
    $ echo "deb https://packages.docker.com/1.10/apt/repo ubuntu-trusty main" | sudo tee /etc/apt/sources.list.d/docker.list
    ```

      You must modify the "ubuntu-trusty" string for your flavor of ubuntu or debian as seen in the following options.

      * debian-jessie (Debian 8)
      * debian-stretch (future release)
      * debian-wheezy (Debian 7)
      * ubuntu-precise (Ubuntu 12.04)
      * ubuntu-trusty (Ubuntu 14.04)
      * ubuntu-utopic (Ubuntu 14.10)
      * ubuntu-vivid (Ubuntu 15.04)
      * ubuntu-wily (Ubuntu 15.10)


2. Update your `docker-engine` package.

    ```
    $ sudo apt-get update && sudo apt-get upgrade docker-engine
    ```

3. Verify that the CS Engine is running:

    `$ sudo docker info`

4. Restart the Trusted Registry:  

    ```
    $ sudo bash -c "$(sudo docker run docker/trusted-registry restart)"
    ```

#### SUSE Enterprise 12.3

1. Add the repository. Notice in the following code that it gets the latest version of the CS Engine. Each time you either install or upgrade, ensure that the you are requesting the version and the OS that you want.

      ```
      $ sudo zypper ar -t YUM https://packages.docker.com/1.10/yum/repo/main/opensuse/12.3 docker-1.10
      ```

2. Install the new package:

    `$ sudo zypper update docker-engine`


3. Verify that the CS Engine is running:

    `$ sudo docker info`


4. Restart the Trusted Registry:  

    ```
    $ sudo bash -c "$(sudo docker run docker/trusted-registry restart)"
    ```


### Upgrade minor to minor versions

Use these streamlined directions in upgrading minor to minor versions of the CS
Engine, such as 1.10.0 to 1.10.x. Upgrading minor versions of the CS Engine, can
solve potential issues or may contain a needed feature. Perform the following
steps depending on your type of system.

#### CentOS 7.1 & RHEL 7.0/7.1 (YUM-based systems)

1. Update your `docker-engine` package:

    `$ sudo yum upgrade docker-engine`

2. Verify that the CS Engine is running:

    `$ sudo docker info`

3. Restart the Trusted Registry:  

    ```
    $ sudo bash -c "$(sudo docker run docker/trustmed-registry restart)"
    ```

#### Ubuntu 14.04 LTS (APT-based systems)


1. Update your `docker-engine` package:

    `$ sudo apt-get update && sudo apt-get upgrade docker-engine`

2. Verify that the CS Engine is running:

    `$ sudo docker info`    

3. Restart the Trusted Registry:  

    `$ sudo bash -c "$(sudo docker run docker/trusted-registry restart)"`

#### SUSE Enterprise 12.3

1. Update your `docker-engine` package:

      `$ sudo zypper upgrade docker-engine`

2. Verify that the CS Engine is running:

      `$ sudo docker info`

3. Restart the Trusted Registry:  

      `$ sudo bash -c "$(sudo docker run docker/trusted-registry restart)"`


## See also

* To configure for your environment, see the
[configuration instructions](../configure/configuration.md).
* To use Docker Trusted Registry, see [the User guide](../userguide.md).
* See [installing the CS Engine](install-csengine.md).
* To make administrative changes, see [the Admin guide](../adminguide.md).
* To see previous changes, go to the [release notes](../release-notes.md).
