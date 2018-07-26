#
# Cookbook:: seven_digital_acme_helper
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.

node['seven_digital_acme_helper']['certificates'].each do |certificate|
  # Upload the certificate
  seven_digital_acme_helper_certificate_databag_download certificate['domain'] do
    data_bag_name node['seven_digital_acme_helper']['data_bag_name']
    data_bag_secret node['seven_digital_acme_helper']['data_bag_secret']
    key certificate['key']
    fullchain certificate['fullchain']
    chain certificate['chain']
  end
end
