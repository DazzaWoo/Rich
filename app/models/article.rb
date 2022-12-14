class Article < ApplicationRecord
  acts_as_paranoid

  # relationships
  belongs_to :user
  has_many :comments
  has_many :like_articles
  has_many :users, through: :like_articles

  # validates (:title, {prsence: true})  
  validates :title, presence: true, length: { minimum: 2 }

  # 所有商業邏輯可以整理在同一個地方，以便後續維護。
  # 可用 scope 或 類別方法
  # def self.available
  #   where(delete_at: nil)
  # end
  # Lambda, Callback function
  # scope :avaliable, -> { where (delete_at: nil) }
  # default_scope 所以有的找法都會加上
  # default_scope { where (delete_at: nil) }

  # 假如搜尋某一個不想加 default scope，但其他需要 default_scope
  # Article.unscope(:where).find_by(id: 2)

  # def destroy
  #   @article.update(delete_at: Time.current)
  # end  
  
end

=begin
rails db:migrate 只會做一次，不會重複建立 table，即便改名也不行重複建立。

# 透過 migration 建立或刪除資料表
假如要改變某欄位的名稱 三種作法
1. 刪除 model 重建一個 model 和 table
2. 先在migration欓 改變某欄位 再 rails db:rollback 再 rails db:migrate
3. 新增一個 migration 如: rails g migraion rename_subject_to_migration
   再到 新的 migration 手動建立新的欄位
   改欄位 rename_column(表格名字, 就的欄位名字, 新的欄位名字)
   最後在 rails db:migrate
   ps. 假如要在改回去 rails db:rollback => 就會在改回原本的，最後要在 rails db:migrate
   做過的 migration 就不會再做一次。
   做過的會存在 sqllite => schema_migrations
   rails db:migrate:status -> 檢查 migration 的狀態
=end