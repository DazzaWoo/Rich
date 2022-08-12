# Authentication 認證
# Authorization 授權
# 假如登入 facebook ＝ 有得到 facebook 的“認證”，但是不能更改別人的文章 = 沒有得到“授權”

class ArticlesController < ApplicationController

  before_action :authenticate_user!, except: [:index, :show, :unlock]

  # before_action :find_article, only: [:show, :edit, :update, :destroy]
  # before_action :find_article, only: [:show]

  # before_aciton :check_permission, only: [:edit, :udpate, :destroy]
  before_action :find_user_article, only: [:edit, :update, :destroy]
  before_action :find_article, only: [:show, :unclock]

  # rescue 可以為共用的方法，應寫在 ApplicationController 裡
  # 從 controller 層級判斷是否有出現 ActiveRecord::RecordNotFound
  # rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def index
    # @articles = Article.where(deleted_at: nil).order(id: :desc)
    # @articles = Article.avaliable.order(id: :desc)
    @articles = Article.order(id: :desc)
    
    @ad_color1 = "紅"
    @ad_color2 = "黃"
    @ad_color3 = "綠"
  end
  def new
    # if user_signed_in?
      @article = Article.new
    # else
      # redirect_to sign_in_users_path
    # end    
  end
  def create
    # 在同一個 action 下，不能重複 render 或 redirect_to，假如都沒有會出現狀態 204 沒有 content，在 rails 中，204 狀態為無回應。
    # render html: "已成功新增網誌"

    # 寫入資料庫
    # redirect_to "/blogs" 

    # render({html: params})
    #render html: params[:content] # params 本身只是看起像 hash ，但本身不是 hash，用字串跟符號都可以取值
                 # params["content"]
                 # params.class => ActionController::Parameters
    @article = current_user.articles.new(article_params)
    if @article.save
      redirect_to blogs_path(handler: current_user.blog.handler), notice: "Article created!"
    else
      render :new
    end  
  end

  def show
    # render html: params

    # 11:20
    # ex: 找第 3 篇文章
    # find 只能帶數字, find_by 可以帶更多參數
    # 用find_by 找不到 return nil
    #   find_by! 找不到一樣回傳錯誤訊息
    #   find 找不到 return error (ActiveRecord::RecordNotFound)
    # Article.find(3)
    # Article.find_by(id: 3)

    # ps.另外一種拿法
    # Article.where(id: 1) => return []; 
    # 找第一個 Article.where(id: 1).first
    # where 一次找到一群; find、find_by 一次找一筆資料

    # Exception 例外情形 並非 error
    # 用 begin.. rescue 預期壞掉的情況
    # begin
    #   @article = Article.find(params[:id])
    # rescue => exception
    #   redirect_to "/"
    # end

    # @article = Article.find(params[:id]) # 轉移到 before_aciton

    # edit update destroy 改用者用者角度去找文章，只剩 show 方法使用 article 角度去找文章就直接放在 show 方法裡
    # @article = Article.find(params[:id])

    @comment = Comment.new
    @comments = @article.comments.order(id: :desc)
  end
  # def create
    # 批次寫入
    # render html: params[:article]

    # 假設使用者都是壞人需要做資料清洗，確認送過來的資料是正確的
    # 以下兩個方法都可以
    # clean_params = params.require(:article).permit(:title, :content) 通常使用這個
    # clean_params = params[:article].permit(:title, :content)

    # @article = Article.new(params[:article])
    # @article = Article.new(clean_params)

    # 從文章角度創建文章
    # @article = Article.new(article_params)
    # 因 belongs_to 方法，所以有 .user 方法
    # @article.user = current_user

    # 從使用者角度創建文章
    # 等同 54、56行
    # @article = current_user.articles.new(article_params)


    # if @article.save
    #   redirect_to blogs_path, notice: "文章新增成功"
    # else
      # redirect_to '/blogs/new'     
  #     render new_blog_path # => 借 app/views/blogs/new.html.erb 來用
  #   end
  # end
  def edit
    # @article = Article.find(params[:id])
    # if @article.user != current_user
    # if not current_user.own?(@article)
    #   redirect_to '/', notice: "權限不足"
    # end
  end
  def update
    if @article.update(article_params)
      redirect_to blogs_path, notice: "文章修改成功"
    else
      # redirect_to edit_article_path(@article)

      render "/articles/edit"
      # render :edit
      # 51、52行相同
      # 借 edit aciton 的頁面來用
    end
  end
  def destroy
    # @article = Article.find(params[:id])
    @article.destroy
    # @article.update(delete_at: Time.current)
    redirect_to blogs_path, notice: "文章刪除成功"
  end

  def unlock
    find_article
    if @article.pincode == params[:pincode]
      # render :show
      set_unlock_articles(@article.id)
      redirect_to article_path(@article)
    else
      redirect_to article_path(@article), notice: "密碼錯誤"
    end
  end  
  
  private
  def article_params
    params.require(:article).permit(:title, :content, :pincode)
  end
  def find_article
    @article = Article.find(params[:id])
  end
  # def record_not_found
  #   redirect_to '/'
  # end
  # def check_permission
  #   if not current_user.own?(@article)
  #     redirect_to '/', notice: "權限不足"
  #   end
  # end
  def find_user_article
    @article = current_user.articles.find(params[:id])
  end

  def set_unlock_articles(article_id)
    # rails 內建 session; session 結構類似 hash，會存瀏覽器的 cookie，server 會存有 session
    if session[:unlock_articles]
      session[:unlock_articles] << article_id
      session[:unlock_articles].uniq!
    else
      # 第一次進來把 session 設為 article_id
      session[:unlock_articles] = [article_id]
    end    
  end 
end
