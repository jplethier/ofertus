# encoding: UTF-8

require 'open-uri'

class Leader

  CATEGORIES = {
    "Bebês" => Deal::CATEGORY_KIDS,
    "Beleza & Saúde" => Deal::CATEGORY_BEAUTY_AND_HEALTH,
    "Brinquedos" => Deal::CATEGORY_KIDS,
    "Calçados e Acessórios" => Deal::CATEGORY_CLOTHES,
    "Cama, Mesa e Banho" => Deal::CATEGORY_HOME_AND_APPLIANCE,
    "Cine e Foto" => Deal::CATEGORY_ELECTRONICS,
    "Eletrodomésticos" => Deal::CATEGORY_HOME_AND_APPLIANCE,
    "Eletrônicos" => Deal::CATEGORY_ELECTRONICS,
    "Esporte e Lazer" => Deal::CATEGORY_FITNESS,
    "Eletroportáteis" => Deal::CATEGORY_ELECTRONICS,
    "Games" => Deal::CATEGORY_KIDS,
    "Informática" => Deal::CATEGORY_COMPUTER,
    "Moda" => Deal::CATEGORY_CLOTHES,
    "Mode Íntima" => Deal::CATEGORY_CLOTHES,
    "Móveis" => Deal::CATEGORY_HOME_AND_APPLIANCE,
    "Relógios" => Deal::CATEGORY_OTHER,
    "Telefonia" => Deal::CATEGORY_ELECTRONICS,
    "Utilidades Domésticas" => Deal::CATEGORY_HOME_AND_APPLIANCE
  }

  def fill_deal_fields(link)
    page = Share.open_page(link)

    deal = Deal.new :link => link
    deal.title = page.at_css(".name").try(:text).try(:strip)[0,255] if page.at_css(".name") && page.at_css(".name").try(:text)
    deal.price_mask = page.at_css(".sale").try(:text).try(:strip)[7..-1].try(:strip) if page.at_css(".sale") && page.at_css(".sale").try(:text)
    deal.real_price_mask = page.at_css(".regular").try(:text).try(:strip)[6..-1].try(:strip) if page.at_css(".regular") && page.at_css(".regular").try(:text)
    deal.description = page.at_css("#descricao").try(:text).try(:strip)[0,1200] if page.at_css("#descricao") && page.at_css("#descricao").try(:text)
    deal.category = CATEGORIES[page.at_css("#ctl00_BreadCrumb_lnkDepartamento").try(:text).try(:strip)] if page.at_css("#ctl00_BreadCrumb_lnkDepartamento") && page.at_css("#ctl00_BreadCrumb_lnkDepartamento").try(:text)
    deal.image_url = page.at_css(".fotoPrincipal").at_xpath(".//img")[:src].try(:strip) if page.at_css(".fotoPrincipal") && page.at_css(".fotoPrincipal").at_xpath(".//img")
    deal.company = "Leader"
    deal.kind = Deal::KIND_OFFER

    deal
  end  
end