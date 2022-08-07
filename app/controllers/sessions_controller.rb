class SessionsController < ApplicationController
  def create
    user = User.login(params[:user])
    if user
      # 發 session 號碼牌
      # controller 內建 
      session[:user_session] = user.id # => 會在 瀏覽器 有 cookie, server 有 session，目前只有 user 拿到 cookie (號碼牌) ， 還需要再去比對。

      redirect_to '/', notice: "登入成功"
    else
      redirect_to "/users/sign_in", notice: "登入失敗"
    end
  end

  def destroy
    # 刪除 session id
    session[:user_session] = nil
    redirect_to '/', notice: "已登出"
  end
end
