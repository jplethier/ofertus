#coding: UTF-8
class ApplicationController < ActionController::Base
  include DealsHelper

  # before_filter :go_to_facebook
  before_filter :delete_facebook_data, :set_current_tab
  before_filter :authenticate

  protect_from_forgery

  def user_cities_ids
    #TODO: user_session está sempre preenchida?
    user_session ||= {}
    user_session[:cities_ids] ||= current_user.cities.collect(&:id) if current_user
  end

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end

  rescue_from FbGraph::InvalidToken do |exception|
    sign_out :user
    redirect_to root_url
  end

  def error_routing
    redirect_to root_url, :alert => I18n.t("exceptions.page_does_not_exists")
  end

  rescue_from ActiveRecord::RecordNotFound do
    redirect_to root_url, :alert => I18n.t('exceptions.record_not_found')
  end

  rescue_from ActionController::ActionControllerError do
    redirect_to root_url
  end

  def failure
    redirect_to root_path, :alert => "Não foi possível efetuar o login via facebook."
  end

  def lomadee
    sale = nil
    if params.size > 2
      sale = Sale.register_lomadee(params)
      #executar codigo para salvar os dados do lomadee no banco
    end
    if sale.nil?
      Error.create(model_name: 'Vendas', message: 'Não foi enviado nenhum parâmetro')
      render 'Não foi enviado nenhum parametro'
    elsif sale.class.to_s == 'Sale'
      unless sale.user.blank?
        Notification.create(user: sale.user, message: "Você tem uma nova comissão <b>pendente</b> de <b style='color: #669900;'>#{price_to_currency sale.user_commission_value}</b>", url: sales_user_path(sale.user.username))
      end
      redirect_to "http://www.ofertus.com.br/pixel.png"
    else
      render sale[:error]
    end
  end

  def set_current_tab
    controller = params[:controller]
    if controller == 'deals'
      @current_tab = 'deals' if params[:action] == 'index'
      @current_tab = 'new_deal' if params[:action] == 'new'
    elsif controller == 'users'
      @current_tab = 'users' if params[:action] == 'index'
      @current_tab = 'my_profile' if params[:action] == 'show' && current_user && current_user.username == params[:id]
    else
      @current_tab = controller
    end
  end

  private

  def delete_facebook_data
    if session["devise.facebook_data"]
      session["devise.facebook_data"] = nil
    end
  end

  def verify_admin!
    if current_user
      unless current_user.admin?
        flash[:error] = I18n.t('admin.unauthorized')
        redirect_to root_path
      end
    else
      flash[:error] = I18n.t('devise.failure.unauthenticated')
      redirect_to root_path
    end
  end

  private

  def authenticate
    return true unless request.url.match('ofertus-test')
    authenticate_or_request_with_http_basic do |username, password|
      username == "ofertus" && password == "123ofertus"
    end
  end
end
