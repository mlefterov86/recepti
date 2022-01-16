class Recipe < ApplicationRecord
  belongs_to :author
  belongs_to :difficulty

  validates :name, :ingredients, presence: true
  validates_associated :author, :difficulty
end
