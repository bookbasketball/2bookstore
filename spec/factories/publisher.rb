FactoryBot.define do
  factory :publisher do
    name { Faker::Name.name } # 透過Faker gem套件自動產出假名字，其他方法可到GitHub查
    tel { Faker::PhoneNumber.phone_number }
    address { Faker::Address.full_address }
    online { [true, false].sample }
  end
end

FactoryBot.define do
  factory :category do
    name { Faker::Name.name }
    description { Faker::Lorem.paragraph }
  end
end