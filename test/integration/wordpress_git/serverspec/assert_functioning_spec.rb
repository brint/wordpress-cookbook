require 'serverspec'

set :backend, :exec

if ['debian', 'ubuntu'].include?(os[:family])
  alt_owner = 'www-data'
  alt_group = 'www-data'
elsif ['redhat', 'centos', 'amazon', 'scientific'].include?(os[:family])
  alt_owner = 'adm'
  alt_group = 'adm'
end

# Test first use of LWRP
describe file('/var/www/wordpress') do
  it { should be_directory }
  it { should be_mode 755 }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
end

describe file('/var/www/wordpress/.git') do
  it { should be_directory }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
end

describe file('/var/www/wordpress/index.php') do
  it { should be_file }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
end

# Test second use of LWRP
describe file('/var/www/example2.com') do
  it { should be_directory }
  it { should be_mode 755 }
  it { should be_owned_by alt_owner }
  it { should be_grouped_into alt_group }
end

describe file('/var/www/example2.com/.git') do
  it { should be_directory }
  it { should be_owned_by alt_owner }
  it { should be_grouped_into alt_group }
end

describe file('/var/www/example2.com/index.php') do
  it { should be_file }
  it { should be_owned_by alt_owner }
  it { should be_grouped_into alt_group }
end

describe file('/var/www/example2.com/wp-includes/version.php') do
  it { should be_file }
  it { should be_owned_by alt_owner }
  it { should be_grouped_into alt_group }
  it { should contain('3.9.3') }
end
