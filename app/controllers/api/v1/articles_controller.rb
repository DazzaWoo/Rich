class Api::V1::ArticlesController < ApplicationController
  # skip_before_action :verify_authenticity_token, only: [:like]
  before_action :authenticate_user!
  def like
    # render json: {name:"kk",age:'18'}
    article = Article.find(params[:id])
    if current_user.liked_articles.include?(article)
      # 取消讚
      current_user.liked_articles.destroy(article)
      render json: {state: "unliked", id: params[:id]}
    else
      # 加讚
      current_user.liked_articles << article
      render json: {state: "liked", id: params[:id]}
    end  
  end
end
