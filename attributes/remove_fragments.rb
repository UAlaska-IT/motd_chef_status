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
  '80-livepatch', # Ubuntu livepatch plug
]

# Status-related fragments
default[tcb]['remove_status_fragments'] = false

default[tcb]['status_fragments'] = [
  '50-landscape-sysinfo', # Ubuntu 18, 14 landscape info
  '97-overlayroot', # Ubuntu 18, 16 ???
  '98-fsck-at-reboot', # Ubuntu 18, 16, 14 disk check
]

# Update-related fragments
default[tcb]['remove_update_fragments'] = false

default[tcb]['update_fragments'] = [
  '70-available-updates', # Amazon update check
  '75-system-update', # Amazon updates
  '80-esm', # Ubuntu 18 extended support status
  '80-livepatch', # Ubuntu 18 livepatch install status
  '90-updates-available', # Ubuntu 16, 14 update check
  '91-release-upgrade', # Ubuntu 18, 16, 14 release upgrade check
  '95-hwe-eol', # Ubuntu 18, 14 end of life check?
  '98-reboot-required', # Ubuntu 18, 16, 14 reboot check
]
