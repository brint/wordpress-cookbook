#
# Author:: Lucas Hansen <lucash@opscode.com>
# Cookbook Name:: wordpress
# Recipe:: plugin_acs
#
# Copyright:: 2013, Opscode, Inc <legal@opscode.com>
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

require 'chef/mixin/shell_out'
::Chef::Resource::Template.send :include, Chef::Mixin::ShellOut

config = node['wordpress']['plugin']['acs']

wordpress_plugin 'acs' do
  action :install
  plugin_name config['name']
  version config['version']
end

template "acs_config" do
  action :create
  source 'plugin_acs_config.erb'
  path(lazy do
    cmd = shell_out!("#{node['wordpress']['bin']} --path=\"#{node['wordpress']['dir']}\" plugin path #{config['name']}")
    dir = File.dirname(cmd.stdout.gsub('\\', '/'))
    "#{dir}/acs-wp-plugin-config.php"
  end)
  variables config
end

wordpress_plugin 'acs' do
  action :activate
end
