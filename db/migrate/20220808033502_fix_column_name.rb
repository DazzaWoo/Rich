class FixColumnName < ActiveRecord::Migration[6.1]
  def change
    rename_column :articles, :delete_at, :deleted_at
  end
end
