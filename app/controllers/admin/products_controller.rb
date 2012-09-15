class Admin::ProductsController < Admin::ApplicationController

  def index
    @products = Product.all
  end
end
