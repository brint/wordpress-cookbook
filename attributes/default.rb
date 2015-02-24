#
# Author:: Barry Steinglass (<barry@opscode.com>)
# Author:: Koseki Kengo (<koseki@gmail.com>)
# Author:: Lucas Hansen (<lucash@opscode.com>)
# Author:: Julian C. Dunn (<jdunn@getchef.com>)
#
# Cookbook Name:: wordpress
# Attributes:: wordpress
#
# Copyright 2009-2013, Chef Software, Inc.
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
default['wordpress']['version'] = 'latest'

default['wordpress']['db']['root_password'] = 'my_root_password'
default['wordpress']['db']['instance_name'] = 'default'
default['wordpress']['db']['name'] = "wordpressdb"
default['wordpress']['db']['user'] = "wordpressuser"
default['wordpress']['db']['pass'] = nil
default['wordpress']['db']['prefix'] = 'wp_'
default['wordpress']['db']['host'] = 'localhost'
default['wordpress']['db']['port'] = '3306'  # Must be a string
default['wordpress']['db']['charset'] = 'utf8'
default['wordpress']['db']['collate'] = ''
case node['platform']
when 'ubuntu'
  case node['platform_version']
  when '10.04'
    default['wordpress']['db']['mysql_version'] = '5.1'
  else
    default['wordpress']['db']['mysql_version'] = '5.5'
  end
when 'centos', 'redhat'
  if node['platform_version'].to_i < 6
    default['wordpress']['db']['mysql_version'] = '5.0'
  elsif node['platform_version'].to_i < 7
    default['wordpress']['db']['mysql_version'] = '5.1'
  else
    default['wordpress']['db']['mysql_version'] = '5.5'
  end
else
  default['wordpress']['db']['mysql_version'] = '5.5'
end

default['wordpress']['allow_multisite'] = false

default['wordpress']['wp_config_options'] = {}

default['wordpress']['config_perms'] = 0644
default['wordpress']['server_aliases'] = [node['fqdn']]
default['wordpress']['server_port'] = '80'

default['wordpress']['install']['user'] = node['apache']['user']
default['wordpress']['install']['group'] = node['apache']['group']

# Languages
default['wordpress']['languages']['lang'] = ''
default['wordpress']['languages']['version'] = ''
default['wordpress']['languages']['repourl'] = 'http://translate.wordpress.org/projects/wp'
default['wordpress']['languages']['projects'] = ['main', 'admin', 'admin_network', 'continents_cities']
default['wordpress']['languages']['themes'] = []
default['wordpress']['languages']['project_pathes'] = {
  'main'              => '/',
  'admin'             => '/admin/',
  'admin_network'     => '/admin/network/',
  'continents_cities' => '/cc/'
}
%w{ten eleven twelve thirteen fourteen fifteen sixteen seventeen eighteen nineteen twenty}.each do |year|
  default['wordpress']['languages']['project_pathes']["twenty#{year}"] = "/twenty#{year}/"
end
node['wordpress']['languages']['project_pathes'].each do |project,project_path|
  # http://translate.wordpress.org/projects/wp/3.5.x/admin/network/ja/default/export-translations?format=mo
  default['wordpress']['languages']['urls'][project] =
    node['wordpress']['languages']['repourl'] + '/' +
    node['wordpress']['languages']['version'] + project_path +
    node['wordpress']['languages']['lang'] + '/default/export-translations?format=mo'
end

if node['platform'] == 'windows'
  default['wordpress']['parent_dir'] = "#{ENV['SystemDrive']}\\inetpub"
  default['wordpress']['dir'] = "#{node['wordpress']['parent_dir']}\\wordpress"
  default['wordpress']['url'] = "https://wordpress.org/wordpress-#{node['wordpress']['version']}.zip"
else
  default['wordpress']['server_name'] = node['fqdn']
  default['wordpress']['parent_dir'] = '/var/www'
  default['wordpress']['dir'] = "#{node['wordpress']['parent_dir']}/wordpress"
  default['wordpress']['url'] = "https://wordpress.org/wordpress-#{node['wordpress']['version']}.tar.gz"
end

default['wordpress']['php_options'] = { 'php_admin_value[upload_max_filesize]' => '50M', 'php_admin_value[post_max_size]' => '55M' }
