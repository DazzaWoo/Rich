class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_article, only: [:create]
  before_action :find_comment, only: [:destroy]

  def create
    # render html: params
    @comment = @article.comments.new(comment_params)
    if @comment.save
      redirect_to @article, notice: "留言成功"
    else
      redirect_to @article, notice: "留言失敗"
    end
  end
  
  def destroy
    @comment.destroy # 在這裡 @comment 還沒完全刪除，等到
    redirect_to @comment.article, notice: "留言已刪除"
  end  
  
  private
  def find_article
    @article = Article.find(params[:article_id])
  end
  def comment_params
    params.require(:comment).permit(:content).merge(user: current_user)
  end
  def find_comment
    @comment = current_user.comments.find(params[:id])
  end
end
