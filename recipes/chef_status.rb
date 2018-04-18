# frozen_string_literal: true

tcb = 'motd_chef_status'

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
