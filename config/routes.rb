Rails.application.routes.draw do
  devise_for :users, controllers: { 
    registrations: 'users/registrations',
    omniauth_callbacks: "users/omniauth_callbacks" 
  }
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # resources :setboxes , path: "helloword"

  devise_scope :user do
    # resources 'sign_in', to: 'devise/sessions#new'
    resources :setboxes , path: "helloword/users"
  end
  
  root 'setboxes#index'
end
