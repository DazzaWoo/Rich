class ApplicationController < ActionController::Base
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  helper_method :current_user, :user_signed_in?

  private
  def record_not_found
    # redirect_to '/'""
    # 找不到的話 顯示 404 頁面
    # render 借 檔案： 在 public 資料夾裡的 404.html 檔案
    render file: "#{Rails.root}/public/404.html",  
           layout: false, # 不要套共用的部分
           status: 404 # 改變瀏覽器狀態 => 404
  end

  def current_user
    # 減少同一個 controller 重複進資料庫撈資料
    # 判斷是否已經有資料，沒有的話就近資料庫撈資料
    # 此用法為 Ruby memoizae
    # @_current_user = @_current_user || User.find_by(id: session[:user_session])
    @current_user ||= User.find_by(id: session[:user_session])
  end

  def user_signed_in?
    session[:user_session] && current_user
  end

  # def require_login
  def authenticate_user!
    redirect_to sign_in_users_path if not user_signed_in?
  end
end
