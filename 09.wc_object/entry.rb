# frozen_string_literal: true

require_relative './app_options'

class Entry
  attr_reader :lines, :words, :bytes, :name

  def initialize(text, name = nil)
    @text = text
    @name = name

    @lines = text.lines.count
    @words = text.split(/\s+/).size
    @bytes = text.size
  end

  def to_s
    counters = AppOptions.has?('l') ? [@lines] : [@lines, @words, @bytes]
    "#{counters.map { |number| number.to_s.rjust(8) }.join} #{name}"
  end
end
