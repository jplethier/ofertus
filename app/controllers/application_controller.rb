#coding: UTF-8
class ApplicationController < ActionController::Base
  # before_filter :go_to_facebook
  before_filter :delete_facebook_data, :set_current_tab

  protect_from_forgery

  def user_cities_ids
    #TODO: user_session está sempre preenchida?
    user_session ||= {}
    user_session[:cities_ids] ||= current_user.cities.collect(&:id) if current_user
  end

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end

  def error_routing
    redirect_to root_url, :alert => I18n.t("exceptions.page_does_not_exists")
  end

  rescue_from ActiveRecord::RecordNotFound do
    redirect_to root_url, :alert => I18n.t('exceptions.record_not_found')
  end

  def failure
    redirect_to root_path, :alert => "Não foi possível efetuar o login via facebook."
  end

  def set_current_tab
    controller = params[:controller]
    if controller == 'deals'
      @current_tab = 'active_deals' if params[:action] == 'index'
      @current_tab = 'today_deals' if params[:action] == 'today'
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

#  def authenticate
#    return true unless Rails.env == "production"
#    authenticate_or_request_with_http_basic do |username, password|
#      username == "dealwitme" && password == "123dealwitme"
#    end
#  end

  # def go_to_facebook
  #   redirect_to "https://www.facebook.com/OfertUs/app_151503908244383" if Rails.env == "production"
  # end
end
