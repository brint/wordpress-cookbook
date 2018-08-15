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

users = node[:wordpress][:admin][:users] || []

if users.any?
  directory File.dirname(node[:wordpress][:admin][:htpasswd]) do
    owner 'root'
    group 'root'
    recursive true
    mode 0755
  end

  file node[:wordpress][:admin][:htpasswd] do
    owner node[:wordpress][:install][:user]
    group node[:wordpress][:install][:group]
    mode 0644
    content users.join("\n")
  end
end

include_recipe "wordpress::apache"
