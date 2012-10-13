# coding: UTF-8
class UsersController < ApplicationController
  before_filter :find_user_with_deals, :only => :show
  prepend_before_filter :find_users, :only => :index
  # before_filter :authenticate_user!

  check_authorization
  load_and_authorize_resource :find_by => :username

  def show
    @title = @user.username
  end

  def index
    flash.now[:notice] = "Não foi encontrado nenhum usuário" if @users.empty? && params[:search]
    @title = "Buscar Usuários"
  end

  def invite
    if User.find_by_username(params[:username])
      session[:invited_by] = params[:username]
      redirect_to new_user_registration_path
    else
      redirect_to root_path
    end
  end

  def followers
  end

  def following
  end

  #Lembrar de dar Reset Ability (CanCan)
  #def update
  #end

  def follow
    unless current_user.follow? @user
      current_user.follow! @user
      if current_user.provider? && current_user.facebook_follow_user && FbGraph::User.me(current_user.access_token).permissions.include?(:status_update)
        me = FbGraph::User.me(current_user.access_token)
        me.feed!(:message => current_user.name + " está seguindo as ofertas de " + @user.name + " no Ofertus", :link => user_url(@user), :picture => "http://www.ofertus.com.br/assets/logo_beta.png")
      end
      redirect_to env['HTTP_REFERER'], :notice => I18n.t('models.user.started_following', :username => @user.username)
    else
      redirect_to env['HTTP_REFERER'], :alert => I18n.t('models.user.already_following', :username => @user.username)
    end
  end

  def unfollow
    if current_user.follow? @user
      current_user.unfollow! @user
      redirect_to env['HTTP_REFERER'], notice: I18n.t('models.user.stopped_following', username: @user.username)
    else
      redirect_to env['HTTP_REFERER'], alert: I18n.t('models.user.not_following', username: @user.username)
    end
  end

  private

  def find_user_with_deals
    if User.find_by_username(params[:id])
      @deals = Deal.by_username_and_following(params[:id]).paginate(:page => params[:page]).order('created_at DESC')
    end
  end

  def find_users
    @users = User.paginate(:page => params[:page])
    @users = @users.search(params[:search].gsub(" ", "%")) if params[:search]
    @users_with_more_deals = User.order_by_deals.limit(5)
  end
end
