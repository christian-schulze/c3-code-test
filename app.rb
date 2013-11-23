#!/usr/bin/env ruby

require_relative 'lib/c3_code_test'

c3 = C3CodeTest.new

ARGV.each do |file_path|
  puts "Processing '#{file_path}':"

  messages = c3.process_file(file_path)
  messages.each { |message| puts message }

  puts "Completed."
end
