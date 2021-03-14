class Film < ApplicationRecord
  has_and_belongs_to_many :characters
  has_and_belongs_to_many :planets
  has_and_belongs_to_many :races

  validates :title, presence: true
  validates_uniqueness_of :title
end
