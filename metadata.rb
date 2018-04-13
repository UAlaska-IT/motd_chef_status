# frozen_string_literal: true

name 'motd_chef_status'
maintainer 'OIT Systems Engineering'
maintainer_email 'ua-oit-se@alaska.edu'
license 'MIT'
description 'Configures MOTD to display system and Chef information'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
issues_url 'https://github.alaska.edu/oit-cookbooks/motd_chef_status/issues' if respond_to?(:issues_url)
source_url 'https://github.alaska.edu/oit-cookbooks/motd_chef_status' if respond_to?(:source_url)

version '0.1.0'

['amazon', 'centos', 'debian', 'fedora', 'oracle', 'redhat', 'scientific', 'ubuntu'].each do |os|
  supports os
end

chef_version '>= 13.0.0' if respond_to?(:chef_version)

depends 'chef_run_recorder', '>= 0.1.0'
