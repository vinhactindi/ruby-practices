#!/usr/bin/env ruby

require 'date'
require 'optparse'

SPACING = 3

today = Date.today
options = ARGV.getopts('y:', 'm:')
year = (options["y"] || today.year).to_i
month = (options["m"] || today.month).to_i

first_day = Date.new(year, month, 1)
last_day = Date.new(year, month, -1)

puts "#{month}月 #{year}".center(7 * SPACING)

puts " 日 月 火 水 木 金 土"

print " " * SPACING * (first_day.wday) 

(first_day..last_day).each do |date|
  month_day = date == today ? "\e[31m#{date.mday.to_s.rjust(SPACING)}\e[0m" : date.mday.to_s.rjust(SPACING)
  print month_day
  print "\n" if date.saturday?
  date += 1
end

print "\n"
