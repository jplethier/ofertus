class RenameTransactionColumnToSales < ActiveRecord::Migration
  def up
    remove_column :sales, :transaction
    add_column :sales, :affiliate_transaction, :integer
  end

  def down
    add_column :sales, :transaction, :integer
    remove_column :sales, :affiliate_transaction
  end
end
