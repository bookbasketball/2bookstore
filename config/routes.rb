Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' } # 當完成驗證後，回傳成功
  
  resources :books, only: [:index, :show] do
  # 在resources中增加第九種方法，可用collection或member這兩種方法
    # collection # 網址若沒有數字時，可用collection，e.g. 列表頁、統計頁
    #   /books/list
    #   /books/world
    # member
    #   /books/2/hello
    #   /books/2/world
    member do 
      post :comment #POST /books/:id/comment, to: 'books#comment'
    end
  end
  
  resources :publishers, only: [:show]
  resources :comments, only: [:create]
  root 'books#index'
  
  namespace :admin do
    root 'books#index' # /admin/
    # get "/", to: 'book#index'
    resources :books   # /admin/books
    resources :publishers
    resources :categories
  end
end