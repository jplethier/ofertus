# coding: utf-8
ActiveAdmin.register Deal do

  member_action :favourite, :method => :put do
    deal = Deal.find(params[:id])
    deal.favourite!
    Rails.cache.write("top_deals_#{Date.today.day}_#{Date.today.month}_#{Date.today.year}", Deal.active.top.limit(6).all)
    redirect_to env['HTTP_REFERER'], :notice => "Oferta marcada como favorita!"
  end

  member_action :unfavourite, :method => :put do
    deal = Deal.find(params[:id])
    deal.unfavourite!
    Rails.cache.write("top_deals_#{Date.today.day}_#{Date.today.month}_#{Date.today.year}", Deal.active.top.limit(6).all)
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

  show title: :title do |deal|
    attributes_table do
      row 'Ativa?' do
        if deal.end_date.end_of_day > Date.today.beginning_of_day
          'Sim'
        else
          'Nao'
        end
      end
      row 'Foto' do
        image_tag(deal.image_url)
      end
      row :description do
        deal.description.html_safe
      end
      row :price
      row :real_price
      row :discount
      row :user
      row :link do
        link_to deal.link, deal.link, target: '_blank'
      end
      row :company
      row :visits
      row :category do
        Deal.i18n_category(deal.category)
      end
      row 'Favorita' do
        if deal.ofertus_top
          link_to 'Desmarcar', unfavourite_admin_deal_path(deal), :method => :put
        else
          link_to 'Marcar', favourite_admin_deal_path(deal), :method => :put
        end
      end
    end

    active_admin_comments
  end
end
