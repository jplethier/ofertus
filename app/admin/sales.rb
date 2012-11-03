# coding: utf-8
ActiveAdmin.register Sale do
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
    default_actions
  end
end
