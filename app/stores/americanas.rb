# encoding: UTF-8

require 'open-uri'

class Americanas

  CATEGORIES = {
    "AUTOMOTIVO" => Deal::CATEGORY_CAR,
    "BELEZA E SAÚDE" => Deal::CATEGORY_BEAUTY_AND_HEALTH,
    "BEBÊS" => Deal::CATEGORY_KIDS,
    "BRINQUEDOS" => Deal::CATEGORY_KIDS,
    "CAMA, MESA E BANHO" => Deal::CATEGORY_HOME_AND_APPLIANCE,
    "CÂMERAS E FILMADORAS" => Deal::CATEGORY_ELECTRONICS,
    "CELULARES E TELEFONES" => Deal::CATEGORY_ELECTRONICS,
    "DVDS E BLU-RAY" => Deal::CATEGORY_CULTURE,
    "ELETRODOMÉSTICOS" => Deal::CATEGORY_HOME_AND_APPLIANCE,
    "ELETRÔNICOS" => Deal::CATEGORY_ELECTRONICS,
    "ELETROPORTÁTEIS" => Deal::CATEGORY_HOME_AND_APPLIANCE,
    "ESPORTE E LAZER" => Deal::CATEGORY_FITNESS,
    "FERRAMENTAS E JARDIM" => Deal::CATEGORY_HOME_AND_APPLIANCE,
    "INFORMÁTICA" => Deal::CATEGORY_COMPUTER,
    "LIVROS" => Deal::CATEGORY_CULTURE,
    "MÓVEIS E DECORAÇÃo" => Deal::CATEGORY_HOME_AND_APPLIANCE,
    "UTILIDADES DOMÉSTICAS" => Deal::CATEGORY_HOME_AND_APPLIANCE  
  }

  def self.fill_deal_fields(link)
    deal = Deal.new :link => link
    page = Share.open_page(link)

    deal.title = page.at_css("title").try(:text).try(:strip)[0,255]
    deal.price_mask = page.at_css(".sale").try(:text).try(:strip)[7..-1].try(:strip) if page.at_css(".sale") && page.at_css(".sale").try(:text)
    deal.real_price_mask = page.at_css(".regular").try(:text).try(:strip)[6..-1].try(:strip) if page.at_css(".regular") && page.at_css(".regular").try(:text)
    deal.description = page.at_css(".infoProdBox") if page.at_css(".infoProdBox")
    deal.category = CATEGORIES[page.at_css(".category").try(:text).try(:strip).sub(">","")] if page.at_css(".category")
    deal.image_url = page.at_css("#imgProduto")["src"].try(:strip) if page.at_css("#imgProduto")
    deal.company = "Americanas"
    deal.kind = Deal::KIND_OFFER

    deal
  end

end