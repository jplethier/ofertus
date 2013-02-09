class AddPromotionsFieldsToPartners < ActiveRecord::Migration
  def change
    add_column :partners, :promotion, :boolean, default: false
    add_column :partners, :promotion_commission, :float, default: 0.0
  end
end
