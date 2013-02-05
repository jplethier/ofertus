class AddPartnerIdToDeals < ActiveRecord::Migration
  def change
    add_column :deals, :partner_id, :integer
  end
end
