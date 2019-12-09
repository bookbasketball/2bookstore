class Category < ApplicationRecord
  # validations
  validates :name, :description, presence: true
  
  #relationships
  has_many :tag_libs
  has_many :books, through: :tag_libs
end
