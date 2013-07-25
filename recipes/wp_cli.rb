include_recipe "php"
include_recipe "php::composer"
include_recipe "curl"

dir = node['php']['composer']['dir']
bin = node['php']['composer']['bin']

execute "Install wp-cli" do
  action :run
  cwd dir
  command "#{bin} require --prefer-source wp-cli/wp-cli=@dev"
end
