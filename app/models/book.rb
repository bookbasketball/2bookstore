class Book < ApplicationRecord
  # validations
  validates :title, presence: true
  validates :isbn, :isbn13, presence: true, uniqueness: true
  validates :list_price, :sell_price, :page_num, numericality: { greater_than: 0 }

  #relationships
  has_one_attached :cover_image
  belongs_to :publisher # 對應publisher_id
  has_many :comments

  #scopes
  scope :available, -> { where(on_sell: true).where('list_price > 0') } #lamba是一個匿名函數
  default_scope { with_attached_cover_image }
  # def self.available 因是類別方法，所以必須在前面加一個".self"
  #   where(on_sell: true) where可在類別方法使用，其實where本身也是一種類別分法
  # end
  
end
