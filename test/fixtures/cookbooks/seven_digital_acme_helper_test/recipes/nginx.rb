yum_package 'openssl' do
  action :upgrade
  only_if { platform_family?('rhel') }
end

# Install a webserver
include_recipe 'nginx'

nginx_site 'test' do
  template 'nginx-test.conf'

  notifies :reload, 'service[nginx]', :immediately
end

directory node['nginx']['default_root'] do
  owner 'root'
  group 'root'
  recursive true
end

cookbook_file "#{node['nginx']['default_root']}/index.html" do
  source 'index.html'
end
