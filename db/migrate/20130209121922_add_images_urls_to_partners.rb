class AddImagesUrlsToPartners < ActiveRecord::Migration
  def change
    add_column :partners, :image_url, :string
    add_column :partners, :small_image_url, :string
    add_column :partners, :mini_image_url, :string
  end
end
