# frozen_string_literal: true

require 'json'

def every_added_fragment
  return ['00-header', '99-chef-manage-status']
end

def every_removed_fragment
  return ['10-uname', '10-help-text', '30-banner', '50-motd-news', '51-cloudguest']
end

def every_fragment_directory
  return ['/etc/update-motd.d/', '/etc/profile.d/']
end

def every_fragment_extension
  return ['', '.sh']
end

def path_to_node_record
  return '/opt/chef/run_record/last_chef_run_node.json'
end

def working_update_motd?(node)
  return node['platform_family'] == 'debian' && node['platform_version'] !~ /^[7-8]/
end

def broken_debian?(node)
  return node['platform_family'] == 'debian' && node['platform_version'] =~ /^[7-8]/
end

def profile_fallback?(node)
  return (['rhel', 'fedora', 'amazon', 'suse'].include? node['platform_family']) || broken_debian?(node)
end

def fragment_directory(node)
  return '/etc/update-motd.d/' if working_update_motd?(node)
  return '/etc/profile.d/' if profile_fallback?(node)
  raise "Platform family not supported (directory): #{node['platform_family']}"
end

def fragment_extension(node)
  return '' if working_update_motd?(node)
  return '.sh' if profile_fallback?(node)
  puts("PLATFORM = #{node['platform_family']}")
  # raise "Platform family not supported (extension): #{node['platform_family']}"
  return 'NOT FOUND'
end

RSpec.shared_context 'helpers' do
  def root_group(node)
    return 'wheel' if node['platform_family'] == 'freebsd'
    return 'root'
  end
end

describe file('/etc/motd') do
  it { should_not exist }
end

node = json(path_to_node_record)['automatic']

every_added_fragment.each do |frag|
  path_to_fragment = fragment_directory(node) + frag + fragment_extension(node)
  describe file(path_to_fragment) do
    include_context 'helpers'

    it { should exist }
    it { should be_file }
    it { should be_mode 0o755 }
    it { should be_owned_by 'root' }
    it { should be_grouped_into root_group(node) }
  end
end

every_fragment_directory.each do |dir|
  every_removed_fragment.each do |frag|
    every_fragment_extension.each do |ext|
      describe file(dir + frag + ext) do
        it { should_not exist }
      end
    end
  end
end
