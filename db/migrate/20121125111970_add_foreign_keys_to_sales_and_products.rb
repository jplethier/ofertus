class AddForeignKeysToSalesAndProducts < ActiveRecord::Migration
  def change
    remove_column :sales, :user
    add_column :sales, :user_id, :integer
    add_column :products, :sale_id, :integer
  end
end
