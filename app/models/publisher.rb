class Publisher < ApplicationRecord
  #relationships
  has_many :books

  #scopes
  scope :available, -> { where(online: true) }
  
end
