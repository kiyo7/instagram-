Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations' }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  #rootはメインのとこ
  root 'posts#index'

  get '/users/:id', to: 'users#show', as: 'user'

  # onlyを使うことによって自動生成されたアクションのどれを使うかを指定できる
  resources :posts, only: %i(new create index show destroy) do 
    resources :photos, only: %i(create) #ネストすることによって親子関係を表せる
    # 今回の例で言うと写真は投稿がないといけない
    
    resources :likes, only: %i(create destroy)  
  end


end



# resourcesメソッドは自動で7つのアクションルーティングを
# 自動で生成する

# 書き方 resources :コントローラー名

# - index
# - new
# - create
# - show
# - edit
# - update
# - destroy
