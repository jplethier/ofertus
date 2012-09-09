class Admin::ApplicationController < AuthorizedController
  before_filter :set_current_tab
  before_filter :verify_admin

  layout 'admin'

  def set_current_tab
    @current_tab = 'admin'
  end

  def verify_admin
    redirect_to root_path unless current_user.admin?
  end
end
