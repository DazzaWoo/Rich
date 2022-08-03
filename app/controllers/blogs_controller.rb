class BlogsController < ApplicationController
  def index
    @articles = Article.all
    @ad_color1 = "紅"
    @ad_color2 = "黃"
    @ad_color3 = "綠"
  end
  def new
    @article = Article.new
  end
  def create
    # 在同一個 action 下，不能重複 render 或 redirect_to，假如都沒有會出現狀態 204 沒有 content，在 rails 中，204 狀態為無回應。
    # render html: "已成功新增網誌"

    # 寫入資料庫
    # redirect_to "/blogs" 

    # render({html: params})
    render html: params[:content] # params 本身只是看起像 hash ，但本身不是 hash，用字串跟符號都可以取值
                 # params["content"]
                 # params.class => ActionController::Parameters
  end
end

# symbol 就像一圖騰，看到就會直接聯想到某一個東西， symbol 是一個有名字的物件，就如同數字 2 ，看到就知道是一個數字 2
# 2 = 3 把 3 指定給 2 ，這樣會錯誤，不能將 3 物件指定給 2 物件

# 建立 model
=begin
在資料庫 string => VarChar 字數有上限
        Text => Text 字數有約 4g 的容量，幾乎用不完
rails g model Articel title content:text    
產生
   article.rb
   articles 表格(包含 t.string :title, t.text :content, t.timestamps == t.datetime :created/ t.datetime :updated) 共5個欄位(id, title, content, created_at, updated_at)
$ rails db:migrate => create_table
class article
file  article.rb
table articles
=end
# 假如專案還在run，但中途修改檔案 會造成在 terminal 建立其他檔案時會終止不動，是因為 bin/spring cache，要解決需要先將 spring 停下來，輸入 spring stop