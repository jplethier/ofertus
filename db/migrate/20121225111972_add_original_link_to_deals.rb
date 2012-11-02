class AddOriginalLinkToDeals < ActiveRecord::Migration
  def change
    add_column :deals, :original_link, :string
  end
end
