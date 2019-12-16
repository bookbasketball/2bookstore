# Autoload (rails自動載入機制)
# CartItem => cart_item.rb
# CartI    => cart.rb

class Cart # < Object  # 購物車無需繼承，因為只需Model，不用Table，所以直接繼承Object
  attr_reader :items
  # def items
  #   @items # 省略 Return
  # end
  
  def initialize
    @items = []
  end

  def add_item(product_id) #方法跟參數名稱都可自定義
    # [1, 1, 1, 3, 3, 2, 2]
    found_item = @items.find {|item| item.product_id == product_id} # Rubdy的陣列本來就內建"find"方法
    # item.product_id 是對映CartItem裡的product_id
    if found_item
      found_item.increment! # 如果找到，就增加數量。"increment!"方法是自定義的，先假設有此方法，所以要另外去定義
    else
      @items << CartItem.new(product_id) # 如果找不到，就新增一個"product_id"
    end
  
  end

  def empty?
    @items.empty?
  end

end