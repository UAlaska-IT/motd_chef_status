# frozen_string_literal: true

tcb = 'motd_chef_status'

if platform_supports_dynamic_motd? # If we do nothing or emulate, do not blow this away
  # Still exists on Debian, will print on Ubuntu if it exists
  file '/etc/motd' do
    action :delete
  end
end

unless node[tcb]['add_header_fragment'] && node[tcb]['header_position'] == '00'
  # Ubuntu 18, 16, 14 header; we will add our own fragment, so don't blow our own away!
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
  [
    '10-help-text', # Ubuntu 18, 16, 14 desktop help
    '50-motd-news', # Ubuntu 18 dynamic news
    '51-cloudguest' # Ubuntu cloud help
  ].each do |fragment|
    motd_fragment fragment do
      action :delete
      template_cookbook ''
      template_source ''
    end
  end
end

if node[tcb]['remove_status_fragments']
  [
    '50-landscape-sysinfo', # Ubuntu 18, 14 landscape info
    '97-overlayroot', # Ubuntu 18, 16 ???
    '98-fsck-at-reboot' # Ubuntu 18, 16, 14 disk check
  ].each do |fragment|
    motd_fragment fragment do
      action :delete
      template_cookbook ''
      template_source ''
    end
  end
end

if node[tcb]['remove_update_fragments']
  [
    '80-esm', # Ubuntu 18 extended support status
    '80-livepatch', # Ubuntu 18 livepatch install status
    '90-updates-available', # Ubuntu 16, 14 update check
    '91-release-upgrade', # Ubuntu 18, 16, 14 release upgrade check
    '95-hwe-eol', # Ubuntu 18, 14 end of life check?
    '98-reboot-required' # Ubuntu 18, 16, 14 reboot check
  ].each do |fragment|
    motd_fragment fragment do
      action :delete
      template_cookbook ''
      template_source ''
    end
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
