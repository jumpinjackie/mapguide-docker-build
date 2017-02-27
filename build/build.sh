#!/bin/bash

# Builds MapGuide/FDO
#
# This is used to build MapGuide/FDO using the base images
#
# NOTE: You must build the base image first before building the fdo/mapguide ones as they inherit
# from the base image
PROJECT=
DISTRO=
CPU_PLAT=
TAG=
THISDIR=`pwd`
VER_MAJOR=
VER_MINOR=
VER_PATCH=

show_usage()
{
    echo "Usage: ./build.sh --project [mapguide|fdo] --distro [distro] --platform [x86|x64] --tag [tag]"
}

validate_required_argument()
{
    if [ -z "$1" ]; then
        echo "Missing required argument $2"
        show_usage
        exit 1
    fi
}

while [[ $# > 1 ]]
do
key="$1"

case $key in
    -p|--project)
    PROJECT="$2"
    shift # past argument
    ;;
    --major)
    VER_MAJOR="$2"
    shift # past argument
    ;;
    --minor)
    VER_MINOR="$2"
    shift # past argument
    ;;
    --patch)
    VER_PATCH="$2"
    shift # past argument
    ;;
    -d|--distro)
    DISTRO="$2"
    shift # past argument
    ;;
    -p|--platform)
    CPU_PLAT="$2"
    shift # past argument
    ;;
    -t|--tag)
    TAG="$2"
    shift # past argument
    ;;
    -h|--help)
    show_usage
    exit 0
    ;;
    *)
            # unknown option
    ;;
esac
shift # past argument or value
done

validate_required_argument "$PROJECT" "--project"
validate_required_argument "$DISTRO" "--distro"
validate_required_argument "$TAG" "--version"
validate_required_argument "$CPU_PLAT" "--platform"
validate_required_argument "$VER_MAJOR" "--major"
validate_required_argument "$VER_MINOR" "--minor"
validate_required_argument "$VER_PATCH" "--patch"

# Validate --project
if [ "$PROJECT" != "mapguide" ] && [ "$PROJECT" != "fdo" ]; then
    echo "[error]: Argument --project must be 'mapguide' or 'fdo'"
    show_usage
    exit 1
fi

# Validate --platform
if [ "$CPU_PLAT" != "x86" ] && [ "$CPU_PLAT" != "x64" ]; then
    echo "[error]: Argument --platform must be 'x86' or 'x64'"
    show_usage
    exit 1
fi

# Validate --distro
if [ ! -d "./$PROJECT/$DISTRO/" ]; then
    echo "[error]: Argument --component is not valid. Valid values include"
    for d in $(ls ./$PROJECT); do
        echo "  $d"
    done
    exit 1
fi

# Validate --version
if [ ! -d "../sources/$PROJECT/$TAG/" ]; then
    echo "[error]: Argument --version is not valid. Valid values include"
    for d in $(ls ../sources/$PROJECT); do
        echo "  $d"
    done
    exit 1
fi

if [ -z "$TAG" ]; then
    TAG="latest"
fi

BUILD_IMAGE_NAME="osgeo/build-base-${DISTRO}-${CPU_PLAT}"

mkdir -p ../artifacts/$PROJECT/$TAG

HOST_OUTPUT_PATH=$(readlink -f "../artifacts/$PROJECT/$TAG")
HOST_TOOLS_PATH=$(readlink -f "../tools")
HOST_SRC_PATH=$(readlink -f "../sources/$PROJECT/$TAG")
HOST_BUILD_PATH=$(readlink -f "../build_area/$PROJECT/$TAG")
CNT_OUTPUT_PATH="/tmp/build/artifacts"
CNT_TOOLS_PATH="/tmp/build/tools"
CNT_SRC_PATH="/tmp/build/sources/$PROJECT"
CNT_BUILD_PATH="/tmp/build/area"

echo "Running $BUILD_IMAGE_NAME ($PROJECT, $DISTRO, $CPU_PLAT) v$VER_MAJOR.$VER_MINOR.$VER_PATCH"
echo "  Host path ($HOST_OUTPUT_PATH) will be mounted to ($CNT_OUTPUT_PATH) inside the container"
echo "  Host path ($HOST_TOOLS_PATH) will be mounted to ($CNT_TOOLS_PATH) inside the container"
echo "  Host path ($HOST_SRC_PATH) will be mounted to ($CNT_SRC_PATH) inside the container"
echo "  Host path ($HOST_BUILD_PATH) will be mounted to ($CNT_BUILD_PATH) inside the container"
docker run -v $HOST_OUTPUT_PATH:$CNT_OUTPUT_PATH -v $HOST_TOOLS_PATH:$CNT_TOOLS_PATH -v $HOST_SRC_PATH:$CNT_SRC_PATH -v $HOST_BUILD_PATH:$CNT_BUILD_PATH -it $BUILD_IMAGE_NAME /bin/bash
#docker run -v $HOST_SRC_PATH:$CNT_SRC_PATH -v $HOST_BUILD_PATH:$CNT_BUILD_PATH -it $BUILD_IMAGE_NAME /tmp/build/provision.sh --tag $TAG --project $PROJECT --arch $CPU_PLAT