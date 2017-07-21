source "https://supermarket.chef.io"

metadata

cookbook 'php', '>= 4.5.0'
cookbook 'apache2', '>= 3.2.2', git: 'https://github.com/sous-chefs/apache2.git'

group :integration do
  cookbook 'apt', '~> 2.6.1'
end
