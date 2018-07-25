default['seven_digital_acme_helper']['data_bag_name'] = ''

default['seven_digital_acme_helper']['certificates'] = [
  {
    'domain' => 'example.com',
    'alt_names' => ['web.example.com', 'mail.example.com'],
    'fullchain' => '/etc/ssl/test.example.com.crt',
    'chain' => '/etc/ssl/test.example.com-chain.crt',
    'key' => '/etc/ssl/test.example.com.key'
  }
]

default['seven_digital_acme_helper']['data_bag_secret'] = Chef::Config[:encrypted_data_bag_secret]

default['seven_digital_acme_helper']['wwroot'] = '/var/www/nginx-default'
