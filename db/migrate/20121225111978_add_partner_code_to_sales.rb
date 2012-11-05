class AddPartnerCodeToSales < ActiveRecord::Migration
  def change
    add_column :sales, :partner_code, :string
  end
end
