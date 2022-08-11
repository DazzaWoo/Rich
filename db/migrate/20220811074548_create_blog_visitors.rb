class CreateBlogVisitors < ActiveRecord::Migration[6.1]
  def change
    create_table :blog_visitors do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.belongs_to :blog, null: false, foreign_key: true

      t.timestamps
    end
  end
end
