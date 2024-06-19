class Review < ApplicationRecord
  belongs_to :movie

  validates :content, presence: true
  validates :rating, presence:     true,
                     numericality: { only_integer: true, greater_than_or_equal_to: 0,
less_than_or_equal_to: 5 }
end
