name 'seven_digital_acme_helper_test'
maintainer 'The Authors'
maintainer_email 'you@example.com'
license 'All Rights Reserved'
description 'Installs/Configures seven_digital_acme_helper'
long_description 'Installs/Configures seven_digital_acme_helper'
version '0.1.0'
chef_version '>= 12.1' if respond_to?(:chef_version)

depends          'rabbitmq', '~> 5.0'
depends          'letsencrypt-boulder-server'
depends          'compat_resource', '>= 12.19'
depends          'acme'
depends          'nginx', '~> 8.1'

# The `issues_url` points to the location where issues for this cookbook are
# tracked.  A `View Issues` link will be displayed on this cookbook's page when
# uploaded to a Supermarket.
#
# issues_url 'https://github.com/<insert_org_here>/seven_digital_acme_helper/issues'

# The `source_url` points to the development repository for this cookbook.  A
# `View Source` link will be displayed on this cookbook's page when uploaded to
# a Supermarket.
#
# source_url 'https://github.com/<insert_org_here>/seven_digital_acme_helper'
