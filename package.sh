#!/bin/bash

set -xe

### The dir for the package script
MY_DIR=$( dirname $0 )
cd $MY_DIR

### Name of the package, project, etc
NAME=elasticsearch

### This is a symlink to the dir with the version of kibana we want to build
### This is something like elasticsearch-1.5.2

TARGET=$( basename $( readlink $NAME ) )

### Packaging info
PACKAGE_NAME=$NAME
### Because 1.5.2 > 1.5.2~krux... we prefix the version with 1: to win on sorting.
PACKAGE_VERSION=1:$( echo $TARGET | perl -ne '/([\d.]+)/; print $1')~krux$( date -u +%Y%m%d%H%M )

### Where this package will be installed
### Because this is a re-package of the official debian package, the prefix is /, ie the
### root directory.
DEST_DIR="/"

### Where the sources live
SOURCE_DIR="${MY_DIR}/${TARGET}"

# run fpm
FPM=$( which fpm )
$FPM -s dir -t deb -a all -n $PACKAGE_NAME -v $PACKAGE_VERSION --prefix $DEST_DIR -C $SOURCE_DIR $@ .

