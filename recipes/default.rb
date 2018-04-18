# frozen_string_literal: true

tcb = 'motd_chef_status'

include_recipe "#{tcb}::install"
include_recipe "#{tcb}::chef_status"
