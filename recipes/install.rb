# frozen_string_literal: true

tcb = 'motd_chef_status'

include_recipe 'chef_run_recorder::default'

# We use update-motd (/etc/update-motd.d) if available, otherwise profile.d
package 'update-motd' do
  only_if { node['platform_family'] == 'debian' }
end


