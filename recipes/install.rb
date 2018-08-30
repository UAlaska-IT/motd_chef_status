# frozen_string_literal: true

include_recipe 'chef_run_recorder::default'

# We use update-motd (/etc/update-motd.d) if available, otherwise profile.d

package 'update-motd' if install_update_motd?
