class AddPincodeToArticle < ActiveRecord::Migration[6.1]
  def change
    add_column :articles, :pincode, :string
  end
end
