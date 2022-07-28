class WelcomeController < ApplicationController
  def home
    # 渲染 html
    # render {html: "<h1>Welcome</h1>"} => {} 可省略
    # render html: "<h1>Welcome</h1>".html_safe # escape 跳脫; .html_safe => 代表通知網頁這是可執行程式碼，就會顯示正常畫面，否則連 html 語法都會印出。

    # 渲染 某個 file 
    # render file: "abc.html"

    # @lottery = [*1..43].sample(6)
  end
  # def about
    
  # end
end