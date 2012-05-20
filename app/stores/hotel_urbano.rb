# encoding: UTF-8

require 'open-uri'

class HotelUrbano

  def self.fill_deal_fields(link)
    page = Share.open_page(link)

    deal = Deal.new :link => link
    deal.title = page.at_css("title").try(:text).try(:strip)[0,255] if page.at_css("title") && page.at_css("title").try(:text)
    if page.at_css("#preco-oferta") && page.at_css("#preco-oferta").try(:text)
      precos = page.at_css("#preco-oferta").try(:text).try(:strip).split("R$").map(&:strip)
      deal.price_mask = precos[2].match(",") ? precos[2] : (precos[2] + ",00")
      deal.real_price_mask = precos[1].match(",") ? precos[1] : (precos[1] + ",00")
    end
    deal.description = page.at_css("#que-saber") if page.at_css("#que-saber")
    deal.category = Deal::CATEGORY_TRAVEL
    deal.company = "Hotel Urbano"
    deal.image_url = page.at_css("#imagem-oferta").at_xpath(".//img")[:src].try(:strip) if page.at_css("#imagem-oferta") && page.at_css("#imagem-oferta").at_xpath(".//img")
    #  #TODO: O método consegue setar city_id da oferta, mas não consegue exibir corretamente já na tela de cadastro de nova oferta
    #  deal.city = City.find_by_name(page.at_css("#headerCityButton").try(:text).try(:strip))
    #  if deal.city
    #    deal.city_id = deal.city.id
    #  end
    deal.kind = Deal::KIND_DAILY_DEAL

    deal
  end
end