class CartItem
  attr_reader :product_id, :quantity # 通常一開始先開reader即可，除非之後有存取需求，才開writter or accessor
  # def product_id
  #   @product_id
  # end

  # def quantity
  #   @quantity
  # end

  # def initialize(product_id)  # ArgumentError: wrong number of arguments (given 1, expected 0)
  #   @product_id = product_id
  #   @quantity = 1 # 預設值為1
  # end

  # Refactoring 重構
  def initialize(product_id, quantity = 1) # 設定二個參數，第一個是品項，第二個是數量(預設值為1)
    @product_id = product_id
    @quantity = quantity
  end

  def increment! # NoMethodError: undefined method `increment!'。加驚嘆號是非必要的，可表示非常重要或後面不想加參數
    @quantity += 1
  end

  # 對應到"add_item"方法中的 CartItem.new(product_id) @cart.rb
  # CartItem.new(1)    => 1, 1  # 若設定一個參數，當新增一個商品後，數量預設只能是一個
  # CartItem.new(1, 3) => 1, 3  # 若設定二個參數，當新增一個商品後，數量預設可彈性增加一個以上，e.g. 同件商品買3個

  def product
    Book.find_by(id: product_id) # find_by只會找一筆，若找不到則回傳nil
    # Book.find_by(id: @product_id) # id參數也可這樣寫，這邊 "product_id" 等於 "attr_reader :product" 產出的 "product_id"方法
  end

  def total_price
    # (@quantity * product.sell_price).to_i 
    @quantity * product.sell_price
  end

end