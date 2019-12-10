# rails g controller admin/books
# app/controllers/admin/books_controller.rb

class Admin::BooksController < Admin::BaseController
  # before_action :authenticate_user! -> 移至base_controller
  before_action :find_book, only: [:show, :edit, :update, :destroy]

  # layout 'backend' -> 移至base_controller

  def index
    @books = Book.available
                 .with_attached_cover_image
                 .page(params[:page])
                 .per(3)
  end
  
  def show
  end
  
  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    if @book.save
      redirect_to admin_books_path, notice: '新增成功!!!'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @book.update(book_params)
      redirect_to edit_admin_book_path(@book), notice: '更新成功'
    else
      render :edit
    end
  end

  def destroy
    @book.destroy
    redirect_to admin_books_path, notice: '資料已刪除'
  end

  private

  def find_book
    @book = Book.find(params[:id])
  end

  def book_params
    clean_params = params.require(:book).permit(:title, :description, :list_price, :sell_price, :page_num, :isbn, :isbn13, :cover_image, :on_sell, :published_at, :publisher_id, :category_id)
  end

  # 移至base_controller
  # def permission_check!
  #   if current_user.role != 'admin'
  #     redirect_to root_path, notice: '無法存取'
  #   end
  # end

end