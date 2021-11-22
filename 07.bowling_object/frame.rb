# frozen_string_literal: true

require './shot'

class Frame
  attr_reader :first_shot, :second_shot

  def initialize(first_mark, second_mark, third_mark = nil)
    @first_shot = Shot.new(first_mark)
    @second_shot = Shot.new(second_mark)
    @third_shot = Shot.new(third_mark)
  end

  def score
    [first_shot.score, second_shot.score, @third_shot.score].sum
  end

  def strike?
    first_shot.score == 10
  end

  def spare?
    first_shot.score + second_shot.score == 10 && @third_shot.mark.nil?
  end
end
