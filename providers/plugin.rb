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
    archive = "#{Chef::Config[:file_cache_path]}/#{@new_resource.plugin_name}.zip"
    archive_source = @new_resource.source
    shell_out!("curl -L #{archive_source} > #{archive}")
    
    args << %<"#{archive}">
  end
  
  wp!("plugin install #{args.join(' ')}")
  @new_resource.updated_by_last_action(true)
end

action :upgrade do
  wp!("plugin status ${@new_resource.plugin_name}").stdout[/Version: (.*)/]
  current_version = $1
  
  wp!("plugin update #{@new_resource.plugin_name} --version=#{@new_resource.version}")
  
  wp!("plugin status ${@new_resource.plugin_name}").stdout[/Version: (.*)/]
  new_version = $1
  
  @new_resource.updated_by_last_action(current_version != new_version)
end

action :remove do
  next unless installed?
  wp!("plugin uninstall #{@new_resource.plugin_name} --no-delete")
  @new_resource.updated_by_last_action(true)
end

action :purge do
  next unless installed?
  wp!("plugin uninstall #{@new_resource.plugin_name}")
  @new_resource.updated_by_last_action(true)
end

action :activate do
  next if wp!("plugin status #{@new_resource.plugin_name}").stdout[/Status: .*Active/]
  wp!("plugin activate #{@new_resource.plugin_name}")
  @new_resource.updated_by_last_action(true)
end

action :deactivate do
  next unless wp!("plugin status #{@new_resource.plugin_name}").stdout[/Status: .*Active/]
  wp!("plugin activate #{@new_resource.plugin_name}")
  @new_resource.updated_by_last_action(true)
end

def installed?
  shell_out(%<#{node['wordpress']['bin']} --path="#{path}" plugin status #{@new_resource.plugin_name}>).exitstatus == 0
end

def path
  node['wordpress']['dir']
end

def wp!(args)
  shell_out!(%<#{node['wordpress']['bin']} --path="#{path}" #{args}>)
end
