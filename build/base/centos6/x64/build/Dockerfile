# Dockerfile for building MapGuide 64-bit
FROM centos:6
MAINTAINER Jackie Ng "jumpinjackie@gmail.com"

# Add repo conf to allow installation of SVN 1.8
ADD conf/wandisco-svn.repo /etc/yum.repos.d/wandisco-svn.repo

# Load prerequsites
ADD scripts/centos6_x64_prerequisites.sh /tmp/prerequisites.sh
RUN /tmp/prerequisites.sh