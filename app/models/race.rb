class Race < ApplicationRecord
  has_and_belongs_to_many :films
  belongs_to :planet
  has_many :characters

  validates :name, presence: true
  validates_uniqueness_of :name
end
