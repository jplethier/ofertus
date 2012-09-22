# coding: utf-8
ActiveAdmin.register Deal do

  member_action :favourite, :method => :put do
    deal = Deal.find(params[:id])
    binding.pry
    deal.favourite!
    redirect_to env['HTTP_REFERER'], :notice => "Oferta marcada como favorita!"
  end

  member_action :unfavourite, :method => :put do
    deal = Deal.find(params[:id])
    deal.unfavourite!
    redirect_to env['HTTP_REFERER'], :notice => "Oferta desmarcada como favorita!"
  end

  scope :active
  scope :inactive
  scope :voted
  scope :most_commented
  scope :today

  index do
    column 'Titulo' do |deal|
      truncate_title deal.title
    end
    column 'Usuário' do |deal|
      link_to deal.user.name, [:admin, deal.user]
    end
    column 'Preço Real' do |deal|
      price_to_currency deal.real_price
    end
    column 'Preço Promocional' do |deal|
      price_to_currency deal.price
    end
    column 'Desconto', :discount
    column 'Favorita' do |deal|
      if deal.ofertus_top
        link_to 'Desmarcar', unfavourite_admin_deal_path(deal), :method => :put
      else
        link_to 'Marcar', favourite_admin_deal_path(deal), :method => :put
      end
    end
    default_actions
  end
end
