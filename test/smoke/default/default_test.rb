# frozen_string_literal: true

require_relative 'helpers'

node = json(path_to_node_record)['automatic']

describe file('/etc/motd') do
  it { should_not exist }
end

every_added_fragment.each do |frag|
  path_to_fragment = fragment_directory(node) + frag + fragment_extension(node)
  describe file(path_to_fragment) do
    it { should exist }
    it { should be_file }
    it { should be_mode 0o755 }
    it { should be_owned_by 'root' }
    it { should be_grouped_into root_group(node) }
  end
end

every_fragment_directory.each do |dir|
  every_removed_fragment.each do |frag|
    every_fragment_extension.each do |ext|
      describe file(dir + frag + ext) do
        it { should_not exist }
      end
    end
  end
end
