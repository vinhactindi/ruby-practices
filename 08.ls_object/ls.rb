#!/usr/bin/env ruby
# frozen_string_literal: true

require './entry_list'
require './app_option'

def entry_paths_of(dir, reverse: false, all: false)
  output = Dir.glob("#{dir}/*").sort
  output = Dir.glob("#{dir}/*", File::FNM_DOTMATCH).sort if all
  output.reverse! if reverse
  output
end

def printer(entries, view_as_list: false)
  if view_as_list
    puts entries.to_s_with_stats
  else
    puts entries.to_s_with_columns
  end
end

option = AppOption.new
paths = option.extras.empty? ? ['./'] : option.extras

paths.each do |path|
  unless File.exist?(path)
    puts "#{path}: No such file or directory"
    next
  end

  entry_paths = entry_paths_of(path, reverse: option.has?('r'), all: option.has?('a'))

  entries = EntryList.new(entry_paths)

  puts "#{path}:" if option.extras.length > 1

  printer(entries, view_as_list: option.has?('l'))

  puts if option.extras.length > 1
end
