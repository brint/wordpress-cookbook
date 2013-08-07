include_recipe "mysql::client"

::Chef::Recipe.send(:include, Opscode::OpenSSL::Password)
::Chef::Recipe.send(:include, Wordpress::Helpers)

node.set_unless['wordpress']['db']['pass'] = secure_password
node.set_unless['wordpress']['db']['prefix'] = random_wpdbprefix_string
node.save

db = node['wordpress']['db']
if is_local_host? db['host']
  include_recipe "mysql::server"
  
  class Chef::Resource::Execute
    def mysql_query(query)
      bin = (platform? 'windows') ? 'mysql.exe' : 'mysql'
      %<#{bin} --user=root --password="#{node['mysql']['server_root_password']}" --execute="#{query}">
    end
  end

  user = "'#{db['user']}'@'#{node['wordpress']['host']}'"
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
end
