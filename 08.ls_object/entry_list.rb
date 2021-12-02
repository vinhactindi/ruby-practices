# frozen_string_literal: true

require './entry'

class EntryList
  def initialize(paths)
    @entries = paths.map { |path| Entry.new(path) }
    @blocks = @entries.map(&:blocks).sum
  end

  def to_s_with_columns(columns = 3)
    culumn_height = (@entries.length / columns.to_f).ceil
    output = ''
    (0..culumn_height - 1).each do |index|
      (0..columns).each do |n|
        entry = @entries[index + n * culumn_height]
        output += entry.basename.ljust(24) if entry
      end
      output += "\n"
    end
    output
  end

  def to_s_with_stats
    output = "total #{@blocks}\n"
    output + @entries.map(&:to_s).join("\n")
  end
end
