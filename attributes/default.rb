#
# Author:: Barry Steinglass (<barry@opscode.com>)
# Author:: Koseki Kengo (<koseki@gmail.com>)
# Cookbook Name:: wordpress
# Attributes:: wordpress
#
# Copyright 2009-2013, Opscode, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# General settings
default['wordpress']['version'] = "latest"
default['wordpress']['checksum'] = ""
default['wordpress']['repourl'] = "http://wordpress.org/"
default['wordpress']['dir'] = "/var/www/wordpress"
default['wordpress']['db']['database'] = "wordpressdb"
default['wordpress']['db']['user'] = "wordpressuser"
default['wordpress']['server_aliases'] = [node['fqdn']]

# Languages
default['wordpress']['languages']['lang'] = ''
default['wordpress']['languages']['version'] = ''
default['wordpress']['languages']['repourl'] = 'http://translate.wordpress.org/projects/wp'
default['wordpress']['languages']['projects'] = ['main', 'admin', 'admin_network', 'continents_cities']
