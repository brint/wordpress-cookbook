source "https://supermarket.chef.io"

metadata

cookbook 'php', '>= 4.5.0'
cookbook 'apache2', '>= 3.2.2', git: 'https://github.com/sous-chefs/apache2.git'
cookbook 'nginx', '= 8.1.6', git: 'https://github.com/sous-chefs/nginx.git', tag: "v8.1.6"

group :integration do
  cookbook 'apt', '~> 2.6.1'
end
