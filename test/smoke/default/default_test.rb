# frozen_string_literal: true

if os[:family] == 'debian'
  fragment_dir = '/etc/update-motd.d/'
elsif os[:family] == 'redhat'
  fragment_dir = '/etc/profile.d/'
else
  raise "Platform family not supported: #{node['platform_family']}"
end

describe file(fragment_dir + '00-header') do
  it { should exist }
end

describe file(fragment_dir + '99-chef-manage-status') do
  it { should exist }
end
