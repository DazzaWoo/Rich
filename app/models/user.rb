class User < ApplicationRecord
  # relationships
  has_one :blog
  has_many :articles
  has_many :comments
  has_many :like_articles
  has_many :liked_articles, through: :like_articles, source: :article # 不能照慣例寫實需要另外寫 foreign_key
  has_many :blog_visitors
  has_many :visited_blogs, through: :blog_visitors, source: :blog
  has_many :orders
  

  # validation
  validates :email, presence: true, uniqueness: true
            # 驗證 email 格式 format: { with: /\A[a-zA-Z]+\z/ }

  validates :password,
             presence: true,
             length: { minimum: 6 },
             confirmation: true

  # callback
  # before_save :encrypt_password
  # 應該在 before_create 前加鹽(salting) 
  # 在密碼前後 + 亂碼 如：xxfdkfjdlfjdlfj123456dfjkdljflkd
  before_save :sayhi
  before_create :encrypt_password

  # def own?(article)
  #   article.user == self
  # end

  def self.login(user_params)
    email = user_params[:email]
    password = user_params[:password]
    hased_password = Digest::SHA1.hexdigest("x------#{password}yy")
    find_by(email: email, password: hased_password)
  end

  def liked?(article)
    liked_articles.include?(article)
  end  

  private
  def encrypt_password
    # require "digest" 
    # 在 rails 中已經載入過，rails 環境可省略不寫(require "digest")，Ruby 環境無載入 必須要 require 才能使用。PS. rquire 只載入一次，load 會一直載入

    # 加鹽 salting

    pw = "x------#{self.password}yy"
    self.password = Digest::SHA1.hexdigest(pw)
  end
  def sayhi
    puts "hi"
  end
end

