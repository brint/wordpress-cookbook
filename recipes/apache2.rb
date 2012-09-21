include_recipe "apache2"
include_recipe "apache2::mod_php5"

apache_site "000-default" do
  enable false
end

web_app "wordpress" do
  template "wordpress.conf.erb"
  docroot "#{node['wordpress']['dir']}"
  server_name server_fqdn
  server_aliases node['wordpress']['server_aliases']
end
