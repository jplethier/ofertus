class AddStatusToSales < ActiveRecord::Migration
  def change
    add_column :sales, :status, :integer
  end
end
