class Character < ApplicationRecord
  has_and_belongs_to_many :films
  belongs_to :races
  belongs_to :planet

  validates :name, presence: true
  validates_uniqueness_of :name
end