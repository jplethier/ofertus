class FixCommissionColumnsInSales < ActiveRecord::Migration
  def up
    remove_column :sales, :commission
    add_column :sales, :commission, :float

    remove_column :sales, :user_commission
    add_column :sales, :user_commission, :float
  end

  def down
    remove_column :sales, :commission
    add_column :sales, :commission, :integer

    remove_column :sales, :user_commission
    add_column :sales, :user_commission, :integer
  end
end
