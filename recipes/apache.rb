#
# Cookbook Name:: wordpress
# Recipe:: apache
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

include_recipe "php"

# On Windows PHP comes with the MySQL Module and we use IIS on Windows
unless platform? "windows"
  include_recipe "php::module_mysql"
  include_recipe "apache2"
  include_recipe "apache2::mod_php5"
end

include_recipe "wordpress::app"

if platform?('windows')

  include_recipe 'iis::remove_default_site'

  iis_pool 'WordpressPool' do
    no_managed_code true
    action :add
  end

  iis_site 'Wordpress' do
    protocol :http
    port 80
    path node['wordpress']['dir']
    application_pool 'WordpressPool'
    action [:add,:start]
  end
else
  web_app "wordpress" do
    template "wordpress.conf.erb"
    docroot node['wordpress']['dir']
    server_name node['wordpress']['server_name']
    server_aliases node['wordpress']['server_aliases']
    server_port node['wordpress']['server_port']
    enable true
  end
end
