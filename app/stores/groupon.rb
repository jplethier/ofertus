# encoding: UTF-8

require 'open-uri'

class Groupon

  def self.fill_deal_fields(link)
    page = Share.open_page(link)

    deal = Deal.new
    unless page.nil?
      deal.link = link
      deal.title = page.at_css("#contentDealTitle").try(:text).try(:strip)[0,255] if page.at_css("#contentDealTitle")
      deal.price_mask = page.at_css(".noWrap").try(:text).try(:strip)[3..-1].try(:strip) if page.at_css(".noWrap")
      #deal.real_price_mask = page.at_css(".regular").try(:text).try(:strip)[6..-1].try(:strip)
      deal.description = page.at_css(".contentDealDescriptionFacts").to_s.truncate(4000) if page.at_css(".contentDealDescriptionFacts")
      deal.image_url = page.at_css(".nobg").at_xpath(".//img")[:src].try(:strip) if page.at_css(".nobg")
    end
    deal.company = "Groupon"

    partner = Partner.find_by_name('Groupon')
    unless partner.blank?
      deal.partner = partner
    end

    #TODO: O método consegue setar city_id da oferta, mas não consegue exibir corretamente já na tela de cadastro de nova oferta
    #deal.city = City.find_by_name(page.at_css("#headerCityButton").try(:text).try(:strip))
    #if deal.city
    #  deal.city_id = deal.city.id
    #end

    deal
  end

end