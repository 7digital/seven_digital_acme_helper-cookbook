include_recipe 'letsencrypt-boulder-server'

file 'hosts' do
  path '/etc/hosts'
  atomic_update false
  content "127.0.0.1\tlocalhost boulder boulder-rabbitmq boulder-mysql test.example.com new.example.com web.example.com mail.example.com"
end