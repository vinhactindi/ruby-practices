# frozen_string_literal: true

require './frame'

class Game
  attr_reader :frames

  def initialize(score)
    scores = score.split(',')
    @frames = []

    until scores.empty?
      shifted_score = scores.shift

      @frames << if @frames.size == 9
                   Frame.new(shifted_score, scores.shift, scores.shift)
                 elsif shifted_score == 'X'
                   Frame.new(shifted_score, 0)
                 else
                   Frame.new(shifted_score, scores.shift)
                 end
    end
  end

  def score
    @frames.each_with_index.sum do |frame, index|
      frame.score_and_bonus(@frames[index + 1], @frames[index + 2])
    end
  end

end
