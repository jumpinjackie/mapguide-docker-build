# Dockerfile for building MapGuide 64-bit
FROM ubuntu:14.04
MAINTAINER Jackie Ng "jumpinjackie@gmail.com"

# Suppress a bucketload of debconf warnings about dialog
ENV DEBIAN_FRONTEND noninteractive

# Load scripts
ADD scripts /tmp/build
RUN /tmp/build/ubuntu14_x64_prerequisites.sh