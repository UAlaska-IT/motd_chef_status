# frozen_string_literal: true

name 'motd_chef_status'
maintainer 'OIT Systems Engineering'
maintainer_email 'ua-oit-se@alaska.edu'
license 'MIT'
description 'Configures MOTD to display system and Chef information'

git_url = 'https://github.com/ualaska-it/motd_chef_status'
source_url git_url
issues_url "#{git_url}/issues"

version '1.0.4'

supports 'ubuntu', '>= 14.0'
supports 'debian', '>= 8.0'
supports 'redhat', '>= 6.0'
supports 'centos', '>= 6.0'
supports 'oracle', '>= 6.0'
# supports 'fedora'
supports 'amazon'
supports 'suse'
# supports 'opensuse'
# supports 'windows', '>= 6.3' # Windows 2012R2, see https://en.wikipedia.org/wiki/List_of_Microsoft_Windows_versions

chef_version '>= 14.0'

depends 'chef_run_recorder'
