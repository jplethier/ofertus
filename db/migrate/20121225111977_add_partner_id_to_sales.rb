class AddPartnerIdToSales < ActiveRecord::Migration
  def change
    add_column :sales, :partner_id, :integer
  end
end
