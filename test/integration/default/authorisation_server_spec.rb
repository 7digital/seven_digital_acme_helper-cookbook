# Inspec for recipe seven_digital_acme_helper::authorisation_server

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

describe file('/tmp/seven_digital_acme_helper/example.com.crt') do
  it { should exist }
  its('content') { should match %(-----BEGIN CERTIFICATE-----) }
end

describe file('/tmp/seven_digital_acme_helper/example.com-chain.crt') do
  it { should exist }
  its('content') { should match %(-----BEGIN CERTIFICATE-----) }
end

describe file('/tmp/seven_digital_acme_helper/example.com.pem') do
  it { should exist }
  its('content') { should match %(-----BEGIN RSA PRIVATE KEY-----) }
end
