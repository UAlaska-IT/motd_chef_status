# frozen_string_literal: true

require_relative '../helpers'

node = json(path_to_node_record)['automatic']

every_added_fragment.each do |frag|
  path_to_fragment = fragment_directory(node) + frag + fragment_extension(node)
  describe file(path_to_fragment) do
    it { should exist }
    it { should be_file }
    it { should be_mode 0o755 }
    it { should be_owned_by 'root' }
    it { should be_grouped_into root_group(node) }
  end

  describe bash(path_to_fragment) do
    its(:exit_status) { should eq 0 }
    its(:stderr) { should eq '' }
  end
end
