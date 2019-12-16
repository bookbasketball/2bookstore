require 'rails_helper'

RSpec.describe CartItem, type: :model do
  it "每個Cart Item 都可以計算他自己的金額 (小計)" do
    
    # AAA
    # Arrange
    cart = Cart.new

    # Act
    book1 = create(:book, sell_price: 50) # 限制價錢50塊以內
    book2 = create(:book, sell_price: 100)

    # Assert
    expect(cart.items.first.total_price).to eq 150 # be必須是要同一個東西(Object_id相同) ; eq等於，兩個值相等就會回傳true
    expect(cart.items.last.total_price).to eq 200

  end
end
