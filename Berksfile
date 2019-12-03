source "https://supermarket.chef.io"

metadata

cookbook 'php', '>= 4.5.0'
cookbook 'apache2', '>= 3.2.2', git: 'https://github.com/sous-chefs/apache2.git'
cookbook 'nginx', '= 8.1.6', git: 'https://github.com/sous-chefs/nginx.git', tag: "v8.1.6"

cookbook 'database', git: 'https://github.com/alejandrod/database.git'
cookbook 'mysql', git: 'https://github.com/alejandrod/mysql.git'
cookbook 'mysql2_chef_gem', '>= 2.1.0', git: 'https://github.com/alejandrod/mysql2_chef_gem.git'

group :integration do
  cookbook 'apt', '~> 2.6.1'
end
