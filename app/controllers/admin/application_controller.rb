class Admin::ApplicationController < ApplicationController
  before_filter :set_current_tab

  def set_current_tab
    @current_tab = 'admin'
  end
end
