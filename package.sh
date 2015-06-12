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

### Where the sources live
SOURCE_DIR="${MY_DIR}/${TARGET}"

###
### Plugin/config settings
###

PLUGIN_BIN=$SOURCE_DIR/usr/share/elasticsearch/bin/plugin

### The default is a krux-ism, but set that if it's not otherwise specified
JAVA_HOME=${JAVA_HOME-"/usr/local/oracle-java-8/"}
export JAVA_HOME

### We have to set these because of this bug in ES 1.6:
### https://github.com/elastic/elasticsearch/issues/11612
### Once fixed, we can remove these
ES_INCLUDE=$SOURCE_DIR/etc/default/elasticsearch
CONF_FILE=$SOURCE_DIR/etc/elasticsearch/elasticsearch.yaml
CONF_DIR=$SOURCE_DIR/etc/elasticsearch

export ES_INCLUDE
export CONF_FILE
export CONF_DIR

###
### Package settings
###

### Packaging info
PACKAGE_NAME=$NAME
### Because 1.5.2 > 1.5.2~krux... we prefix the version with 1: to win on sorting.
PACKAGE_VERSION=1:$( echo $TARGET | perl -ne '/([\d.]+)/; print $1')~krux$( date -u +%Y%m%d%H%M )

### Where this package will be installed
### Because this is a re-package of the official debian package, the prefix is /, ie the
### root directory.
DEST_DIR="/"

###
### Plugins to be installed
###
PLUGINS=`cat plugins.list | grep -v ^#`

### Install plugins into package dir
for p in $PLUGINS; do
  ### First, we REMOVE the plugin; because the install command will fail if the plugin is already
  ### there, and the remove command will NOT fail if the plugin is NOT there.
  $PLUGIN_BIN --remove $p
  $PLUGIN_BIN --install $p
done

###
### Build package
###

### run fpm
FPM=$( which fpm )
$FPM -s dir -t deb -a all -n $PACKAGE_NAME -v $PACKAGE_VERSION --prefix $DEST_DIR -C $SOURCE_DIR $@ .

