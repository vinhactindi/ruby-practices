# frozen_string_literal: true

class Shot
  MAX_SCORE = 10

  def initialize(mark)
    @mark = mark
  end

  def score
    return MAX_SCORE if @mark == 'X'

    @mark.to_i
  end
end
