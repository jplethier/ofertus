# coding: utf-8
ActiveAdmin.register Notification do
  scope :admin

  index do
    column 'Mensagem' do |notification|
      raw notification.message
    end
    column 'Usuário' do |notification|
      if !notification.user.blank?
        link_to notification.user.name, [:admin, notification.user]
      else
        'Pedido de Resgate'
      end
    end
    column 'Status' do |notification|
      Notification.i18n_status(notification.status)
    end
    column 'URL' do |notification|
      link_to notification.url, notification.url, target: '_blank'
    end
    default_actions
  end
end