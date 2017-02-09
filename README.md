# mapguide-docker-build

An experimental docker-driven build system for MapGuide

# Requirements

 * A linux host OS that can run Docker
 * Docker
 * Git and Subversion

# Usage

## 1. Setup environment 

Clone this repository

    git clone https://github.com/jumpinjackie/mapguide-docker-build ~/docker

Check out the MapGuide/FDO source code

    mkdir -p ~/docker/source/fdo/latest
    mkdir -p ~/docker/source/mapguide/latest
    svn co http://svn.osgeo.org/fdo/trunk ~/docker/sources/fdo/latest
    svn co http://svn.osgeo.org/mapguide/trunk/MgDev ~/docker/sources/mapguide/latest

## 2. Set up the base build environment image

Build the base environment image that the ephemeral build containers will be based upon

Ubuntu 14 (64-bit) example:

    cd ~/docker/build
    ./image_build.sh --project base --distro ubuntu14 --platform x64 --component build

Ubuntu 14 (32-bit) example:

    cd ~/docker/build
    ./image_build.sh --project base --distro ubuntu14 --platform x86 --component build

CentOS 6.x (64-bit) example:

    cd ~/docker/build
    ./image_build.sh --project base --distro centos6 --platform x64 --component build

CentOS 6.x (32-bit) example:

    cd ~/docker/build
    ./image_build.sh --project base --distro centos6 --platform x86 --component build

## 3. Run the ephemeral FDO build container

Ubuntu 14 (64-bit) example:

    cd ~/docker/build
    ./image_build.sh --project fdo --distro ubuntu14 --platform x64 --component build

Ubuntu 14 (32-bit) example:

    cd ~/docker/build
    ./image_build.sh --project fdo --distro ubuntu14 --platform x86 --component build

CentOS 6.x (64-bit) example:

    cd ~/docker/build
    ./image_build.sh --project fdo --distro centos6 --platform x64 --component build

CentOS 6.x (32-bit) example:

    cd ~/docker/build
    ./image_build.sh --project fdo --distro centos6 --platform x86 --component build

## 4. Run the ephemeral MapGuide build container

Ubuntu 14 (64-bit) example:

    cd ~/docker/build
    ./image_build.sh --project mapguide --distro ubuntu14 --platform x64 --component build

Ubuntu 14 (32-bit) example:

    cd ~/docker/build
    ./image_build.sh --project mapguide --distro ubuntu14 --platform x86 --component build

CentOS 6.x (64-bit) example:

    cd ~/docker/build
    ./image_build.sh --project mapguide --distro centos6 --platform x64 --component build

CentOS 6.x (32-bit) example:

    cd ~/docker/build
    ./image_build.sh --project mapguide --distro centos6 --platform x86 --component build