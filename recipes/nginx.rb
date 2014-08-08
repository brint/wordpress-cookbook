#
# Cookbook Name:: wordpress
# Recipe:: nginx
#
# Copyright 2009-2010, Opscode, Inc.
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

node.set_unless['php-fpm']['pools'] = []

include_recipe "php-fpm"

php_fpm_pool "wordpress" do
  listen "127.0.0.1:9000"
  user node['wordpress']['install']['user']
  group node['wordpress']['install']['group']
  if node['platform'] == 'ubuntu' and node['platform_version'] == '10.04'
    process_manager 'dynamic'
  end
  listen_owner node['wordpress']['install']['user']
  listen_group node['wordpress']['install']['group']
  start_servers 5
end

include_recipe "php::module_mysql"

node.set['nginx']['default_site_enabled'] = false
include_recipe "nginx"
include_recipe "wordpress::database"

::Chef::Recipe.send(:include, Opscode::OpenSSL::Password)
node.set_unless['wordpress']['keys']['auth'] = secure_password
node.set_unless['wordpress']['keys']['secure_auth'] = secure_password
node.set_unless['wordpress']['keys']['logged_in'] = secure_password
node.set_unless['wordpress']['keys']['nonce'] = secure_password
node.set_unless['wordpress']['salt']['auth'] = secure_password
node.set_unless['wordpress']['salt']['secure_auth'] = secure_password
node.set_unless['wordpress']['salt']['logged_in'] = secure_password
node.set_unless['wordpress']['salt']['nonce'] = secure_password
node.save unless Chef::Config[:solo]

directory node['wordpress']['dir'] do
  action :create
  recursive true
  owner 'root'
  group 'root'
  mode  '00755'
end

archive = platform_family?('windows') ? 'wordpress.zip' : 'wordpress.tar.gz'

if platform_family?('windows')
  windows_zipfile node['wordpress']['parent_dir'] do
    source node['wordpress']['url']
    action :unzip
    not_if {::File.exists?("#{node['wordpress']['dir']}\\index.php")}
  end
else
  remote_file "#{Chef::Config[:file_cache_path]}/#{archive}" do
    source node['wordpress']['url']
    action :create
  end

  execute "extract-wordpress" do
    command "tar xf #{Chef::Config[:file_cache_path]}/#{archive} --strip-components 1 -C #{node['wordpress']['dir']}"
    creates "#{node['wordpress']['dir']}/index.php"
  end
end

template "#{node['wordpress']['dir']}/wp-config.php" do
  source 'wp-config.php.erb'
  mode 0644
  variables(
    :db_name          => node['wordpress']['db']['name'],
    :db_user          => node['wordpress']['db']['user'],
    :db_password      => node['wordpress']['db']['pass'],
    :db_host          => node['wordpress']['db']['host'],
    :db_prefix        => node['wordpress']['db']['prefix'],
    :db_charset       => node['wordpress']['db']['charset'],
    :db_collate       => node['wordpress']['db']['collate'],
    :auth_key         => node['wordpress']['keys']['auth'],
    :secure_auth_key  => node['wordpress']['keys']['secure_auth'],
    :logged_in_key    => node['wordpress']['keys']['logged_in'],
    :nonce_key        => node['wordpress']['keys']['nonce'],
    :auth_salt        => node['wordpress']['salt']['auth'],
    :secure_auth_salt => node['wordpress']['salt']['secure_auth'],
    :logged_in_salt   => node['wordpress']['salt']['logged_in'],
    :nonce_salt       => node['wordpress']['salt']['nonce'],
    :lang             => node['wordpress']['languages']['lang'],
    :allow_multisite  => node['wordpress']['allow_multisite']
  )
  action :create
end

template "#{node['nginx']['dir']}/sites-enabled/wordpress.conf" do
  source "nginx.conf.erb"
  variables(
    :docroot          => node['wordpress']['dir'],
    :server_name      => node['wordpress']['server_name'],
    :server_aliases   => node['wordpress']['server_aliases'],
    :server_port      => node['wordpress']['server_port']
  )
  action :create
end
