# frozen_string_literal: true

module MOTDChefStatus
  # Some time calculations
  module Helper
    TCB = 'motd_chef_status'

    def working_update_motd?
      return node['platform_family'] == 'debian' && node['platform_version'] !~ /^[7-8]/
    end

    def broken_debian?
      return node['platform_family'] == 'debian' && node['platform_version'] =~ /^[7-8]/
    end

    def profile_fallback?
      return (['rhel', 'fedora', 'amazon', 'suse'].include? node['platform_family']) || broken_debian?
    end

    def install_update_motd?
      return working_update_motd? && node['platform'] != 'debian'
    end

    def platform_supports_dynamic_motd?
      return working_update_motd? || profile_fallback?
    end

    def fragment_directory
      return '/etc/update-motd.d/' if working_update_motd?

      return '/etc/profile.d/' if profile_fallback?

      raise "Platform family not supported: #{node['platform_family']}"
    end

    def every_fragment_directory
      return ['/etc/update-motd.d/', '/etc/profile.d/']
    end

    def fragment_extension
      return '' if working_update_motd?

      return '.sh' if profile_fallback?

      raise "Platform family not supported: #{node['platform_family']}"
    end

    def chef_client_interval_s
      return Integer(Chef::Config[:interval]) if Chef::Config[:interval]

      return Integer(node['chef_client']['interval']) if node.attribute?('chef_client')

      return 1800 # The default is 30 minutes
    end

    def chef_client_splay_s
      return Integer(Chef::Config[:splay]) if Chef::Config[:splay]

      return Integer(node['chef_client']['splay']) if node.attribute?('chef_client')

      return 300 # The default is 5 minutes
    end

    def chef_client_interval_minutes
      return chef_client_interval_s / 60
    end

    def chef_client_splay_minutes
      return chef_client_splay_s / 60
    end

    def chef_client_max_delay_minutes
      return (chef_client_interval_s + chef_client_splay_s) / 60
    end
  end
end

Chef::DSL::Recipe.include(MOTDChefStatus::Helper)
Chef::Resource.include(MOTDChefStatus::Helper)
