class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[google_oauth2] # 若要增加串接Facebook，則可寫 %i[google_oauth2 facebook]

  # relationship
  has_many :comments # 用User角度，查找留言。若不需要這個功能，就不用寫has_many
  has_many :favorites
  has_many :books, through: :favorites

  def employee?
    role.in? ['staff', 'boss', 'admin']
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user| # 查找出一個陣列裡包含provider及uid，若查無資料，則建立一個新的使用者
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.name = auth.info.name   # assuming the user model has a name
      user.avatar = auth.info.image # assuming the user model has an image
      # If you are using confirmable and the provider(s) you use validate emails, 
      # uncomment the line below to skip the confirmation emails.
      # user.skip_confirmation!
    end
  end
end
 