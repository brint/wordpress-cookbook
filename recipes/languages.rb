#
# Cookbook Name:: wordpress
# Recipe:: languages
# Author:: Koseki Kengo <koseki@gmail.com>
#
# Copyright 2013, Opscode, Inc.
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

include_recipe "wordpress"

projects = {
  'main'          => {:src => '/',               :dst => ''},
  'admin'         => {:src => '/admin/',         :dst => 'admin'},
  'admin/network' => {:src => '/admin/network/', :dst => 'admin-network'},
  'cc'            => {:src => '/cc/',            :dst => 'continents-cities'},
}

directory "#{node['wordpress']['dir']}/wp-content/languages" do
  owner "root"
  group "root"
  mode "0755"
  action :create
  recursive true
end

unless node['wordpress']['languages']['lang'].to_s.empty? &&
       node['wordpress']['languages']['version'].to_s.empty?
  node['wordpress']['languages']['projects'].to_a.each do |project|
    next unless projects[project]

    # http://translate.wordpress.org/projects/wp/3.5.x/admin/network/ja/default/export-translations?format=mo
    src = "#{node['wordpress']['languages']['repourl']}/#{node['wordpress']['languages']['version']}#{projects[project][:src]}#{node['wordpress']['languages']['lang']}/default/export-translations?format=mo"

    dst = "#{node['wordpress']['dir']}/wp-content/languages/"
    dst += "#{projects[project][:dst]}-" unless projects[project][:dst].empty?
    dst += "#{node['wordpress']['languages']['lang']}.mo"

    remote_file dst do
      source src
      owner "root"
      group "root"
      mode "0644"
      action :create_if_missing
    end
  end
end
