# encoding: UTF-8

require 'open-uri'

class Carrefour

  CATEGORIES = {
    "Automotivo" => Deal::CATEGORY_CAR,
    "Bebês" => Deal::CATEGORY_KIDS,
    "Beleza e Saúde" => Deal::CATEGORY_BEAUTY_AND_HEALTH,
    "Brinquedos" => Deal::CATEGORY_KIDS,
    "Cama, Mesa e Banho" => Deal::CATEGORY_HOME_AND_APPLIANCE,
    "Cine e Foto" => Deal::CATEGORY_ELECTRONICS,
    "Eletrodomésticos" => Deal::CATEGORY_HOME_AND_APPLIANCE,
    "Eletroportáteis" => Deal::CATEGORY_ELECTRONICS,
    "Esporte e Lazer" => Deal::CATEGORY_FITNESS,
    "Ferramentas" => Deal::CATEGORY_OTHER,
    "Games" => Deal::CATEGORY_KIDS,
    "Imagem" => Deal::CATEGORY_ELECTRONICS,
    "Informática" => Deal::CATEGORY_COMPUTER,
    "Móveis e Decoração" => Deal::CATEGORY_HOME_AND_APPLIANCE,
    "Perfumes e Cosméticos" => Deal::CATEGORY_BEAUTY_AND_HEALTH,
    "Som" => Deal::CATEGORY_ELECTRONICS,
    "Tapetes e Cortinas" => Deal::CATEGORY_HOME_AND_APPLIANCE,
    "Telefonia" => Deal::CATEGORY_ELECTRONICS,
    "Utilidades Domésticas" => Deal::CATEGORY_HOME_AND_APPLIANCE
  }

  def self.fill_deal_fields(link)
    deal = Deal.new :link => link
    page = Share.open_page(link)
    deal.title = page.at_css(".infos").at_xpath(".//h1").try(:text).try(:strip)[0,255] if page.at_css(".infos") && page.at_css(".infos").at_xpath(".//h1").try(:text)
    deal.title = page.at_css(".breadcrumb").at_xpath(".//h1").try(:text).try(:strip)[0,255] if page.at_css(".breadcrumb") && page.at_css(".breadcrumb").at_xpath(".//h1").try(:text)
    deal.price_mask = page.at_css(".valorPor").try(:text).split(" ")[2] if page.at_css(".valorPor").try(:text)
    deal.real_price_mask = page.at_css(".valorDe").try(:text).split(" ")[2] if page.at_css(".valorDe").try(:text)
    deal.description = page.at_css("#visao-geral").try(:text).try(:strip)[0,1200] if page.at_css("#visao-geral").try(:text)
    deal.category = CATEGORIES[page.at_css(".breadcrumb").at_xpath(".//strong").try(:text).split(" ")[2]] if page.at_css(".breadcrumb") && page.at_css(".breadcrumb").at_xpath(".//strong").try(:text)
    deal.image_url = page.at_css(".lp-prod").at_xpath(".//img")[:src] if page.at_css(".lp-prod")
    deal.image_url = page.at_css(".viewBoxMedia").at_xpath(".//img")[:src] if page.at_css(".viewBoxMedia")
    deal.company = "Carrefour"
    deal.kind = Deal::KIND_OFFER

    deal
  end
end