# frozen_string_literal: true

require './shot'
require './game'

class Frame
  attr_reader :first_shot, :second_shot

  def initialize(first_mark, second_mark, third_mark = nil)
    @first_shot = Shot.new(first_mark)
    @second_shot = Shot.new(second_mark)
    @third_shot = Shot.new(third_mark)
  end

  def score_and_bonus(next_frame, next_next_frame)
    return score if next_frame.nil?

    if strike? && next_frame.strike? && next_next_frame
      2 * Game::MAX_SCORE + next_next_frame.first_shot.score
    elsif strike?
      Game::MAX_SCORE + next_frame.first_shot.score + next_frame.second_shot.score
    elsif spare?
      Game::MAX_SCORE + next_frame.first_shot.score
    else
      score
    end
  end

  def score
    [first_shot.score, second_shot.score, @third_shot.score].sum
  end

  def strike?
    first_shot.score == Game::MAX_SCORE
  end

  def spare?
    first_shot.score + second_shot.score == Game::MAX_SCORE && !strike?
  end
end
