class AddSlugToDeals < ActiveRecord::Migration
  def change
    add_column :deals, :slug, :string
    add_index :deals, :slug, :unique
  end
end
