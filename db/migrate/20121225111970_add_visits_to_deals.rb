class AddVisitsToDeals < ActiveRecord::Migration
  def change
    add_column :deals, :visits, :integer
  end
end
