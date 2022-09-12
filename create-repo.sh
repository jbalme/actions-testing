#!/bin/bash

sudo dnf install -y --skip-broken createrepo
mkdir -p /data/repo
ls -R /data/packages
find /data/packages -iname '*.rpm' -type f -exec mv -t /data/repo \{\} \;
createrepo /data/repo
chmod -R u=wrX,go=rX /data/repo