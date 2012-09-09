class AddTeamTopToDeals < ActiveRecord::Migration
  def change
    add_column :deals, :ofertus_top, :boolean, :default => false
  end
end
