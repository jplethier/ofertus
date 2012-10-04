class RemoveColumnKindFromDeals < ActiveRecord::Migration
  def up
    remove_column :deals, :kind
  end

  def down
    add_column :deals, :kind, :integer, :null => false
  end
end
