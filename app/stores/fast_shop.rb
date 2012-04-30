# encoding: UTF-8

require 'open-uri'

class FastShop

  CATEGORIES = {
    "Áudio" => Deal::CATEGORY_ELECTRONICS,
    "Vídeo" => Deal::CATEGORY_ELECTRONICS,
    "Cine e Foto" => Deal::CATEGORY_ELECTRONICS,
    "Eletrodomésticos" => Deal::CATEGORY_HOME_AND_APPLIANCE,
    "Portáteis" => Deal::CATEGORY_ELECTRONICS,
    "Utensílios Domésticos" => Deal::CATEGORY_HOME_AND_APPLIANCE,
    "Informática" => Deal::CATEGORY_COMPUTER,
    "Telefonia" => Deal::CATEGORY_ELECTRONICS,
    "Apple" => Deal::CATEGORY_COMPUTER,
    "Games" => Deal::CATEGORY_KIDS,
    "Tablet" => Deal::CATEGORY_ELECTRONICS
  }

  def self.fill_deal_fields(link)
    page = Share.open_page(link)

    deal = Deal.new :link => link
    deal.title = page.at_css("h1.name").try(:text).try(:strip)[0,255] if page.at_css("h1.name") && page.at_css("h1.name").try(:text)
    deal.price_mask = page.at_css(".price").try(:text).split(" ")[5] if page.at_css(".price") && page.at_css(".price").try(:text)
    deal.real_price_mask = page.at_css(".price").try(:text).split(" ")[2] if page.at_css(".price") && page.at_css(".price").try(:text)
    deal.description = page.at_css("#divDescr1").try(:text).try(:strip)[0,1200] if page.at_css("#divDescr1") && page.at_css("#divDescr1").try(:text)
    deal.category = CATEGORIES[page.at_css(".breadcrumb").try(:text).try(:strip).split(" ")[1]] if page.at_css(".breadcrumb") && page.at_css(".breadcrumb").try(:text)
    deal.image_url = page.at_css(".photo").at_xpath(".//input")[:src] if page.at_css(".photo") && page.at_css(".photo").at_xpath(".//input")
    deal.company = "Fast Shop"
    deal.kind = Deal::KIND_OFFER

    deal
  end
end