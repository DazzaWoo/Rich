class ApplicationController < ActionController::Base
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  private
  def record_not_found
    # redirect_to '/'""
    # 找不到的話 顯示 404 頁面
    # render 借 檔案： 在 public 資料夾裡的 404.html 檔案
    render file: "#{Rails.root}/public/404.html",  
           layout: false, # 不要套共用的部分
           status: 404 # 改變瀏覽器狀態 => 404
  end
end
