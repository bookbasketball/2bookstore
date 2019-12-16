# def generate_isbn(n)
#   ([*'A'..'Z'] + [*0..9]).sample(n).join
# end

FactoryBot.define do
  factory :book do
    title      { Facker::name.name}
    list_price { [*10..1000].sample }
    sell_price { [*10..1000].sample }
    page_num   { [*100..200].sample }
    # isbn       { generate_isbn(10) }
    # isbn13     { generate_isbn(13) }
    isbn       { SecureRandom.hex(5).upcase }
    isbn13     { SecureRandom.hex(6).upcase }
    publisher
    category

  end
end