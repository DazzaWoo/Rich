Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
  # 使用 get方法 到 '/' 網址 , 到 WelcomeController 找 home action
  # get("/", {to: 'welcome#home'})
  # get "/", {to: 'welcome#home'}
  # get "/", to: 'welcome#home' 
  # get "/", to: 'welcome#home' 
  root "welcome#home"
  # get "/about", to: 'welcome#about'
  get "/about", to: "welcome#about" # controller為複數
  # "/about", to: "pages#about"
  #get "/about", to: "pages#about"

  # 路徑是由上而下逐行比對，new 不能放在 blog/:id 後面
  # get "/blog", to: "blog#index"
  # get "/blog/new", to: "blog#new" 
  # post "/blog", to: "blog#create"

  # get "/blog/:id", to: "blog#show"
  # 路徑可自行設計 通常會用 :id ， 但是也可以任意更改 改為 :idx 或 :abc 也可以。
  # get "/blog/:id/hello/:a/:b/:c", to: "blog#show"

  # get "/blog/:id/edit", to: "blog#edit"
  # patch "/blog/:id", to: "blog#udpate"
  # delete "/blog/:id", to: "blog#destroy"

  # get "/@:handler/blogs", to: "blogs#show"
  # get "/@:handler/blogs/:id", to: "articles#show"

  scope "/:@handler" do
    resource :blogs, except: [:new, :create]
  end
  resource :blogs, only: [:new, :create] do
    get :new, as: "new"
    post :create, as: "create"
  end

  # REST 所有的網址都會被當成一種資源
  # resources :blogs(用複數 在檢查routes 時，才不會跟 show 衝突，用單數的話 blog#index 的路徑會變為 blog_index)
  # resources :blogs # , path: "helloworld" 假如要修改路徑名稱可用 path "新路徑名稱"
                   # , only: [:index, :new] # only 只要顯示 ：index, :new 路徑
                   # , except: [:index, :new] # except 除了 :index, :new 以外，其餘都顯示      
  # 在終端機找路徑可以用 rails routes -c blog 只找到跟 blog 有關的路徑

  

  resources :comments, only: [:show, :edit, :update, :destroy]
  resources :articles do
    # resources :comments, only: [:index, :new, :create]
    resources :comments, shallow: true, only: [:create, :destroy]

    # member 會有 id
    member do
      patch :unlock
    end
    # member 另一種寫法
    # patch :unclock, on: :member

    # collection 沒有 id。 要幫所有東西做事可以使用 collection
    # collection do
    #   patch :reports
    # end
    # patch :reports, on: :collection
  end

  # /api/v1/artilces/6/like
  namespace :api do
    namespace :v1 do
      resources :articles, only: [] do
        member do
          post :like
        end
      end
    end


  end

  # 建立 sessions
  resource :sessions, only: [:create, :destroy]

  # 用 resource(單數) 在路徑上不會有 id
  # resource :users 
  # 新增客製化路徑（可放多個）get :sing_up
  resource :users, except: [:new, :destroy] do
    get :sign_up
    get :sign_in
  end
  # 假如 resource :user 要單數 後面要再加上 path: "user"
  # resource :users, except: [:new, :destroy], path: "user" do
  #   get :sign_up
  # end

  namespace :ns do
    resources :books
  end

  scope :sp, module: "sp" do
    resources :books
  end

  scope "aaa" do
    resources :books
  end

  get '/@:handler', to: "blogs#show"
  
end

# Prefix Verb   URI Pattern              Controller#Action
# blog_index GET    /blog(.:format)          blog#index
#            POST   /blog(.:format)          blog#create
#   new_blog GET    /blog/new(.:format)      blog#new
#  edit_blog GET    /blog/:id/edit(.:format) blog#edit
#       blog GET    /blog/:id(.:format)      blog#show
#            PATCH  /blog/:id(.:format)      blog#update    patch 只能改某一部分
#            PUT    /blog/:id(.:format)      blog#update    put   可以改整條        通常都會改整條， put 和 patch 都可以
#            DELETE /blog/:id(.:format)      blog#destroy


# rails generate controller pages
# rails g controller pages

# 產生
# pages_controller.rb
# app/views/pages
