include_recipe 'acme'

# Generate selfsigned certificate so nginx can start
acme_selfsigned 'test.example.com' do
  crt     '/etc/ssl/test.example.com.crt'
  key     '/etc/ssl/test.example.com.key'
end

include_recipe 'seven_digital_acme_helper_test::nginx'

# Request the real certificate
acme_certificate 'test.example.com' do
  alt_names         ['web.example.com', 'mail.example.com']
  fullchain         '/etc/ssl/test.example.com.crt'
  chain             '/etc/ssl/test.example.com-chain.crt'
  key               '/etc/ssl/test.example.com.key'
  wwwroot           node['nginx']['default_root']
  notifies          :reload, 'service[nginx]'
end

acme_certificate 'new.example.com' do
  crt               '/etc/ssl/new.example.com.crt'
  chain             '/etc/ssl/new.example.com-chain.crt'
  key               '/etc/ssl/new.example.com.key'
  wwwroot           node['nginx']['default_root']
end

acme_certificate '4096.example.com' do
  crt               '/etc/ssl/4096.example.com.crt'
  chain             '/etc/ssl/4096.example.com-chain.crt'
  key               '/etc/ssl/4096.example.com.key'
  key_size          4096
  wwwroot           node['nginx']['default_root']
end

acme_certificate 'web.example.com' do
  fullchain         '/etc/ssl/web.example.com.crt'
  chain             '/etc/ssl/web.example.com-chain.crt'
  key               '/etc/ssl/web.example.com.key'
  wwwroot           node['nginx']['default_root']
  notifies          :reload, 'service[nginx]'
end

acme_certificate 'web.example.com' do
  alt_names         ['mail.example.com']
  fullchain         '/etc/ssl/web.example.com.crt'
  chain             '/etc/ssl/web.example.com-chain.crt'
  key               '/etc/ssl/web.example.com.key'
  wwwroot           node['nginx']['default_root']
  notifies          :reload, 'service[nginx]'
end