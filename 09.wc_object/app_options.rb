# frozen_string_literal: true

require 'singleton'
require 'optparse'

class AppOptions
  include Singleton

  def self.instance
    # rubocop:disable Style/ClassVars
    @@instance ||= ARGV.getopts('l')
    # rubocop:enable Style/ClassVars
  end

  def self.has?(name)
    !!AppOptions.instance[name]
  end
end
