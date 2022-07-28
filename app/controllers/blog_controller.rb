class BlogController < ApplicationController
  def index

  end
  def new

  end
  def create
    # 在同一個 action 下，不能重複 render 或 redirect_to，假如都沒有會出現狀態 204 沒有 content，在 rails 中，204 狀態為無回應。
    # render html: "已成功新增網誌"

    # 寫入資料庫
    redirect_to "/blog" 
    
  end
end
