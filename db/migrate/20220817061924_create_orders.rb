class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.string :serial
      t.integer :price
      t.string :state
      t.belongs_to :user, null: false, foreign_key: true
      t.text :note

      t.timestamps
    end
  end
end
