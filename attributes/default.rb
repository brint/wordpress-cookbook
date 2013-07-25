#
# Author:: Barry Steinglass (<barry@opscode.com>)
# Cookbook Name:: wordpress
# Attributes:: wordpress
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

# General settings
default['wordpress']['version'] = "latest"
default['wordpress']['host'] = "localhost"

default['wordpress']['db']['name'] = "wordpressdb"
default['wordpress']['db']['user'] = "wordpressuser"
default['wordpress']['db']['host'] = "localhost"

default['wordpress']['blog']['title'] = "My Blog"
default['wordpress']['blog']['admin_name'] = "admin"
default['wordpress']['blog']['admin_password'] = "pass"
default['wordpress']['blog']['admin_email'] = "admin@localhost"
default['wordpress']['blog']['url'] = "localhost"


if platform? 'windows'
  default['wordpress']['bin'] = 'wp.bat'
  default['wordpress']['dir'] = 'C:/wordpress'
  default['mysql']['pid_file'] = 'C:/Program Files' # Hack around a bug in the mysql cookbook
  default['mysql']['confd_dir'] = 'C:/' # Hack around a bug in the mysql cookbook
else
  default['wordpress']['bin'] = 'wp'
  default['wordpress']['dir'] = '/var/www/wordpress'
end
