# frozen_string_literal: true

tcb = 'motd_chef_status'

include_recipe "#{tcb}::install"

include_recipe "#{tcb}::remove_fragments" if node[tcb]['remove_existing_fragments']

include_recipe "#{tcb}::add_fragments"
