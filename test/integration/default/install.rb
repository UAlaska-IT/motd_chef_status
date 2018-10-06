# frozen_string_literal: true

require_relative '../helpers'

node = json(path_to_node_record)['automatic']

if install_update_motd?(node)
  describe package('update-motd') do
    it { should be_installed }
  end
end
