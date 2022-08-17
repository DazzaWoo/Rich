class AddPublishedColumn < ActiveRecord::Migration[6.1]
  def change
    add_column :articles, :publish_at, :datetime
  end
end
