class BooksController < ApplicationController
  
  def index
    @books = Book.all
  end

  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)

    if @book.save
      # flash[:notice] = '新增書本成功!!!'
      redirect_to root_path, notice: '新增成功!!!' # 只能用notice or alert
    else
      render :new #借 new.html.erb檔案
      # redirect_to new_book_path, notice: '新增失敗!!!'
    end
  end

  def edit
    @book = Book.find(params[:id])  # 業界常用
    # @book = Book.find_by(id: params[:id])
    # @book = Book.find_by(id: params["id"])
    # redirect_to root_path unless @book, notice: '查無此書'

    # begin
    #   @book = Book.find(params[:id]) 
    # rescue
    #   redirect_to root_path, notice: '查無此書'
    # end
    
    # render html: params
  end

  def update
    @book = Book.find(params[:id])

    if @book.update(book_params)
      redirect_to root_path, notice: '更新成功'
    else
      render :edit
    end
  end

  private

  # Strong Parameters (從rails 4 開始引進)
  def book_params
    clean_params = params.require(:book).permit(:title, :description, :list_price, :sell_price, :page_num, :isbn, :isbn13)
  end

end



