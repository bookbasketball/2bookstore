class Category < ApplicationRecord
  # validations
  validates :name, :description, presence: true
  
  #relationships
  has_many :books
end
