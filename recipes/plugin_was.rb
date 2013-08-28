#
# Author:: Lucas Hansen <lucash@opscode.com>
# Cookbook Name:: wordpress
# Recipe:: plugin_was
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

config = node['wordpress']['plugin']['was']

wordpress_plugin 'was' do
  action :install
  plugin_name config['name']
  version config['version']
  source config['source']
end

{
  'azure_storage_account_name' => config['azure']['name'],
  'azure_storage_account_primary_access_key' => config['azure']['key'],
  'azure_storage_account_container_name' => config['azure']['container'],
  'azure_storage_use_for_default_upload' => config['default'] ? 1 : 0,
  'azure_storage_allow_per_user_settings' => config['azure']['per_user_settings'] ? 1 : 0,
  'cname' => config['azure']['cname'],
  'http_proxy_host' => config['proxy']['host'],
  'http_proxy_port' => config['proxy']['port'],
  'http_proxy_username' => config['proxy']['user'],
  'http_proxy_password' => config['proxy']['pass'],
}.each do |k, v|
  wordpress_option(k) { value v }
end

wordpress_plugin 'was' do
  action :activate
end
