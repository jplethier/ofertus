#coding: utf-8
ActiveAdmin.register Partner do

  scope :active
  scope :inactive
  scope :promotion

  index do
    column 'Logo' do |partner|
      image_tag(partner.mini_image_url)
    end
    column 'Nome', :name
    column 'Código', :code
    column 'Ativo?', :active
    column 'URL' do |partner|
      link_to partner.url, partner.url, target: '_blank'
    end
    default_actions
  end
end