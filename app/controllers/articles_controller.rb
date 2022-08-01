class ArticlesController < ApplicationController
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
    
    @article = Article.find(params[:id])
  end
  def create
    # 批次寫入
    # render html: params[:article]

    # 假設使用者都是壞人需要做資料清洗，確認送過來的資料是正確的
    # 以下兩個方法都可以
    # clean_params = params.require(:article).permit(:title, :content) 通常使用這個
    # clean_params = params[:article].permit(:title, :content)

    # @article = Article.new(params[:article])
    # @article = Article.new(clean_params)
    @article = Article.new(article_params)

    if @article.save
      redirect_to blogs_path
    else
      # redirect_to '/blogs/new'     
      render new_blog_path # => 借 app/views/blogs/new.html.erb 來用
    end
  end
  def edit
    @article = Article.find(params[:id])
  end
  def update
    @article = Article.find(params[:id])
    if @article.update(article_params)
      redirect_to blogs_path, notice: "Article updated!"
    else
      # redirect_to edit_article_path(@article)

      render "/articles/edit"
      # render :edit
      # 51、52行相同
      # 借 edit aciton 的頁面來用
    end
  end
  def destroy
    @article = Article.find(params[:id])
    if @article.destroy
      redirect_to blogs_path, notice: "Article destroied!"
    end
  end
  
  private
  def article_params
    params.require(:article).permit(:title, :content)
  end
end
