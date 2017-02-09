# Dockerfile for building MapGuide 64-bit
FROM ubuntu:14.04
MAINTAINER Jackie Ng "jumpinjackie@gmail.com"

# Suppress a bucketload of debconf warnings about dialog
ENV DEBIAN_FRONTEND noninteractive

# Load prerequisites
ADD scripts/ubuntu14_x64_prerequisites.sh /tmp/prerequisites.sh
RUN /tmp/prerequisites.sh