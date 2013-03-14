class AddIconToBanners < ActiveRecord::Migration
  def change
    add_column :banners, :icon_content_type, :string
    add_column :banners, :icon_file_name, :string
    add_column :banners, :icon_file_size, :integer
    add_column :banners, :icon_updated_at, :timestamp
  end
end
