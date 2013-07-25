include_recipe "mysql::server"

::Chef::Recipe.send(:include, Opscode::OpenSSL::Password)
::Chef::Recipe.send(:include, Wordpress::GenDBPrefix)

class Chef::Resource::Execute
  def mysql_query(query)
    %<mysql.exe -u root -p"#{node['mysql']['server_root_password']}" -e "#{query}">
  end
end

node.set_unless['wordpress']['db']['pass'] = secure_password
node.set_unless['wordpress']['db']['prefix'] = random_wpdbprefix_string

db = node['wordpress']['db']
user = "'#{db['user']}'@'#{node['wordpress']['host']}'"
class Chef::Resource::Execute
  def mysql_query(query)
    %<mysql.exe -u root -p"#{node['mysql']['server_root_password']}" -e "#{query}">
  end
end

create_user = %<CREATE USER #{user} IDENTIFIED BY '#{db['pass']}';>
user_exists = %<SELECT 1 FROM mysql.user WHERE user = '#{db['user']}';>
grant_privileges = %<GRANT ALL PRIVILEGES ON #{db['name']}.* TO #{user};>
flush_privileges = %<FLUSH PRIVILEGES;>

execute "Create WordPress MySQL User" do
  action :run
  command mysql_query(create_user)
  only_if { `#{mysql_query(user_exists)}`.empty? }
end

execute "Grant WordPress MySQL Privileges" do
  action :run
  command mysql_query(grant_privileges)
end

execute "Flush MySQL Privileges" do
  action :run
  command mysql_query(flush_privileges)
end
