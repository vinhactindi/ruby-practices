#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'

OPTIONS = ARGV.getopts('l')
TOTAL_INITIAL = Array.new(OPTIONS['l'] ? 1 : 3).fill(0)

def counter(text)
  line = text.lines.count
  word = text.split(/\s+/).size
  size = text.size

  return [line] if OPTIONS['l']

  [line, word, size]
end

def printer(counter, fname = nil)
  puts "#{counter.map { |number| number.to_s.rjust(8) }.join} #{fname}"
end

if ARGV.empty?
  printer(counter($stdin.read))
else
  counters = ARGV.map { |fname| counter(File.read(fname)) }
  total = counters.each.with_index.reduce(TOTAL_INITIAL) do |accumulator, (counter, i)|
    printer(counter, ARGV[i])
    accumulator.each.with_index.map { |sum, j| sum + counter[j] }
  end
  printer(total, 'total')
end
