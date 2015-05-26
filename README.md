# elasticsearch-pkg
Krux specific packaging of elasticsearch

## Packaging

## Updating the source

* Grab the latest tarball release from [elastic](https://www.elastic.co/downloads/elasticsearch)
* Extract the tarball into the root of this repository
* Update the ```elasticsearch``` symlink to point to the new directory
* Update any plugins:
  * Install java8: ```apt-get install oracle-java-8```
  * Update the plugin: ```JAVA_HOME=/usr/local/oracle-java-8/ bin/plugin install $PLUGIN```
* (OPTIONAL) Clean up the old directory
* Commit your changes
