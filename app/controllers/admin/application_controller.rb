class Admin::ApplicationController < AuthorizedController
  before_filter :set_current_tab
  before_filter :verify_admin

  layout 'admin'

  def set_current_tab
    @current_tab = 'admin'
  end

  def verify_admin
    unless current_user.admin?
      flash[:error] = I18n.t('admin.unauthorized')
      redirect_to root_path
    end
  end
end
