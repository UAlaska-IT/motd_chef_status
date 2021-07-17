# frozen_string_literal: true

require 'open3'

def tag
  data = File.read('CHANGELOG.md').split('##')[1].split("\n").collect(&:strip).reject { |line| line == '' }
  cmd = "git tag -a v#{data[0]} -m '#{data[1..].join('\n')}'"
  stdout, stderr, = Open3.capture3(cmd)
  puts("#{stdout}#{stderr}")
end
