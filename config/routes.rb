Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
  # (get "/", {to: 'welcome#home'})
  # get "/", {to: 'welcome#home'}
  get "/", to: 'welcome#home' # 到 '/'(首頁) , WelcomeController 找 home action
  get "/about", to: 'welcome#about'
end
