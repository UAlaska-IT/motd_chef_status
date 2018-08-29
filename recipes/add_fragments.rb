# frozen_string_literal: true

tcb = 'motd_chef_status'

var_map = {
  FQDN: node['fqdn'],
  server_owner: node[tcb]['server_owner'],
  node_name_file: path_to_last_run_node_name,
  success_file: path_to_last_run_success_flag,
  maxium_delay: chef_client_max_delay_minutes,
  timestamp_file: path_to_last_run_time
}

if node[tcb]['add_header_fragment']
  motd_fragment "#{node[tcb]['header_position']}-header#{fragment_extension}" do
    template_cookbook tcb
    template_source 'motd-header.sh.erb'
    template_variables var_map
  end
end

if node[tcb]['add_chef_fragment']
  motd_fragment "#{node[tcb]['chef_status_position']}-chef-manage-status#{fragment_extension}" do
    template_cookbook tcb
    template_source 'motd-chef-manage-status.sh.erb'
    template_variables var_map
  end
end
