# coding: utf-8
ActiveAdmin.register Sale do
  member_action :confirm, :method => :put do
    sale = Sale.find(params[:id])
    sale.update_attributes(status: Sale::CONFIRMED)
    redirect_to env['HTTP_REFERER'], :notice => "Venda confirmada!"
  end

  member_action :pending, :method => :put do
    sale = Sale.find(params[:id])
    sale.update_attributes(status: Sale::PENDING)
    redirect_to env['HTTP_REFERER'], :notice => "Venda marcada como pendente!"
  end

  member_action :cancel, :method => :put do
    sale = Sale.find(params[:id])
    sale.update_attributes(status: Sale::CANCELLED)
    redirect_to env['HTTP_REFERER'], :notice => "Venda marcada como pendente!"
  end

  index do
    column 'Loja' do |sale|
      if sale.partner
        truncate_title sale.partner.name
      else
        '-'
      end
    end
    column 'Usuário' do |sale|
      if sale.user
        link_to sale.user.name, [:admin, sale.user]
      else
        'Sem usuário'
      end
    end
    column 'Comissão' do |sale|
      price_to_currency sale.commission_value
    end
    column 'Comissão do Usuário' do |sale|
      price_to_currency sale.user_commission_value
    end
    column 'Status' do |sale|
      Sale.i18n_status(sale.status)
    end
    column '' do |sale|
      link_to 'Confirmar', confirm_admin_sale_path(sale), :method => :put
    end
    column '' do |sale|
      link_to 'Pendente', pending_admin_sale_path(sale), :method => :put
    end
    column '' do |sale|
      link_to 'Cancelar', cancel_admin_sale_path(sale), :method => :put
    end
    default_actions
  end
end
