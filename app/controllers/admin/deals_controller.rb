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

  def favourite
    @deal = Deal.find(params[:id])
    @deal.ofertus_top = true
    if @deal.save(:validate => false)
      flash[:notice] = 'Oferta marcada como favorita com sucesso.'
    else
      flash[:error] = 'Ocorreu um erro'
    end
    redirect_to admin_deals_path
  end

  def unfavourite
    @deal = Deal.find(params[:id])
    @deal.ofertus_top = true
    if @deal.save(:validate => false)
      flash[:notice] = 'Oferta desmarcada como favorita com sucesso.'
    else
      flash[:error] = 'Ocorreu um erro'
    end
    redirect_to admin_deals_path
  end
end
