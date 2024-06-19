class Movie < ApplicationRecord
  has_many :reviews, dependent: :destroy

  validates :title, :description, :release_date, :director, :rating, presence: true
  validates :title, length: { maximum: 100 }
  validates :rating, numericality: { only_integer: true, greater_than_or_equal_to: 0,
                                     less_than_or_equal_to: 10,
                                     message: "must be between 0 and 10" }
end
