#!/usr/bin/env ruby

require 'date'
require 'optparse'

SPACING = 3

today = Date.today
options = ARGV.getopts('y:', 'm:')
year = (options["y"] || today.year).to_i
month = (options["m"] || today.month).to_i

iterator_date = Date.new(year, month, 1)
last_day = Date.new(year, month, -1)

puts "#{month}月 #{year}".center(7 * SPACING)

puts " 日 月 火 水 木 金 土"

print " " * SPACING * (iterator_date.wday) 

while iterator_date < last_day
  month_day = iterator_date == today ? "\e[31m#{iterator_date.mday.to_s.rjust(SPACING)}\e[0m" : iterator_date.mday.to_s.rjust(SPACING)
  print month_day
  print "\n" if iterator_date.wday == 6
  iterator_date += 1
end

print "\n"
