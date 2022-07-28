Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
  # (get "/", {to: 'welcome#home'})
  # get "/", {to: 'welcome#home'}
  get "/", to: 'welcome#home' # 到 '/'(首頁) , WelcomeController 找 home action
  # get "/about", to: 'welcome#about'
  get "/about", to: "pages#about" # controller為複數
  # "/about", to: "pages#about"
  #get "/about", to: "pages#about"

  # resources :blog
  get "/blog", to: "blog#index"
  get "/blog/new", to: "blog#new" 
  post "/blog", to: "blog#create"
end

# rails generate controller pages
# rails g controller pages

# 產生
# pages_controller.rb
# app/views/pages
