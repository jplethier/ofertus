class Admin::DealsController < Admin::ApplicationController
  def index
    @deals = Deal.recent
  end
end
