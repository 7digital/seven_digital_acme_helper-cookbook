#
# Cookbook:: seven_digital_acme_helper
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.

cert_temp_location = node['seven_digital_acme_helper']['certificate_temp_location']

# Ensure the temp location exists
directory cert_temp_location

include_recipe 'acme'

node['seven_digital_acme_helper']['certificates'].each do |certificate|
  # Download the certificate from the databag (if it exists) to ensure that we're not
  #  unnecessarily requesting certificates if the files get cleaned out for whatever reason
  seven_digital_acme_helper_certificate_databag_download certificate['domain'] do
    data_bag_name      node['seven_digital_acme_helper']['data_bag_name']
    data_bag_secret    node['seven_digital_acme_helper']['data_bag_secret']
    fullchain          cert_temp_location + certificate['domain'] + '.crt'
    chain              cert_temp_location + certificate['domain'] + '-chain.crt'
    key                cert_temp_location + certificate['domain'] + '.pem'
  end

  # Request the Certificate
  acme_certificate certificate['domain'] do
    alt_names         certificate['alt_names']
    fullchain         cert_temp_location + certificate['domain'] + '.crt'
    chain             cert_temp_location + certificate['domain'] + '-chain.crt'
    key               cert_temp_location + certificate['domain'] + '.pem'
    wwwroot           node['seven_digital_acme_helper']['wwwroot']
    # This has been set because there is a bug in the acme cookbook (seemingly) which caused any certificate
    #  with a Subject Alternative Name (alt_name) to be renewed on every chef run and eventually fail due
    #  to exceeding the API rate limits of encrypt for a specific certificate
    ignore_failure    true
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
