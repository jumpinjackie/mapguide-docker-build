#!/bin/bash

# Builds the docker image of the given component
#
# This is used to construct the base/fdo/mapguide images
#
# NOTE: You must build the base image first before building the fdo/mapguide ones as they inherit
# from the base image
PROJECT=
DISTRO=
CPU_PLAT=
COMPONENT=
TAG=
THISDIR=`pwd`

show_usage()
{
    echo "Usage: ./image_build.sh --project [mapguide|fdo|base] --distro [distro] --platform [x86|x64] --component [component]"
}

validate_required_argument()
{
    if [ -z "$1" ]; then
        echo "Missing required argument $2"
        show_usage
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
    -d|--distro)
    DISTRO="$2"
    shift # past argument
    ;;
    -p|--platform)
    CPU_PLAT="$2"
    shift # past argument
    ;;
    -c|--component)
    COMPONENT="$2"
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
validate_required_argument "$COMPONENT" "--component"
validate_required_argument "$CPU_PLAT" "--platform"

# Validate --project
if [ "$PROJECT" != "mapguide" ] && [ "$PROJECT" != "fdo" ] && [ "$PROJECT" != "base" ]; then
    echo "[error]: Argument --project must be 'mapguide', 'fdo' or 'base'"
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

# Validate --component
if [ ! -d "./$PROJECT/$DISTRO/$CPU_PLAT/$COMPONENT" ]; then
    echo "[error]: Argument --component is not valid. Valid values include"
    for d in $(ls ./$PROJECT/$DISTRO/$CPU_PLAT); do
        echo "  $d"
    done
    exit 1
fi

# Validate dockerfile exists
if [ ! -f ./$PROJECT/$DISTRO/$CPU_PLAT/$COMPONENT/Dockerfile ]; then
    echo "[error]: Could not find expected Dockerfile in ./$PROJECT/$DISTRO/$CPU_PLAT/$COMPONENT/"
    exit 1
fi

if [ -z "$TAG" ]; then
    TAG="latest"
fi

echo "[build]: Using tag ($TAG)"
IMAGE_NAME="osgeo/${COMPONENT}-${PROJECT}-${DISTRO}-${CPU_PLAT}"
DOCKERFILE_DIR="./$PROJECT/$DISTRO/$CPU_PLAT/$COMPONENT"

echo "[build]: Building docker image (${IMAGE_NAME}:${TAG}) in $DOCKERFILE_DIR"
docker build -t ${IMAGE_NAME}:${TAG} -f ${DOCKERFILE_DIR}/Dockerfile .
# TODO: Squashing this image would be nice