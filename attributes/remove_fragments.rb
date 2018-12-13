# frozen_string_literal: true

tcb = 'motd_chef_status'

# Remove any existing fragments, if false attributes below have no effect
default[tcb]['remove_existing_fragments'] = true

# Documentation-related fragments
default[tcb]['remove_document_fragments'] = true

default[tcb]['document_fragments'] = [
  '10-help-text', # Ubuntu 18, 16, 14 desktop help
  '30-banner', # Amazon banner
  '50-motd-news', # Ubuntu 18 dynamic news
  '51-cloudguest', # Ubuntu cloud help
  '80-livepatch' # Ubuntu livepatch plug
]

# Status-related fragments
default[tcb]['remove_status_fragments'] = false

# Update-related fragments
default[tcb]['remove_update_fragments'] = false
