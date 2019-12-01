class Publisher < ApplicationRecord
  #validates
  validates :name, :tel, :address, presence: true
  
  #relationships
  has_many :books

  #scopes
  scope :available, -> { where(online: true) }
  
end
