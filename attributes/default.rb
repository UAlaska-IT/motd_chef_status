# frozen_string_literal: true

tcb = 'motd_chef_status'

default[tcb]['add_header_fragment'] = true
default[tcb]['add_chef_fragment'] = true

default[tcb]['header_position'] = '00'
default[tcb]['chef_status_position'] = '99'

# Remove any existing fragments, if false attributes below have no effect
default[tcb]['remove_existing_fragments'] = true

# Documentation-related fragments
default[tcb]['remove_document_fragments'] = true

# Update-related fragments
default[tcb]['remove_update_fragments'] = false
