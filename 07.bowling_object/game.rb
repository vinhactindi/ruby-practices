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
    point = 0
    @frames.each_with_index do |frame, index|
      point += point_and_bonus(frame, @frames[index + 1], @frames[index + 2])
    end
    point
  end

  private

  def point_and_bonus(frame, next_frame, nnext_frame)
    return frame.score if next_frame.nil?

    if frame.strike? && next_frame.strike? && nnext_frame
      20 + nnext_frame.first_shot.score
    elsif frame.strike?
      10 + next_frame.first_shot.score + next_frame.second_shot.score
    elsif frame.spare?
      10 + next_frame.first_shot.score
    else
      frame.score
    end
  end
end
