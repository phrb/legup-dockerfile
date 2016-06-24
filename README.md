#### LegUp Docker Image

This repository contains a Dockerfile to generate an image with a LegUp
installation, including Altera Quartus Prime and GXemul.

##### Running the Dockerfile

The final image is **25GB**, larger than the default Docker device size.
It is necessary to increase Docker's devicemapper base size. The
following procedure increases the base size and builds the image,
**but it also wipes out your Docker images and containers** so
**backup any important files**.

Check [these Docker
docs](https://docs.docker.com/engine/reference/commandline/dockerd/#storage-driver-options)
for more information.

The Dockerfile will download large files, of up to **6.5GB**,
so a good internet connection is required. The full build
takes approximately **4h**.

```
sudo systemctl stop docker
sudo rm -rf /var/lib/docker
sudo docker daemon --storage-opt dm.basesize=30G
sudo systemctl start docker
sudo docker build .
```
