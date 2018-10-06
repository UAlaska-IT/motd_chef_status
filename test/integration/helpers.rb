# frozen_string_literal: true

def every_added_fragment
  return ['00-header', '99-chef-manage-status']
end

def every_removed_fragment
  return [
    '10-uname', # Always
    '10-help-text', # Document
    '30-banner',
    '50-motd-news',
    '51-cloudguest'
    # Other fragments are status or update and kept by default
  ]
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

def root_group(node)
  return 'wheel' if node['platform_family'] == 'freebsd'
  return 'root'
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

def install_update_motd?(node)
  return working_update_motd?(node) && node['platform'] != 'debian'
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
