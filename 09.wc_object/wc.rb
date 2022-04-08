#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative './entry'
require_relative './total'

AppOptions.instance

if ARGV.empty?
  puts Entry.new($stdin.read)
else
  puts Total.new(ARGV.map { |fname| Entry.new(File.read(fname), fname) })
end
