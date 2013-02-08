# encoding: UTF-8
class Americanas

  CATEGORIES = {
    "ARTIGOS DE NATAL" => Deal::CATEGORY_OTHER,
    "AUTOMOTIVO" => Deal::CATEGORY_CAR,
    "BELEZA E SAÚDE" => Deal::CATEGORY_BEAUTY_AND_HEALTH,
    "BEBÊS" => Deal::CATEGORY_OTHER,
    "BRINQUEDOS" => Deal::CATEGORY_OTHER,
    "CAMA, MESA E BANHO" => Deal::CATEGORY_HOME_AND_APPLIANCE,
    "CÂMERAS E FILMADORAS" => Deal::CATEGORY_COMPUTER,
    "CELULARES E TELEFONES" => Deal::CATEGORY_COMPUTER,
    "DVDS E BLU-RAY" => Deal::CATEGORY_CULTURE,
    "ELETRODOMÉSTICOS" => Deal::CATEGORY_HOME_AND_APPLIANCE,
    "ELETRÔNICOS" => Deal::CATEGORY_COMPUTER,
    "ELETROPORTÁTEIS" => Deal::CATEGORY_HOME_AND_APPLIANCE,
    "ESPORTE E LAZER" => Deal::CATEGORY_ENTERTAINMENT,
    "FERRAMENTAS E JARDIM" => Deal::CATEGORY_HOME_AND_APPLIANCE,
    "INFORMÁTICA" => Deal::CATEGORY_COMPUTER,
    "LIVROS" => Deal::CATEGORY_CULTURE,
    "MÓVEIS E DECORAÇÃo" => Deal::CATEGORY_HOME_AND_DECORATION,
    "TV E HOME THEATER" => Deal::CATEGORY_COMPUTER,
    "UTILIDADES DOMÉSTICAS" => Deal::CATEGORY_HOME_AND_APPLIANCE
  }

  def self.fill_deal_fields(link)
    deal = Deal.new
    page = Share.open_page(link)

    unless page.nil?
      deal.link = link

      deal.title = page.at_css("title").try(:text).try(:strip)[0,255] if page.at_css('title')
      deal.price_mask = page.at_css(".sale strong").try(:text).try(:strip)[7..-1].try(:strip) if page.at_css(".sale strong") && page.at_css(".sale strong").try(:text)
      deal.real_price_mask = page.at_css(".regular").try(:text).try(:strip)[6..-1].try(:strip) if page.at_css(".regular") && page.at_css(".regular").try(:text)
      deal.description = page.at_css(".infoProdBox").to_s.truncate(4000) if page.at_css(".infoProdBox")
      deal.category = CATEGORIES[page.at_css(".category").try(:text).try(:strip).sub(">","")] if page.at_css(".category")
      deal.image_url = page.at_css("#imgProduto")["src"].try(:strip) if page.at_css("#imgProduto")
    end
    deal.company = 'Americanas'

    partner = Partner.find_by_name('Americanas')
    unless partner.blank?
      deal.partner = partner
    end

    deal
  end

end