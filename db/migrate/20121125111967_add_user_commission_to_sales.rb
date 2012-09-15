class AddUserCommissionToSales < ActiveRecord::Migration
  def change
    add_column :sales, :user_commission, :integer
  end
end
