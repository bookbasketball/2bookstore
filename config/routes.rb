Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' } # 當完成驗證後，回傳成功
  

  resource :cart, only: [:show, :destory] do
    collection do
      post :add, path: ':id/add' # cart/:id/add
      # post :add, path: 'add/:id' # cart/add/:id (另一種寫法)
    end
  end
  # 單數運用情境在前台使用者再看自己資料的時候，重點不在於名稱的單複數，而是在於"resource"是否是單複數
  # resources :carts
  # 複數運用情境可能在Admin想看所有使用者資料，就可使用。因複數"resources"後面會展出(:id)，單數不會

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

  namespace :api do
    resources :books, only: [] do # 預設8個路徑都不需要了，只保留favorite
      member do
        post :favorite # /api/books/:id/favorite
      end
    end
  end

end