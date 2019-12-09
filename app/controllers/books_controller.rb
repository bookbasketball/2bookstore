class BooksController < ApplicationController
  before_action :find_book, only: [:show, :comment]
  # before_action :find_book, expect: [:index, :new, :create] 等同於上行
  # before_action :authenticate_user!, except: [:index, :show]
  layout 'book'

  def index
    # @books = Book.where(on_sell: true).with_attached_cover_image
    # @books = Book.available.with_attached_cover_image -> 在Book Model定義available這個類別方法(book.rb)
    # @books = Book.available.with_attached_cover_image.page(1).per(3)
    @books = Book.available
                 .with_attached_cover_image
                 .page(params[:page])
                 .per(3)
    @publishers = Publisher.available
  end
  
  def show
    # find_book
    @comment = Comment.new
    @comments = @book.comments.order(id: :desc)

  end
  
  def new
  #   @book = Book.new
  end

  # def create
  #   @book = Book.new(book_params)

  #   if @book.save
  #     redirect_to root_path, notice: '新增成功!!!' -> 只能用notice or alert
  #   else
  #     render :new -> 借 new.html.erb檔案
  #     redirect_to new_book_path, notice: '新增失敗!!!'
  #   end
  # end

  # def edit
  #   find_book
  #   @book = Book.find(params[:id]) -> 業界常用
  #   @book = Book.find_by(id: params[:id])
  #   @book = Book.find_by(id: params["id"])
  #   redirect_to root_path unless @book, notice: '查無此書'

  #   begin
  #     @book = Book.find(params[:id]) 
  #   rescue
  #     redirect_to root_path, notice: '查無此書'
  #   end
    
  #   render html: params
  # end

  # def update
  #   find_book

  #   if @book.update(book_params)
  #     redirect_to edit_book_path(@book), notice: '更新成功'
  #   else
  #     render :edit
  #   end
  # end

  # def destroy
  #   find_book
  #   @book.destroy
  #   redirect_to root_path, notice: '資料已刪除'
  # end

  def comment
    # 從comment角度
    # @comment = Comment.new(comment_params, user: current_suer, book: @book)

    # 從book角度
    # @comment = @book.comments.build(comment_params)
    # @comment.user = current_suer
    @comment = @book.comments.build(comment_params)

    # 從user角度
    # @comment = current_suer.comments.build(comment_params, book: @book)

    if @comment.save
      redirect_to @book, notice: '留言成功'
    else
      redirect_to @book, notice: '留言失敗'
    end
  end

  private

  def find_book
    @book = Book.find(params[:id])
  end

  # Strong Parameters (從rails 4 開始引進)
  # def book_params
  #   clean_params = params.require(:book).permit(:title, :description, :list_price, :sell_price, :page_num, :isbn, :isbn13, :cover_image, :on_sell, :published_at, :publisher_id)
  # end

  def comment_params
    params.require(:comment)
          .permit(:title, :content)
          .merge(user: current_user)
  end

end



