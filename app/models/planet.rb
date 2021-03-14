class Planet < ApplicationRecord
  has_and_belongs_to_many :films
  # has_many :races
  has_many :races, :dependent => :delete_all
  has_many :characters

  validates :name, presence: true
  validates_uniqueness_of :name
end
