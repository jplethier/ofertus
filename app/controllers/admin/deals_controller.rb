class Admin::DealsController < Admin::ApplicationController
  def index
    @deals = Deal.recent
  end

  def show
    
  end

  def edit
    
  end

  def new
    
  end
end
