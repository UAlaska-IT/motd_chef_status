# frozen_string_literal: true

name 'motd_chef_status'
maintainer 'OIT Systems Engineering'
maintainer_email 'ua-oit-se@alaska.edu'
license 'MIT'
description 'Configures MOTD to display system and Chef information'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))

git_url = 'https://github.com/ualaska-it/motd_chef_status'
source_url git_url if respond_to?(:source_url)
issues_url "#{git_url}/issues" if respond_to?(:issues_url)

version '0.2.3'

supports 'ubuntu', '>= 14.0'
supports 'debian', '>= 8.0'
supports 'redhat', '>= 6.0'
supports 'centos', '>= 6.0'
supports 'oracle', '>= 6.0'
supports 'fedora'
supports 'amazon'
# supports 'suse'
# supports 'opensuse'
# supports 'freebsd', '>= 10.0'

chef_version '>= 14.0' if respond_to?(:chef_version)

depends 'chef_run_recorder'
