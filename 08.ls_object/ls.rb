#!/usr/bin/env ruby
# frozen_string_literal: true

require './entry_list'
require './app_option'

option = AppOption.new

option.dir do |entry_paths, dir_path|
  unless File.exist?(dir_path)
    puts "#{dir_path}: No such file or directory"
    next
  end

  entries = EntryList.new(entry_paths)

  puts "#{dir_path}:" if option.extras.length > 1
  if option.has?('l')
    puts entries.to_s_with_stats
  else
    puts entries.to_s_with_columns
  end
  puts if option.extras.length > 1
end
