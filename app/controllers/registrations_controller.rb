#coding: UTF-8
class RegistrationsController < Devise::RegistrationsController
  skip_before_filter :delete_facebook_data, :only => [:new, :create]

  def create
    if not params[:terms_privacy]
      flash.now[:error] = I18n.t('strings.you_need_to_agree_with_terms_and_privacy')
      build_resource
      clean_up_passwords(resource)
      respond_with_navigational(resource) { render :new }
    else
      super
      if current_user
        if session[:invited_by]
          current_user.set_invited_by(session[:invited_by])
          User.check_inviteds_quantity(session[:invited_by])
        end
        if current_user.provider? && FbGraph::User.me(current_user.access_token).permissions.include?(:status_update)
          me = FbGraph::User.me(current_user.access_token)
          me.feed!( :message => current_user.name + " está usando o Ofertus para buscar e compartilhar ofertas!", :link => "http://www.ofertus.com.br", :description => "O Ofertus é uma plataforma social online voltada para a agregação de informações a respeito de ofertas em produtos e serviços, que permite a interação dos usuários através de ferramentas de relacionamento e compartilhamento, de modo a facilitar as decisões dos consumidores.", :picture => "http://www.ofertus.com.br/assets/logo_beta.png")
        end
      elsif session[:invited_by]  && @user.errors.count == 0
        User.check_inviteds_quantity(session[:invited_by])
        user = User.find_by_username(session[:invited_by])
        unless user.blank?
          Notification.create(user: user, message: "#{@user.name} se cadastrou no ofertus através do seu link de convite.", url: user_path(@user.username))
        end
      end
    end
  end

  def update
    if current_user.provider?
      self.resource = resource_class.to_adapter.get!(send(:"current_#{resource_name}").to_key)  
      if resource.update_attributes(params[resource_name])
        if is_navigational_format?
          if resource.respond_to?(:pending_reconfirmation?) && resource.pending_reconfirmation?
            flash_key = :update_needs_confirmation
          end
          set_flash_message :notice, flash_key || :updated
        end
        sign_in resource_name, resource, :bypass => true
        respond_with resource, :location => after_update_path_for(resource)
      else
        clean_up_passwords resource
        respond_with resource
      end
    else
      super
    end
  end

  private
  
  def build_resource(*args)
    super
    if session["devise.facebook_data"]
      @user = User.apply_omniauth(session["devise.facebook_data"])
      if params[:user]
        @user.name = params[:user][:name]
        @user.email = params[:user][:email]
        @user.username = params[:user][:username]
        @user.confirmed_at = Date.today
      end
      @user.valid?
    end
  end

  def after_update_path_for(resource)
    user_path(resource.username)
  end
end