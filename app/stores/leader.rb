# encoding: UTF-8

require 'open-uri'

class Leader

  CATEGORIES = {
    "Bebês" => Deal::CATEGORY_OTHER,
    "Beleza & Saúde" => Deal::CATEGORY_BEAUTY_AND_HEALTH,
    "Brinquedos" => Deal::CATEGORY_OTHER,
    "Calçados e Acessórios" => Deal::CATEGORY_CLOTHES,
    "Cama, Mesa e Banho" => Deal::CATEGORY_HOME_AND_APPLIANCE,
    "Cine e Foto" => Deal::CATEGORY_COMPUTER,
    'Celulares' => Deal::CATEGORY_COMPUTER,
    "Eletrodomésticos" => Deal::CATEGORY_HOME_AND_APPLIANCE,
    "Eletrônicos" => Deal::CATEGORY_COMPUTER,
    "Esporte e Lazer" => Deal::CATEGORY_ENTERTAINMENT,
    "Eletroportáteis" => Deal::CATEGORY_COMPUTER,
    "Games" => Deal::CATEGORY_OTHER,
    "Informática" => Deal::CATEGORY_COMPUTER,
    "Moda" => Deal::CATEGORY_CLOTHES,
    "Mode Íntima" => Deal::CATEGORY_CLOTHES,
    "Móveis" => Deal::CATEGORY_HOME_AND_APPLIANCE,
    "Relógios" => Deal::CATEGORY_OTHER,
    "Telefonia" => Deal::CATEGORY_COMPUTER,
    "Utilidades Domésticas" => Deal::CATEGORY_HOME_AND_APPLIANCE
  }

  def self.fill_deal_fields(link)
    page = Share.open_page(link)

    deal = Deal.new
    unless page.nil?
      deal.title = page.at_css(".productName").try(:text).try(:strip)[0,255] if page.at_css(".productName") && page.at_css(".productName").try(:text)
      deal.price_mask = page.at_css(".valor-por strong").try(:text).split[1] if page.at_css(".valor-por strong").try(:text) && page.at_css(".valor-por strong").try(:text).split
      deal.real_price_mask = page.at_css(".valor-de strong").try(:text).split[1] if page.at_css(".valor-de strong").try(:text) && page.at_css(".valor-de strong").try(:text).split

      deal.description = page.at_css(".productDescription").try(:text).truncate(4000) if page.at_css(".productDescription").try(:text)
      deal.category = CATEGORIES[page.at_css(".bread-crumb").try(:text).split[1]] if page.at_css(".bread-crumb").try(:text)
      # binding.pry
      if page.at_css("#image-main") && page.at_css("#image-main")[:src]
        deal.image_url = 'http://www.leader.com.br/' + page.at_css("#image-main")[:src]
      end
    end
    deal.link = link
    deal.company = "Leader"

    partner = Partner.find_by_name('Leader')
    unless partner.blank?
      deal.partner = partner
    end

    deal
  end
end