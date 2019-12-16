require 'rails_helper'

RSpec.describe Cart, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}" # pending表待會處理，若要做就別關掉(每次跑Rspec都會跳出通知)
  context "基本功能" do
    it "可以把商品丟到到購物車裡，然後購物車裡就有東西了" do
      cart = Cart.new # 此行為"PORO"，語意上是假設有一台新的購物車 
      cart.add_item(1) # 假設"add_item"這個方法存在的話
      expect(cart.empty?).not_to be true # 那我預期購物車不會是空的 (not_to = to_not)
      # expect(cart.empty?).to be false (另一種寫法)
    end
  end
end
