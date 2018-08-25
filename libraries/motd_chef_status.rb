# frozen_string_literal: true

module MOTDChefStatus
  # Some time calculations
  module Helper
    TCB = 'motd_chef_status'

    def fragment_directory
      return '/etc/update-motd.d/' if node['platform_family'] == 'debian'
      return '/etc/profile.d/' if ['rhel', 'fedora'].include? node['platform_family']
      raise "Platform family not supported: #{node['platform_family']}"
    end

    def fragment_extension
      return '' if node['platform_family'] == 'debian'
      return '.sh' if ['rhel', 'fedora'].include? node['platform_family']
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

Chef::Provider.include(ChefRunRecorder::Helper)
Chef::Recipe.include(ChefRunRecorder::Helper)
Chef::Resource.include(ChefRunRecorder::Helper)
