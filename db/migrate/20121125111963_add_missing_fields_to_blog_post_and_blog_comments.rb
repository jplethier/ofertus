class AddMissingFieldsToBlogPostAndBlogComments < ActiveRecord::Migration
  def change
    add_column :blog_posts, :user_id, :integer
    add_column :blog_comments, :blog_post_id, :integer
    add_column :blog_comments, :user_id, :integer
  end
end
