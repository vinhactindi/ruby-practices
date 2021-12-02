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

  def dir
    if extras.empty?
      yield(entry_paths('./'), './')
    else
      extras.each do |path|
        yield(entry_paths(path), path)
      end
    end
  end

  def entry_paths(dir)
    output = Dir.glob("#{dir}/*").sort
    output = Dir.glob("#{dir}/*", File::FNM_DOTMATCH).sort if has?('a')
    output.reverse! if has?('r')

    output
  end
end
