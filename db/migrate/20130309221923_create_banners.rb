class CreateBanners < ActiveRecord::Migration
  def change
    create_table :banners do |t|
      t.string :title
      t.string :alt
      t.string    :image_content_type
      t.string    :image_file_name
      t.integer   :image_file_size
      t.timestamp :image_updated_at
      t.string :url
      t.string :target
      t.boolean :active, default: false

      t.timestamps
    end
  end
end
