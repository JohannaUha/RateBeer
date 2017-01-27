module RatingAverage
  extend ActiveSupport::Concern

  def average_rating
    ratings.map(&:score).inject(:+) / ratings.size.to_f
  end
end