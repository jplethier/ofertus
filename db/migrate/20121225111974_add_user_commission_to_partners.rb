class AddUserCommissionToPartners < ActiveRecord::Migration
  def change
    add_column :partners, :user_commission, :float
  end
end
