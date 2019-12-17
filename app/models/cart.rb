# Autoload (rails自動載入機制)
# CartItem => cart_item.rb
# CartI    => cart.rb

class Cart # < Object  # 購物車無需繼承，因為只需Model，不用Table，所以直接繼承Object
  attr_reader :items
  # def items
  #   @items # 省略 Return
  # end
  
  def initialize(items = [])
    @items = items
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

  def total_price
    # total = 0
    # @items.each do |item|
    #   total = total + item.total_price
    # end
    # return total

    @items.reduce(0) { |sum, item| sum + item.total_price } # reduce需設定初始值，若無設定則會找第一個值開始累加
  end

  def serialize

    # map對每個元素都做一件事情，然後得到一個hash，並丟入陣列
    result = @items.map { |item|
      { "product_id" => item.product_id, "quantity" => item.quantity }
    }

    # result = []
    # @items.each do |item|
    #   result << { "product_id" => item.product_id, "quantity" => item.quantity }
    # end

    { "items" => result }

    # items = [
    #   {"product_id" => 1, "quantity" => 3},
    #   {"product_id" => 2, "quantity" => 2}
    # ]
    # { "items" => items }
  end

  def self.from_hash(hash = nil)
    if hash && hash["items"]
      items = []
      hash["items"].each do |item|
        items << CartItem.new(item["product_id"], item["quantity"])
        # {"product_id" => 1, "quantity" => 3}
      end

      Cart.new(items) # = new(item) = self.new(item)
    else
      Cart.new # = new = self.new
    end
  end
end