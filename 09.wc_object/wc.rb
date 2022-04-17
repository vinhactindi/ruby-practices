#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative './entry'
require_relative './total'

if AppOptions.instance.extras.empty?
  puts Entry.new($stdin.read)
else
  puts Total.new(AppOptions.instance.extras.map { |fname| Entry.new(File.read(fname), fname) })
end
