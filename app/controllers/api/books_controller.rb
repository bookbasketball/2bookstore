class Api::BooksController < ApplicationController
  before_action :login_check!
  
  # skip_before_action :verify_authenticity_token # 避開錯誤訊息
  
  def favorite
    book = Book.find(params[:id])
    fav = Favorite.find_by(user: current_user, book: book) # 從favorite角度
    # fav = book.favorite.find_by(yser: current_user) # 從book角度
    # fav = current_user.favorites.find_by(book: book) # 從user角度
    favorited = false
    
    if fav
      fav.destory
      favorited = false
    else
      current_user.favorites.create(book: book)
      favorited = true
    end

    render json: {status: 'ok', favorited: favorited}
  end

  private

  def login_check!
    if not user_signed_in?
      head 401 #只給你head 401，沒有body
    end
  end  

end
