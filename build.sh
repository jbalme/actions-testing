#!/bin/bash

set -ex

ARCH="x86_64"
KERNEL_VERSION="5.18.17-200.fc36"
ZFS_VERSION="2.1.5"

echo $1 $2 $3

# KERNEL_FULL_VERSION="${KERNEL_VERSION}.${ARCH}"
# 
# ZFS_NAME="zfs-${ZFS_VERSION}"
# ZFS_FILENAME="zfs-${ZFS_VERSION}.tar.gz"
# 
# WORKDIR=$(mktemp -d)
# 
# cd $WORKDIR
# 
# dnf install -y \
#     koji
# koji download-build --arch=${ARCH} --rpm kernel-devel-${KERNEL_FULL_VERSION}
# dnf install -y \
#     ./kernel-devel-${KERNEL_FULL_VERSION}.rpm
# 
# dnf install -y \
#     wget
# wget https://github.com/openzfs/zfs/releases/download/${ZFS_NAME}/${ZFS_FILENAME}
# tar xfv ${ZFS_FILENAME}
# cd ${ZFS_NAME}
# 
# # https://openzfs.github.io/openzfs-docs/Developer%20Resources/Custom%20Packages.html#get-the-source-code
# dnf install -y --skip-broken \
#     epel-release \
#     gcc \
#     make \
#     autoconf \
#     automake \
#     libtool \
#     rpm-build \
#     kernel-rpm-macros \
#     libtirpc-devel \
#     libblkid-devel \
#     libuuid-devel \
#     libudev-devel \
#     openssl-devel \
#     zlib-devel \
#     libaio-devel \
#     libattr-devel \
#     elfutils-libelf-devel \
#     python3 \
#     python3-devel \
#     python3-setuptools \
#     python3-cffi \
#     libffi-devel \
#     ncompress
# dnf install -y --skip-broken --enablerepo=epel --enablerepo=powertools \
#     python3-packaging \
#     dkms
# 
# ./configure
# 
# #./configure --with-linux=/usr/src/kernels/${KERNEL_FULL_VERSION}
# 
# make -j1 srpm-utils srpm-kmod
# 
# mkdir -p /data/packages/
# cp *.rpm *.srpm /data/packages/