#!/bin/bash

set -ex

ARCH="$(uname -m)"
KERNEL_VERSION="${2#kernel-}"
# ZFS_VERSION="$3"

echo $1 $2 $3

KERNEL_FULL_VERSION="${KERNEL_VERSION}.${ARCH}"
# 
ZFS_NAME="$3"
ZFS_FILENAME="${ZFS_NAME}.tar.gz"


WORKDIR=$(mktemp -d)
cd $WORKDIR
# 

sudo dnf install -y --skip-broken koji epel-release gcc make autoconf automake libtool rpm-build kernel-rpm-macros libtirpc-devel libblkid-devel libuuid-devel libudev-devel openssl-devel zlib-devel libaio-devel libattr-devel elfutils-libelf-devel python3 python3-devel python3-setuptools python3-cffi libffi-devel ncompress
sudo dnf install -y --skip-broken --enablerepo=epel --enablerepo=powertools python3-packaging dkms

koji download-build --arch=${ARCH} --rpm kernel-devel-${KERNEL_FULL_VERSION}
sudo dnf install -y \
    ./kernel-devel-${KERNEL_FULL_VERSION}.rpm
# 

tar xf /data/${ZFS_FILENAME}
cd ${ZFS_NAME}
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
./configure --with-linux=/usr/src/kernels/${KERNEL_FULL_VERSION}
# 
make -j1 srpm-utils srpm-kmod
mkdir -p /data/packages/
cp *.rpm /data/packages/