Rails.application.routes.draw do
  scope "(:locale)", locale: /en/ do
    root "static_pages#home"
    
    get "/help", to: "static_pages#help"
    get "/info", to: "static_pages#info"
    get "/signup", to: "users#new"
    get "/login", to: "sessions#new"
    post "/login", to: "sessions#create"
    delete "/logout", to: "sessions#destroy"
    resources :users
    resources :courses
    resources :account_activations, only: :edit
    resources :password_resets, except: %i(index show destroy)
  end
end
