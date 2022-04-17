# frozen_string_literal: true

class Total
  def initialize(entries)
    @entries = entries

    @lines = entries.sum(&:lines)
    @words = entries.sum(&:words)
    @bytes = entries.sum(&:bytes)
  end

  def to_s
    counters = AppOptions.instance.has?('l') ? [@lines] : [@lines, @words, @bytes]

    ouput = @entries.collect(&:to_s).join("\n")
    ouput += "\n#{counters.map { |number| number.to_s.rjust(8) }.join} total" if @entries.size > 1
    ouput
  end
end
