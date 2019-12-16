class PublishersController < ApplicationController
  layout 'book'
  
  def show
    @publisher = Publisher.find(params[:id])
    @books = @publisher.books.page(params[:page]) #.per(1) -> 一頁只顯示一個
    # @books = @publisher.books.where('price > 10') 只要是某一種關連，後面就可以接page, where等
  end
end