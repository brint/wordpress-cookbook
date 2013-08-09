Description
===========

Downloads, installs, and configures WordPress using [wp-cli](https://github.com/wp-cli/wp-cli). It **will** actually set up the blog itself, and by the end of the recipe you will have a live, working blog.

Requirements
============

Platform
--------

* Ubuntu, Windows

Tested on:

* Ubuntu 10.04
* Windows Server 2012


Cookbooks
---------

* mysql
* php
* apache2
* windows
* curl
* git
* opensssl (uses library to generate secure passwords)

Attributes
==========

### WordPress

* `node['wordpress']['version']` - Version of WordPress to download. Use 'latest' to download most recent version.
* `node['wordpress']['bin']` - Name of the wp-cli executable installed by Composer.
* `node['wordpress']['dir']` - Location to place WordPress files.
* `node['wordpress']['db']['name']` - Name of the WordPress MySQL database.
* `node['wordpress']['db']['host']` - Host of the WordPress MySQL database.
* `node['wordpress']['db']['user']` - Name of the WordPress MySQL user.
* `node['wordpress']['db']['pass']` - Password of the WordPress MySQL user. By default, generated using openssl cookbook.
* `node['wordpress']['db']['prefix']` - Prefix of all MySQL tables created by WordPress. By default, generated using openssl cookbook.
* `node['wordpress']['blog']['title']` - Title of the WordPress blog.
* `node['wordpress']['blog']['admin_name']` - Name of the WordPress admin.
* `node['wordpress']['blog']['admin_password]` - Password of the WordPress admin.
* `node['wordpress']['blog']['admin_email]` - Email address of the WordPress admin.
* `node['wordpress']['blog']['url']` - URL on which the WordPress blog is hosted.

### ACS Plugin (Windows Azure AppFabric Access Control Service)
* `node['wordpress']['plugin']['acs']['name']` - Name of the WordPress plugin
* `node['wordpress']['plugin']['acs']['version']` - Version of the WordPress plugin. Use 'dev' to download most recent version.
* `node['wordpress']['plugin']['acs']['source']` - URL of WordPress plugin. Set as nil to use the plugin found on the WordPress site.
* `node['wordpress']['plugin']['acs']['namespace']`
* `node['wordpress']['plugin']['acs']['realm']`
* `node['wordpress']['plugin']['acs']['key']`

### WAS Plugin (Windows Azure Storage)
* `node['wordpress']['plugin']['was']['name']` - Name of the WordPress plugin
* `node['wordpress']['plugin']['was']['version']` - Version of the WordPress plugin. Use 'dev' to download most recent version.
* `node['wordpress']['plugin']['was']['source']` - URL of WordPress plugin. Set as nil to use the plugin found on the WordPress site.
* `node['wordpress']['plugin']['was']['azure']['name']`
* `node['wordpress']['plugin']['was']['azure']['key']`
* `node['wordpress']['plugin']['was']['azure']['container']`
* `node['wordpress']['plugin']['was']['azure']['default?']`
* `node['wordpress']['plugin']['was']['azure']['per_user_settings?']`
* `node['wordpress']['plugin']['was']['azure']['cname']`
* `node['wordpress']['plugin']['was']['proxy']['host']`
* `node['wordpress']['plugin']['was']['proxy']['port']`
* `node['wordpress']['plugin']['was']['proxy']['user']`
* `node['wordpress']['plugin']['was']['proxy']['pass']`

Usage
=====

Add the "wordpress" recipe to your node's run list or role, or include the recipe in another cookbook. The cookbooks also provides the 'wordpress_option' and 'wordpress_plugin' resources for managing WordPress configuration and the installation of WordPress plugins.

License and Author
==================

Author:: Barry Steinglass (barry@opscode.com)
Author:: Joshua Timberman (joshua@opscode.com)
Author:: Seth Chisamore (schisamo@opscode.com)
Author:: Lucas Hansen (lucash@opscode.com)

Copyright:: 2010-2013, Opscode, Inc

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
