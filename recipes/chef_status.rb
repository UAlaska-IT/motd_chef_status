# frozen_string_literal: true

tcb = 'motd_chef_status'

var_map = {
    host_name: node['hostname'],
    node_name_file: path_to_last_run_node_name,
    success_file: path_to_last_run_success_flag,
    maxium_delay: chef_client_max_delay_minutes,
    timestamp_file: path_to_last_run_time
}

# Ubuntu desktop help
motd_fragment '10-help-text' do
  action :delete
  template_cookbook ''
  template_source ''
  template_variables {}
end

# Ubuntu cloud help
motd_fragment '51-cloudguest' do
  action :delete
  template_cookbook ''
  template_source ''
  template_variables {}
end

motd_fragment "#{node[tcb]['header_position']}-header" do
  template_cookbook tcb
  template_source 'motd-header.sh.erb'
  template_variables var_map
end

motd_fragment "#{node[tcb]['header_position']}-chef-manage-status" do
  template_cookbook tcb
  template_source 'motd-chef-manage-status.sh.erb'
  template_variables var_map
end
