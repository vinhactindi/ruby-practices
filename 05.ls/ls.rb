#!/usr/bin/env ruby
# frozen_string_literal: true

SPACING = 24
directories = ARGV

require 'optparse'

@options = ARGV.getopts('a')

def entries_with_options_in(dir)
  if @options['a']
    Dir.entries(dir).sort
  else
    Dir["#{dir}/*"].sort.map { |fname| fname[(dir.length + 1)..-1] }
  end
end

def entry_list_of(directories)
  if directories.empty?
    entries = Dir['*'].sort
    entries_printer entries
  else
    directories.each do |dir|
      unless File.exist?(dir)
        puts "#{dir}: No such file or directory"
        next
      end

      entries = entries_with_options_in(dir)

      puts "#{dir}:" if directories.length > 1
      entries_printer entries
      puts if directories.length > 1
    end
  end
end

def entries_printer(entries, columns = 3)
  culumn_height = (entries.length / columns.to_f).ceil
  (0..culumn_height - 1).each do |index|
    (0..columns).each { |n| print entries[index + n * culumn_height]&.ljust(SPACING) }
    puts
  end
end

entry_list_of directories
