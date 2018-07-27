#
# Cookbook:: seven_digital_acme_helper
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.

cert_temp_location = node['seven_digital_acme_helper']['certificate_temp_location']
directory cert_temp_location

include_recipe 'acme'

node['seven_digital_acme_helper']['certificates'].each do |certificate|
  # Request the Certificate
  acme_certificate certificate['domain'] do
    alt_names         certificate['alt_names']
    fullchain         cert_temp_location + certificate['domain'] + '.crt'
    chain             cert_temp_location + certificate['domain'] + '-chain.crt'
    key               cert_temp_location + certificate['domain'] + '.pem'
    wwwroot           node['seven_digital_acme_helper']['wwwroot']
  end

  # Upload the certificate
  seven_digital_acme_helper_certificate_databag_upload certificate['domain'] do
    data_bag_name      node['seven_digital_acme_helper']['data_bag_name']
    data_bag_secret    node['seven_digital_acme_helper']['data_bag_secret']
    fullchain          cert_temp_location + certificate['domain'] + '.crt'
    chain              cert_temp_location + certificate['domain'] + '-chain.crt'
    key                cert_temp_location + certificate['domain'] + '.pem'
  end
end
