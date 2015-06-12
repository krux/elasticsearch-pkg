# elasticsearch-pkg
Krux specific packaging of elasticsearch

## Packaging

* Install Java8: apt-get install oracle-java-8
* Run ```./package.sh``` from the root of this checkout

## Bundled plugins

Plugins are defined in the [plugins.list](plugins.list.1.6.0) file.

## Updating the source

* Grab the latest *debian* release from [elastic](https://www.elastic.co/downloads/elasticsearch)
* Extract the package into the root of this repository. For example:
  * ```dpkg --extract elasticsearch-1.5.2.deb elasticsearch-1.5.2```
* Update the ```elasticsearch``` symlink to point to the new directory
* If it's a **Major or Minor version** upgrade, be sure to update plugins.list, and possibly update the symlink.
* Commit your changes

