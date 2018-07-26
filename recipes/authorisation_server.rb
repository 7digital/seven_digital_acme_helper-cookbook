#
# Cookbook:: seven_digital_acme_helper
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.

node['seven_digital_acme_helper']['certificates'].each do |certificate|
  # Request the Certificate
  acme_certificate certificate['domain'] do
    alt_names         certificate['alt_names']
    fullchain         certificate['fullchain']
    chain             certificate['chain']
    key               certificate['key']
    wwwroot           node['seven_digital_acme_helper']['wwwroot']
  end

  # Upload the certificate
  seven_digital_acme_helper_certificate_databag_upload certificate['domain'] do
    data_bag_name node['seven_digital_acme_helper']['data_bag_name']
    data_bag_secret node['seven_digital_acme_helper']['secret']
    key certificate['key']
    fullchain  certificate['fullchain']
    chain certificate['key']
  end
end
