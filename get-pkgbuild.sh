#!/bin/bash

_url=https://gitlab.archlinux.org/archlinux/packaging/packages
_file=../plasma.list

mkdir -p plasma
cd plasma

for f in $(cat ${_file}); do
    [[ ! -d $f ]] && [[ ! -d ${f%-git} ]] && \
      git clone ${_url}/${f}.git || echo "$f already exists; skipping."
      cd ${f}
      git remote add arch ${_url}/${f}.git
      git fetch arch
      tag=$(git tag | grep 6.6.5 | tail -n 1)
      git checkout $tag
      cd ..
done
