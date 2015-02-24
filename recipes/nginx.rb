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
  listen "127.0.0.1:9001"
  user node['wordpress']['install']['user']
  group node['wordpress']['install']['group']
  if node['platform'] == 'ubuntu' and node['platform_version'] == '10.04'
    process_manager 'dynamic'
  end
  listen_owner node['wordpress']['install']['user']
  listen_group node['wordpress']['install']['group']
  php_options node['wordpress']['php_options']
  start_servers 5
end

include_recipe "php::module_mysql"

node.set_unless['nginx']['default_site_enabled'] = false
include_recipe "nginx"

include_recipe "wordpress::app"

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

# The following block is specifically for OS's like CentOS that include a
# default site as a part of the install. This block will only be triggered if
# node['nginx']['default_site_enable'] is set to false.
if node['platform_family'] == 'rhel' && !node['nginx']['default_site_enabled']
  file File.join(node['nginx']['dir'], 'conf.d', 'default.conf') do
    action :delete
    notifies :reload, 'service[nginx]'
  end
end
