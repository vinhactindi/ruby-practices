#!/usr/bin/env ruby
# frozen_string_literal: true

SPACING = 24
directories = ARGV

def entry_list_of(directories)
  if directories.empty?
    entries = Dir['*'].sort
    entries_printer entries
  else
    directories.each do |dir|
      entries = Dir["#{dir}/*"].sort.map { |fname| fname[(dir.length + 1)..-1] }

      puts "#{dir}:" if directories.length > 1
      entries_printer entries
      puts if directories.length > 1
    end
  end
end

def entries_printer(entries, columns = 3)
  entries.each_slice(columns) do |entry_line|
    entry_line.each { |entry| print entry.ljust(SPACING) }
    puts
  end
end

entry_list_of directories
