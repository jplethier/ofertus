# coding: UTF-8
class Blog::BlogPostsController < AuthorizedController
  skip_before_filter :authenticate_user!, :only => [:index, :show]

  def index
    @blog_posts = BlogPost.all  
  end

  def new
    @blog_post = BlogPost.new
  end

  def show
    @blog_post = BlogPost.find_by_url(params[:post_title])

  end

  def create
    @blog_post = BlogPost.new(params[:blog_post])
    @blog_post.user = current_user
    if @blog_post.save!
      redirect_to blog_root_path
    else
      render 'new'
    end
  end

  def edit
    @blog_post = BlogPost.find_by_url(params[:post_title])
  end

  def update
    @blog_post = BlogPost.find(params[:id])
    if BlogPost.update(@blog_post, params[:blog_post])
      redirect_to blog_root_path
    else
      render 'edit'
    end
  end

end
