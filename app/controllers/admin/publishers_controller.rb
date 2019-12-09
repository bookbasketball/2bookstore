class Admin::PublishersController < Admin::BaseController
  # before_action :authenticate_user! -> 移至base_controller
  before_action :find_publisher, only: [:show, :edit, :update, :destroy]

  # layout 'backend' -> 移至base_controller

  def index
    @publishers = Publisher.all
  end
  
  def show
  end
  
  def new
    @publisher = Publisher.new
  end

  def create
    @publisher = Publisher.new(publisher_params)
    if @publisher.save
      redirect_to admin_publishers_path, notice: '新增成功!!!'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @publisher.update(publisher_params)
      redirect_to edit_admin_publisher_path(@publisher), notice: '更新成功'
    else
      render :edit
    end
  end

  def destroy
    @publisher.destroy
    redirect_to admin_publishers_path, notice: '資料已刪除'
  end

  private

  def find_publisher
    @publisher = Publisher.find(params[:id])
  end

  def publisher_params
    clean_params = params.require(:publisher).permit(:name, :tel, :address, :online)
  end
end
