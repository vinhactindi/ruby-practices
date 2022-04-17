# frozen_string_literal: true

require 'singleton'
require 'optparse'

class AppOptions
  include Singleton

  def initialize
    @options = ARGV.getopts('l')
  end

  def has?(name)
    @options[name]
  end

  def extras
    ARGV
  end
end
