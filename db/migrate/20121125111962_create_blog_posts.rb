class CreateBlogPosts < ActiveRecord::Migration
  def change
    create_table :blog_posts do |t|
      t.string :title, :limit => 150
      t.string :url
      t.text :content
      t.integer :number_of_reads, :default => 0

      t.timestamps
    end
  end
end
