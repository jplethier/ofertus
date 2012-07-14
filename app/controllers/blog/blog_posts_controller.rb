class Blog::BlogPostsController < ApplicationController

  def index
    @blog_posts = BlogPost.all  
  end

  def new
    @blog_post = BlogPost.new
  end

end
