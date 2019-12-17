class ApplicationController < ActionController::Base
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  helper_method :current_cart
  # 讓所有view皆可使用該方法，因若要讓view可用某controller方法，需得在Helper裡定義方法

  private
  def record_not_found
    render file: "#{Rails.root}/public/404.html",  
           layout: false, 
           status: 404
  end

  def current_cart
    @cart ||= Cart.from_hash(session['cart1234'])
  end
end