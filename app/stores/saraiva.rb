# encoding: UTF-8
class Saraiva
  
  CATEGORIES = {
    "Livros" => Deal::CATEGORY_CULTURE,
    "Livros Importados" => Deal::CATEGORY_CULTURE,
    "Livros Digitais" => Deal::CATEGORY_CULTURE,
    "Tablets" => Deal::CATEGORY_COMPUTER,
    "Filmes Digitais" => Deal::CATEGORY_CULTURE,
    "Filmes" => Deal::CATEGORY_CULTURE,
    "Shows" => Deal::CATEGORY_CULTURE,
    "Cds" => Deal::CATEGORY_CULTURE,
    "Mp3 e Ipod" => Deal::CATEGORY_COMPUTER,
    "Mp3/mp4/mp5/ipod" => Deal::CATEGORY_COMPUTER,
    "Brinquedos" => Deal::CATEGORY_OTHER,
    "Revelação Digital" => Deal::CATEGORY_OTHER,
    "Cine e Foto" => Deal::CATEGORY_OTHER,
    "Papelaria" => Deal::CATEGORY_OTHER,
    "Games" => Deal::CATEGORY_ENTERTAINMENT,
    "Software" => Deal::CATEGORY_COMPUTER,
    "Informática" => Deal::CATEGORY_COMPUTER,
    "Eletrônicos" => Deal::CATEGORY_COMPUTER,
    "Eletroportáteis" => Deal::CATEGORY_HOME_AND_APPLIANCE,
    "Telefonia" => Deal::CATEGORY_COMPUTER,
    "Beleza e Saúde" => Deal::CATEGORY_BEAUTY_AND_HEALTH
  }

  def self.fill_deal_fields(link)
    page = Share.open_page(link)

    deal = Deal.new
    unless page.nil?
      deal.link = link
      deal.title = page.at_css("#tituloprod").try(:text).try(:strip)[0,255] if page.at_css("#tituloprod")
      deal.price_mask = page.at_css(".precoPor").try(:text).try(:strip)[6..-1].try(:strip) if page.at_css(".precoPor")
      deal.real_price_mask = page.at_css(".precoDe").try(:text).try(:strip)[5..-1].try(:strip) if page.at_css(".precoDe")
      deal.description = page.at_css("#PassosConteudo").to_s.truncate(4000) if page.at_css("#PassosConteudo")
      deal.category = CATEGORIES[page.at_css("#breadcumbs").try(:text).split('►')[1].try(:strip)] if page.at_css("#breadcumbs")
      deal.image_url = page.at_css("#imgProd")[:src].try(:strip) if page.at_css("#imgProd")
    end
    
    deal.company = "Saraiva"

    deal
  end
  
end