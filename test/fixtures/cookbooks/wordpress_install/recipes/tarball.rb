wordpress_install 'default' do
  action :create
end

case node['platform_family']
when 'rhel'
  wp_owner = 'adm'
  wp_group = 'adm'
when 'debian'
  wp_owner = 'www-data'
  wp_group = 'www-data'
end

wordpress_install 'example2.com' do
  install_method 'tarball'
  install_path '/var/www/example2.com'
  version '3.9.3'
  owner wp_owner
  group wp_group
  action :create
end
