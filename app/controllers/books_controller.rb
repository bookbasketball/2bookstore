class BooksController < ApplicationController
  
  def index
  end

  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)

    if @book.save
    #   flash[:notice] = '新增書本成功!!!'
      redirect_to root_path, notice: '新增成功!!!' # 只能用notice or alert
    else
      redirect_to new_book_path, notice: '新增失敗!!!'
    end
  end

  private

  # Strong Parameters
  def book_params
    clean_params = params.require(:book).permit(:title, :description, :list_price, :sell_price, :page_num, :isbn, :isbn13)
  end

end



