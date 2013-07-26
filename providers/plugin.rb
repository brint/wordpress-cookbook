#
# Author:: Lucas Hansen <lucash@opscode.com>
# Cookbook Name:: wordpress
# Provider:: wordpress_plugin
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
include Chef::Mixin::ShellOut

action :install do
  next if installed?
  
  args = []
  if @new_resource.source.nil?
    args << @new_resource.plugin_name
    args << "--version=#{@new_resource.version}"
  else
    zip = "#{Chef::Config[:file_cache_path]}/#{new_resource.plugin_name}.zip"
    remote_file zip { source @new_resource.source }
    args << @new_resource.source
  end
  
  wp!("plugin install #{args.join(' ')}")
end

action :upgrade do
  wp!("plugin update #{@new_resource.plugin_name} --version=#{@new_resource.version}")
end

action :remove do
  next unless installed?
  wp!("plugin uninstall #{@new_resource.plugin_name} --no-delete")
end

action :purge do
  next unless installed?
  wp!("plugin uninstall #{@new_resource.plugin_name}")
end

action :activate do
  wp!("plugin activate #{@new_resource.plugin_name}")
end

action :deactivate do
  wp!("plugin activate #{@new_resource.plugin_name}")
end

def installed?
  shell_out("#{node['wordpress']['bin']} --path=\"#{path}\" plugin status #{@new_resource.plugin_name}").exitstatus == 0
end

def path
  node['wordpress']['dir'].gsub('/', '\\')
end

def wp!(args)
  shell_out!("#{node['wordpress']['bin']} --path=\"#{path}\" #{args}")
end
