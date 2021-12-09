#!/usr/bin/env ruby
# frozen_string_literal: true

require './entry_list'
require './app_option'

option = AppOption.new
paths = option.extras.empty? ? ['./'] : option.extras

paths.each do |path|
  unless File.exist?(path)
    puts "#{path}: No such file or directory"
    next
  end

  entry_paths = Dir.glob("#{path}/*").sort
  entry_paths = Dir.glob("#{path}/*", File::FNM_DOTMATCH).sort if option.has?('a')
  entry_paths.reverse! if option.has?('r')

  entries = EntryList.new(entry_paths)

  puts "#{path}:" if option.extras.length > 1
  if option.has?('l')
    puts entries.to_s_with_stats
  else
    puts entries.to_s_with_columns
  end
  puts if option.extras.length > 1
end
