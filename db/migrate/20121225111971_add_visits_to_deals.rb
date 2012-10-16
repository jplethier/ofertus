class AddVisitsToDeals < ActiveRecord::Migration
  def change
    add_column :deals, :visits, :integer, :default => 0
  end
end
