class CreateBlogComments < ActiveRecord::Migration
  def change
    create_table :blog_comments do |t|
      t.string :title, :limit => 50
      t.string :email
      t.string :name
      t.string :site
      t.text :content

      t.timestamps
    end
  end
end
