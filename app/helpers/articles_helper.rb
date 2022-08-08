module ArticlesHelper
  def is_locked?(article)
    article.pincode.present? && !session[:unlock_articles]&.include?(article.id)
  end  
end
