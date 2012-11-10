class AddGivePowerToDeals < ActiveRecord::Migration
  def change
    add_column :deals, :give_power, :boolean, default: false
  end
end
