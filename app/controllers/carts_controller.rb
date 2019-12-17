class CartsController < ApplicationController
  def add
    # cart = Cart.new 這樣會造成每次購買都會新增一台購物車，以致只會顯示最後購買的商品
    current_cart.add_item(params[:id])
    session['cart1234'] = current_cart.serialize # seesion是類似Hash結構
    # 第五行執行時，會記得第四行current_cart產出的資料，然後再執行 (是因為在private裡有設定" ||= " 記憶化)
    
    
    redirect_to root_path, notice: '成功加入至購物車'
  end
  
  def show
  end
  
  # 整理至 application_controller.rb，目的是讓所有controller都可以繼承
  # private
  
  # def current_cart
  #   @cart ||= Cart.from_hash(session['cart1234']) # " ||= " memorization 記憶化
      # 使用實體變數，會讓他永遠存在current_cart裡面，若是區域變數的話，下一次執行時就會重新開始，忘記上次資料
  # end

end
