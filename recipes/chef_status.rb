# frozen_string_literal: true

tcb = 'motd_chef_status'

if node[tcb]['remove_existing_fragments']
  # Still exists on Debian, will print on Ubuntu if it exists
  file '/etc/motd' do
    action :delete
  end

  unless node[tcb]['add_header_fragment'] && node[tcb]['header_position'] == '00'
    # Ubuntu header; we will add our own fragment, so don't blow our own away!
    motd_fragment '00-header' do
      action :delete
      template_cookbook ''
      template_source ''
    end
  end

  # Debian host info
  motd_fragment '10-uname' do
    action :delete
    template_cookbook ''
    template_source ''
  end

  if node[tcb]['remove_document_fragments']
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

    # Ubuntu dynamic news
    motd_fragment '50-motd-news' do
      action :delete
      template_cookbook ''
      template_source ''
    end
  end

  if node[tcb]['remove_status_fragments']
    # Landscape info
    motd_fragment '50-landscape-sysinfo' do
      action :delete
      template_cookbook ''
      template_source ''
    end
  end

  if node[tcb]['remove_update_fragments']
  end
end

var_map = {
  host_name: node['hostname'],
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
