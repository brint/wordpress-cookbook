#
# Cookbook Name:: wordpress
# Recipe:: default
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
include_recipe "php::composer"

# On Windows PHP comes with the MySQL Module
unless platform? "windows"
  include_recipe "php::module_mysql"
end

include_recipe "apache2"
include_recipe "apache2::mod_php5"

include_recipe "wordpress::wp_cli"
include_recipe "wordpress::database"

::Chef::Recipe.send(:include, Opscode::OpenSSL::Password)
node.set_unless['wordpress']['blog']['admin_password'] = secure_password
node.save

bin = node['wordpress']['bin']
dir = node['wordpress']['dir']

directory dir do
  action :create
end

execute "Download WordPress" do
  action :run
  cwd dir
  command "#{bin} core download --version=#{node['wordpress']['version']}"
  only_if { Dir["#{dir}/*"].empty? }
end

db_config = node['wordpress']['db'].map { |k,v| %<--db#{k}="#{v}"> }.join(" ")
execute "Configure WordPress" do
  action :run
  cwd dir
  command "#{bin} core config #{db_config}"
  not_if { File.exists? "#{dir}/wp-config.php" }
end

execute "Create WordPress Tables" do
  action :run
  cwd dir
  command "#{bin} db create"
  returns [0,1] # Command returns 1 if DB exists
end

blog_config = node['wordpress']['blog'].map { |k, v| %<--#{k}="#{v}"> }.join(" ")
execute "Install WordPress" do
  action :run
  cwd dir
  command "#{bin} core install #{blog_config}"
  not_if { `#{bin} --path="#{dir}" core is-installed`; $?.exitstatus == 0 }
end

web_app "wordpress" do
  enable true
  template "site.erb"
end
