class Movie < ApplicationRecord
  has_many :reviews, dependent: destroy

  validates :title, presence: true, length: { maximum: 100 }
  validates :description, presence: true
  validates :release_date, presence: true
  validates :director, presence: true
  validates :rating, presence: true,
            numericality: { only_integer: true, greater_than_or_equal_to: 0,
            less_than_or_equal_to: 10 }, message: "must be between 0 and 10"
end
