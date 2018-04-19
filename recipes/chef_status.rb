# frozen_string_literal: true

tcb = 'motd_chef_status'

var_map = {
  host_name: node['hostname'],
  node_name_file: path_to_last_run_node_name,
  success_file: path_to_last_run_success_flag,
  maxium_delay: chef_client_max_delay_minutes,
  timestamp_file: path_to_last_run_time
}

# Still exists on Debian, will print on Ubuntu if exist
file '/etc/motd' do
  action :delete
end

# Ubuntu desktop help
motd_fragment '10-help-text' do
  action :delete
  template_cookbook ''
  template_source ''
end

# Ubuntu cloud help
motd_fragment '51-cloudguest' do
  action :delete
  template_cookbook ''
  template_source ''
end

# Debian host info
motd_fragment '10-uname' do
  action :delete
  template_cookbook ''
  template_source ''
end

motd_fragment "#{node[tcb]['header_position']}-header#{fragment_extension}" do
  template_cookbook tcb
  template_source 'motd-header.sh.erb'
  template_variables var_map
end

motd_fragment "#{node[tcb]['chef_status_position']}-chef-manage-status#{fragment_extension}" do
  template_cookbook tcb
  template_source 'motd-chef-manage-status.sh.erb'
  template_variables var_map
end
