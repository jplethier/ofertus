# coding: UTF-8
class UsersController < ApplicationController
  before_filter :find_user_with_deals, :only => :show
  prepend_before_filter :find_users, :only => :index
  before_filter :authenticate_user!, only: [:update, :sales, :withdraw, :follow, :unfollow]

  check_authorization
  load_and_authorize_resource :find_by => :username

  def update
    if current_user.update_attributes(params[:user])
      current_user.withdraw
      redirect_to sales_user_path(current_user.username), notice: 'Resgate pedido com sucesso.'
    else
      render 'withdraw'
    end
  end

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
    @followers = @user.followers.paginate(page: params[:page], per_page: 12)
  end

  def following
    @following = @user.following.paginate(page: params[:page], per_page: 12)
  end

  def sales
    # verificar o porque que o cancan nao está funcionando para as actions desse controller
    if current_user != @user
      redirect_to root_path
    end
    @sales = @user.sales.recent
    @deals = @user.deals.recent
  end

  def friends
    # verificar o porque que o cancan nao está funcionando para as actions desse controller
    if current_user != @user
      redirect_to root_path
    end
  end

  def withdraw
    # verificar o porque que o cancan nao está funcionando para as actions desse controller
    if current_user != @user
      redirect_to root_path
    end
    if @user.credit < 50.0
      redirect_to sales_user_path(@user.username), alert: I18n.t('strings.minimum_to_withdraw')
    end
  end

  def follow
    unless current_user.follow? @user
      current_user.follow! @user
      if current_user.provider? && current_user.facebook_follow_user && FbGraph::User.me(current_user.access_token).permissions.include?(:status_update)
        me = FbGraph::User.me(current_user.access_token)
        me.feed!(:message => current_user.name + " está seguindo as ofertas de " + @user.name + " no Ofertus", :link => user_url(@user.username), :picture => "http://www.ofertus.com.br/assets/logo_beta.png")
      end
      Notification.create(user: @user, message: "<b>#{current_user.name}</b> está te seguindo. Visite o perfil dele(a) para ver as ofertas compartilhadas por ele(a).", url: user_path(current_user.username))
      if request.xhr?
        render json: { status: 'sucesso', message: I18n.t('models.user.started_following', :username => @user.username) }
      else
        redirect_to env['HTTP_REFERER'], :notice => I18n.t('models.user.started_following', :username => @user.username)
      end
    else
      if request.xhr?
        render json: { status: 'erro', message: I18n.t('models.user.already_following', :username => @user.username) }
      else
        redirect_to env['HTTP_REFERER'], :alert => I18n.t('models.user.already_following', :username => @user.username)
      end
    end
  end

  def unfollow
    if current_user.follow? @user
      current_user.unfollow! @user
      if request.xhr?
        render json: { status: 'sucesso', message: I18n.t('models.user.stopped_following', username: @user.username) }
      else
        redirect_to env['HTTP_REFERER'], notice: I18n.t('models.user.stopped_following', username: @user.username)
      end
    else
      if request.xhr?
        render json: { status: 'sucesso', message: I18n.t('models.user.not_following', username: @user.username) }
      else
        redirect_to env['HTTP_REFERER'], alert: I18n.t('models.user.not_following', username: @user.username)
      end
    end
  end

  private

  def find_user_with_deals
    if User.find_by_username(params[:id])
      @deals = Deal.by_username_and_following(params[:id]).paginate(:page => params[:page]).order('created_at DESC')
    end
  end

  def find_users
    @users = User.paginate(page: params[:page], per_page: 12)
    @users = @users.search(params[:search].gsub(" ", "%")) if params[:search]
    @users = @users.send(params[:search_scope].to_sym) unless params[:search_scope].blank?
  end
end
