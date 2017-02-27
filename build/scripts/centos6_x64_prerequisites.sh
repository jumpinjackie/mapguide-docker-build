#!/bin/sh
yum remove subversion*
yum clean all
yum update
yum install -y gcc make gcc-c++ gd-* automake bison byacc flex doxygen expat expat-devel libtool libjpeg-devel libpng libpng-devel libxml2 libxml2-devel openssl curl curl-devel libxslt libxslt-devel java-1.7.0-openjdk java-1.7.0-openjdk-devel ant dos2unix openssh-server openldap-devel alsa-lib-devel pcre-devel unixODBC-devel libcom_err-devel krb5-devel openssl-devel mysql-devel postgresql-devel unixODBC subversion
yum install -y xz-lzma-compat libstdc++.i686 glibc.i686 ant-contrib sudo