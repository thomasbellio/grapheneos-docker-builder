# About

This repository contains a dockerfile to build a docker image that can be used to flash a device to install [grapheneos](grapheneos.org).

The [Dockerfile](./Dockerfile) is based on the official [ubuntu image](https://hub.docker.com/_/ubuntu), and it installs all necessary components based on the [install documentation](https://grapheneos.org/install/cli) from grapheneos.org.

## Usage

The Dockerfile requires two build args: `DEVICE_NAME` and `VERSION`, which represent the the Device Name and Version on the [grapheneos releases page](https://grapheneos.org/releases).

The example below assumes that you are installing for a Pixel 8 Pro, which happens to be the only device tested with this Docker image so far. The version and device name are gleaned from the Pixel 8 Pro section [here](https://grapheneos.org/releases#husky-stable).

### Steps

1. Make sure your device is booted into the bootloader interface, by following the [instructions on grapheneos.org](https://grapheneos.org/install/cli#booting-into-the-bootloader-interface)
2. Build the image from the root of this repository (make sure to replace the device name and version with the appropriate one from the [releases page](https://grapheneos.org/releases) for your device)
```sh
docker build --build-arg DEVICE_NAME=husky --build-arg VERSION=2024050700 -t graphene-builder .
```
3. Run the container in privileged mode with the Phone plugged into the usb-c port on the host machine.
```sh
docker run -ti --privileged -v /dev/bus/usb/:/dev/bus/usb graphene-builder bash
```
4. Make sure the bootloader is unlocked by running:
```sh
$ fastboot flashing unlock
```
5. Execute the flashing script on the container:
```sh
root@49718996f74e:/graphene-builder/husky-factory-2024050700# ./flash-all.sh
```

It will take a few minutes and install GrapheneOS on the device.

NOTE: This has only been tested on a single device a Pixel 8 Pro. Please feel free to use or modify this as needed. Everything here is offered with no warranties regarding its correctness, please consult the official grapheneos documenatation for details.
