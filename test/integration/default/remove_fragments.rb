# frozen_string_literal: true

require_relative 'helpers'

describe file('/etc/motd') do
  it { should_not exist }
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
