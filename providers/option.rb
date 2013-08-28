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

action :set do
  current_value = wp!(%<option get "#{new_resource.option}">).stdout.chop rescue :dne
  @new_resource.updated_by_last_action(current_value != @new_resource.value)
  
  wp!(%<option update "#{@new_resource.option}" "#{@new_resource.value}">)
end

action :delete do
  wp!(%<option delete "#{@new_resource.option}">)
  @new_resource.updated_by_last_action(true)
end

def path
  node['wordpress']['dir']
end

def wp!(args)
  shell_out!("#{node['wordpress']['bin']} --path=\"#{path}\" #{args}")
end
