module RatingAverage
  extend ActiveSupport::Concern

  def average_rating
    return 0 if ratings.empty?
    (ratings.map(&:score).inject(:+) / ratings.size.to_f).round(2)
  end
end