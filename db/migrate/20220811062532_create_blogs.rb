class CreateBlogs < ActiveRecord::Migration[6.1]
  def change
    create_table :blogs do |t|
      t.string :handler
      t.string :title
      t.text :description
      t.belongs_to :user, null: false, foreign_key: true
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
