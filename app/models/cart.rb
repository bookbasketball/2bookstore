class Cart # < Object  # 購物車無需繼承，因為只需Model，不用Table，所以直接繼承Object
  
  def initialize
    @items = []
  end

  def add_item(product_id) #方法跟參數名稱都可自定義
    @itnes << product_id
  end

  def empty?
    if @items.empty?
  end

end