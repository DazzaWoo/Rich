class BlogsController < ApplicationController
  # include UsersHelpero
  before_action :authenticate_user!, except: [:show]
  def new
    @blog = Blog.new
  end
  
  def show
    @blog = Blog.find_by!(handler: params[:handler])
    if @blog != current_user.blog
      if @blog.visitors.include?(current_user)
        @blog.visitors.destroy(current_user)
      end

      @blog.visitors << current_user
    end  
  end

  def create
    # @blog = Blog.new(blog_params)
    @blog = current_user.build_blog(blog_params)

    if @blog.save
      redirect_to "/@#{@blog.handler}", notice: "已成功建立 Blog"
    else
      render :new
    end
  end

  def edit
    
  end
  private
  def blog_params
    params.require(:blog).permit(:handler, :title, :description)
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