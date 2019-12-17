require 'rails_helper'

RSpec.describe Cart, type: :model do
  # 通常before是在跑測試前，測試環境的設定，但這個地方並不是不能用
  # before do 
  #   @cart = Cart.new
  # end

  let(:cart) {Cart.new} # 定義一個方法，而這個方法可以產生一台購物車 (取代下面所有的 Cart.new)
  # let也可寫在context內(14行下面)

  # pending "add some examples to (or delete) {__FILE__}" pending表待會處理，若要做就別關掉(每次跑Rspec都會跳出通知)
  
  context "進階功能" do
    it "可以將購物車內容轉換為 Hash 並存到 Session 裡" do
      # cart = Cart.new
      
      book1 = create(:book)
      book2 = create(:book)

      3.times {cart.add_item(book1.id)}
      2.times {cart.add_item(book2.id)}

      # 整理到private
      # cart_hash = {
      #   "items" => [
      #     {"product_id" => 1, "quantity" => 3},
      #     {"product_id" => 2, "quantity" => 2}
      #     # hash用舊式寫法主因 : 在網路傳遞時，各個元素都會變成字串傳遞，但hash新式寫法是用符號，對於網路傳輸時還要另外轉成字串
      #     # 如果屆時要轉回符號時，可能不一定能比對回來，因此用舊式寫法(字串)
      #   ]
      # }

      expect(cart.serialize).to eq cart_hash # ".serialize"方法名稱定義是希望把整個購物車變成一個字串(序列化)，因此才這樣命名
    end

    it "也可以存放在 Session的內容 (Hash格式)，還原成購物車的內容" do
      #  整理到private
      #  cart_hash = {
      #    "items" => [
      #      {"product_id" => 1, "quantity" => 3},
      #      {"product_id" => 2, "quantity" => 2}
      #    ]
      #  }

       cart = Cart.from_hash(cart_hash)

       expect(cart.items.count).to be 2
       expect(cart.items.first.quantity).to be 3
    end
  end
  
  context "基本功能" do
    it "可以把商品丟到到購物車裡，然後購物車裡就有東西了" do
      # cart = Cart.new # 此行為"PORO"，語意上是假設有一台新的購物車 
      cart.add_item(1) # 假設"add_item"這個方法存在的話
      expect(cart.empty?).not_to be true # 那我預期購物車不會是空的 (not_to = to_not)
      # expect(cart.empty?).to be false (另一種寫法)
      # expect(cart).not_to be_empty (黑魔法) e.g. expect(cart.hello?).to be true --> epect(cart).to be_hello
    end

    it "加了相同的商品，項目不會增加，商品數量會改變" do
      # cart = Cart.new

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
      # cart = Cart.new

      # 工廠方法 factory_bot (factory_girl) 整理以下這段
      # p1 = Publisher.create(name: 'kk store')
      # p1 = Publisher.create(:publisher) # 利用 Factory gem套件改寫 from spec/factories/publisher.rb
      # c1 = Category.create(name: 'ruby book')
      # c1 = Category.create(:category) # 利用 Factory gem套件改寫 from spec/factories/publisher.rb

      book = create(:book) # 在rails_helper.rb因有設定"FactoryBot"方法，因此可省略Factory.Bot
      # (config.include FactoryBot::Syntax::Methods)
      # b1 = FactoryBot.create(:book)
      # b1 = Book.create(title: 'hello', isbn: 'aaa', isbn13: 'bbb', publisher: 'p1', category: 'c1', list_price: 100, sell_price: 50, page_num: 23, publisher: p1, category: c1)

      cart.add_item(book.id)
      expect(cart.items.first.product).to be_a Book
      # be_a = be_an = be_kind_of 表示一種東西，但使用時機與英文文法相同，當後面是母音開頭，會寫"to_an"，並先假設有"product"方法
      # 測試三A原則 : Arrange, Act, Assert
    end

    it "可以計算整台購物車的總消費金額" do
      # Arrange
      # cart = Cart.new

      book1 = create(:book, sell_price: 50) 
      book2 = create(:book, sell_price: 100)
      
      # Act

      3.times { cart.add_item(book1.id) }
      2.times { cart.add_item(book2.id) }

      # Assert
      expect(cart.total_price).to eq 350
    end
  end

  private 
  def cart_hash
    {
      "items" => [
        {"product_id" => 1, "quantity" => 3},
        {"product_id" => 2, "quantity" => 2}
      ]
    }
  end
end
