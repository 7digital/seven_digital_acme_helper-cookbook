
# Generate selfsigned certificate so nginx can start
acme_selfsigned 'test.example.com' do
  crt     '/etc/ssl/test.example.com.crt'
  key     '/etc/ssl/test.example.com.key'
end

include_recipe 'seven_digital_acme_helper_test::nginx'
