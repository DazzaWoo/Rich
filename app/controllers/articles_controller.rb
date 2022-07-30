class ArticlesController < ApplicationController
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


  private
  def article_params
    params.require(:article).permit(:title, :content)
  end
end
