class RenameColumnTitle < ActiveRecord::Migration[6.1]
  def change
    rename_column :articles, :title, :subject
  end
end
