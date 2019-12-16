require 'rails_helper'

RSpec.describe Cart, type: :model do
  # pending "add some examples to (or delete) {__FILE__}" pending表待會處理，若要做就別關掉(每次跑Rspec都會跳出通知)
  context "基本功能" do
    it "可以把商品丟到到購物車裡，然後購物車裡就有東西了" do
      cart = Cart.new # 此行為"PORO"，語意上是假設有一台新的購物車 
      cart.add_item(1) # 假設"add_item"這個方法存在的話
      expect(cart.empty?).not_to be true # 那我預期購物車不會是空的 (not_to = to_not)
      # expect(cart.empty?).to be false (另一種寫法)
    end

    it "加了相同的商品，項目不會增加，商品數量會改變" do
      cart = Cart.new

      # cart.add_item(1)
      # cart.add_item(1)
      # cart.add_item(1)
      # cart.add_item(2)
      # cart.add_item(2)

      3.times {cart.add_item(1)}
      2.times {cart.add_item(2)}

      expect(cart.items.count).to be 2 # 假設"items"方法存在，預期"items"方法會回傳陣列
      expect(cart.items.first.quantity).to be 3 # 假設"quantity"方法存在，預期"quantity"方法會回傳陣列
    end

    it "商品可以放到購物車裡，也可以再拿出來" do # 在跑測試時，不會影響資料庫，會寫入至"db/test.sqlite3"檔案內，所以不會寫到開發及正式資料庫內。當跑完測試後，下次跑時就會自動清空
      cart = Cart.new

      # 工廠方法 factory_bot (factory_girl) 整理以下這段
      # p1 = Publisher.create(name: 'kk store')
      # p1 = Publisher.create(:publisher) # 利用 Factory gem套件改寫 from spec/factories/publisher.rb
      # c1 = Category.create(name: 'ruby book')
      # c1 = Category.create(:category) # 利用 Factory gem套件改寫 from spec/factories/publisher.rb

      book = create(:book) # 在rails_helper.rb因有設定"FactoryBot"方法，因此可省略Factory.Bot
      # (config.include FactoryBot::Syntax::Methods)
      # b1 = FactoryBot.create(:book)
      # b1 = Book.create(title: 'hello', isbn: 'aaa', isbn13: 'bbb', publisher: 'p1', category: 'c1', list_price: 100, sell_price: 50, page_num: 23, publisher: p1, category: c1)

      cart.add_item(b1.id)
      expect(cart.items.first.product).to be_a Book
      # be_a = be_an = be_kind_of 表示一種東西，但使用時機與英文文法相同，當後面是母音開頭，會寫"to_an"，並先假設有"product"方法
      # 測試三A原則 : Arrange, Act, Assert
    end
  end
end
