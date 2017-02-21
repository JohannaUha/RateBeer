class Beer < ActiveRecord::Base
  include RatingAverage

  belongs_to :brewery
  belongs_to :style
  has_many :ratings, dependent: :destroy
  has_many :raters, -> { uniq }, through: :ratings, source: :user

  validates :name, presence: true
  validates :style, presence: true

  def to_s
    "#{name} #{brewery.name}"
  end

  def average
    ratings.map{ |r| r.score }.sum / ratings.count.to_f
  end

  def self.top(n)
    sorted = Beer.all.sort_by{ |b| -(b.average_rating||0) }
    sorted.take(n)
  end
end