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

# Amazon is weird because changes to /etc/update-motd/ or /etc/profile.d/ kill the dynamic motd
if node[tcb]['remove_document_fragments']
  node[tcb]['document_fragments'].each do |fragment|
    motd_fragment fragment do
      action :delete
      template_cookbook ''
      template_source ''
    end
  end
end

if node[tcb]['remove_status_fragments']
  node[tcb]['status_fragments'].each do |fragment|
    motd_fragment fragment do
      action :delete
      template_cookbook ''
      template_source ''
    end
  end
end

if node[tcb]['remove_update_fragments']
  node[tcb]['update_fragments'].each do |fragment|
    motd_fragment fragment do
      action :delete
      template_cookbook ''
      template_source ''
    end
  end
end
