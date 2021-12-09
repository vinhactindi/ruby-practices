# frozen_string_literal: true

class AppOption
  require 'optparse'

  def initialize
    @options = ARGV.getopts('a', 'r', 'l')
  end

  def has?(name)
    !!@options[name]
  end

  def extras
    ARGV
  end
end
