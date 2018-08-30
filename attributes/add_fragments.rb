# frozen_string_literal: true

tcb = 'motd_chef_status'

default[tcb]['add_header_fragment'] = true
default[tcb]['add_chef_fragment'] = true

default[tcb]['header_position'] = '00'
default[tcb]['chef_status_position'] = '99'

default[tcb]['server_owner'] = ''
