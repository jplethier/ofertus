# coding: UTF-8
class Blog::BlogPostsController < ApplicationController

  def index
    @blog_posts = BlogPost.all  
  end

  def new
    @blog_post = BlogPost.new
  end

  def show
    binding.pry
    if params[:post_name] == 'new'
      redirect_to new_blog_blog_post_path
    else
    end
  end

  def create
    @blog_post = BlogPost.new(params[:blog_post])
    if @blog_post.save!
      redirect_to blog_root_path
    else
      render 'new'
    end
  end

end
