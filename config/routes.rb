Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' } # 當完成驗證後，回傳成功
  resources :books, only: [:index, :show]
  root 'books#index'
  
  namespace :admin do
    root 'books#index' # /admin/
    # get "/", to: 'book#index'
    resources :books   # /admin/books
    resources :publishers
  end
end