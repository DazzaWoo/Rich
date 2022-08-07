class AddUserIdToArticle < ActiveRecord::Migration[6.1]
  def change
    # add_column :articles, :user_id, :integer
    add_reference :articles, :user # 增加索引，用空間換時間
    # add_belongs_to :articles, :user
    # reference 跟 belongs_to 結果相同
  end
end
