class Beer < ActiveRecord::Base
	belongs_to :brewery
  has_many :ratings

  def average_rating
    ratings.map(&:score).inject(:+) / ratings.size.to_f
  end
end