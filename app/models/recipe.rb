class Recipe < ApplicationRecord
  belongs_to :author
  belongs_to :difficulty
  has_and_belongs_to_many :ingredients

  validates :name, :ingredients, presence: true
  validates_associated :author, :difficulty
end
