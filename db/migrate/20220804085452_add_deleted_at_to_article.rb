class AddDeletedAtToArticle < ActiveRecord::Migration[6.1]
  def change
    add_column :articles, :delete_at, :datetime # delete_at 寫錯，應改為 deleted_at
    add_index :articles, :delete_at # delete_at 寫錯，應改為 deleted_at
  end
end
