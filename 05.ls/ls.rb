#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'

SPACING = 24
OPTIONS = ARGV.getopts('a', 'r')

def entries_with_options_in(dir)
  entries = Dir.entries(dir).sort

  entries.reject! { |fname| fname.start_with?('.') } unless OPTIONS['a']

  entries.reverse! if OPTIONS['r']

  entries
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

entry_list_of ARGV
