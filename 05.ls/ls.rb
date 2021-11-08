#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'
require 'etc'
require 'date'

SPACING = 24

PERMISSIONS = { 0 => '---',
                1 => '--x',
                2 => '-w-',
                3 => '-wx',
                4 => 'r--',
                5 => 'r-x',
                6 => 'rw-',
                7 => 'rwx' }.freeze

FTYPE = { 'file' => '-',
          'directory' => 'd',
          'characterSpecial' => 'c',
          'blockSpecial' => 'b',
          'fifo' => 'p',
          'link' => 'l',
          'socket' => 's' }.freeze

OPTIONS = ARGV.getopts('a', 'r', 'l')

def blocks(file)
  File::Stat.new(file).blocks
end

def type(file)
  full_type = File::Stat.new(file).ftype
  FTYPE[full_type]
end

def permission(file)
  permission_numbers = File::Stat.new(file).mode.to_s(8)[-3, 3].chars.map(&:to_i)
  permission_numbers.map { |number| PERMISSIONS[number] }.join
end

def nlink(file)
  File::Stat.new(file).nlink.to_s.rjust(5)
end

def owner(file)
  Etc.getpwuid(File::Stat.new(file).uid).name.center(8)
end

def group(file)
  Etc.getgrgid(File::Stat.new(file).gid).name.center(8)
end

def size(file)
  File::Stat.new(file).size.to_s.rjust(8)
end

def time(file)
  mtime = File::Stat.new(file).mtime
  month_and_day = mtime.strftime('%b %d')
  year_or_time = if mtime < Date.today.prev_month(6).to_time
                   mtime.strftime('%Y').rjust(5)
                 else
                   mtime.strftime('%H:%M').rjust(5)
                 end
  " #{month_and_day} #{year_or_time} "
end

def entries_with_options_in(dir)
  entries = Dir.entries(dir).sort

  entries = Dir.glob("#{dir}/*").sort if OPTIONS['l']

  entries = Dir.glob("#{dir}/*", File::FNM_DOTMATCH).sort if OPTIONS['a']

  entries.reverse! if OPTIONS['r']

  entries
end

def entry_list_of(directories)
  if directories.empty?
    entries = entries_with_options_in('./')
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
  if OPTIONS['l']
    entries_printer_with_stats(entries)
    return
  end

  culumn_height = (entries.length / columns.to_f).ceil
  (0..culumn_height - 1).each do |index|
    (0..columns).each { |n| print entries[index + n * culumn_height]&.ljust(SPACING) }
    puts
  end
end

def entries_printer_with_stats(entries)
  blocks = 0
  output = ''
  entries.each do |entry|
    blocks += blocks(entry)
    output += type(entry)
    output += permission(entry)
    output += nlink(entry)
    output += owner(entry)
    output += group(entry)
    output += size(entry)
    output += time(entry)
    output += File.basename(entry)
    output += "\n"
  end

  puts "total #{blocks}"
  puts output
end

entry_list_of ARGV
