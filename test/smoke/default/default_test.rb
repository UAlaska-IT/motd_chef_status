# frozen_string_literal: true

if node['platform_family'] == 'debian'
  fragment_dir = '/etc/update-motd.d/'
elsif node['platform_family'] == 'redhat'
  fragment_dir = '/etc/profile.d/'
else
  raise "Platform family not supported: #{node['platform_family']}"
end

describe file(fragment_dir + '00-header') do
  it {should exist}
end

describe file(fragment_dir + '95-chef-manage-status') do
  it {should exist}
end
