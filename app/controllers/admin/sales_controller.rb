class Admin::SalesController < Admin::ApplicationController

  def index
    @sales = Sale.all
  end
end
