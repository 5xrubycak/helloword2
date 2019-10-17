Rails.application.routes.draw do
  devise_for :users, controllers: { 
    registrations: 'users/registrations',
    omniauth_callbacks: "users/omniauth_callbacks" 
  }
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # resources :setboxes , path: "helloword"

  resources :setboxes , path: "helloword" do
    collection do
      get '/home' ,to: 'setboxes#home'
      get '/search', to: 'setboxes#search'
      get '/lookup', to: 'setboxes#lookup'
    end
    member do
      post :copy
      post :write
      post :judge
      get :write
    end
    # 使用者登入首頁
  end

  scope "(:locale)" do
    resources :setboxes
  end
  
  # api
  namespace :api do
    namespace :v1 do
      post 'login' => 'authentication#login'
      post 'addsetbox' => 'authentication#addsetbox'
      post 'logout' => 'authentication#logout'
      resources :setboxes
    end
  end

  root 'setboxes#index'
end
