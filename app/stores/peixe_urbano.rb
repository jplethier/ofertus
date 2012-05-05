class PeixeUrbano

  def self.fill_deal_fields(link)
    page = Share.open_page(link)

    deal = Deal.new :link => link
    deal.title = page.at_css('title').try(:text).try(:strip)[0,255]
    if page.at_css(".new_price").try(:text)
      deal.price_mask = page.at_css(".new_price").try(:text).try(:strip)[2..-1].try(:strip)
      if not deal.price_mask.match(",")
        deal.price_mask = deal.price_mask + ",00"
      end
      deal.real_price_mask = page.at_css(".old_price").try(:text).try(:strip)[2..-1].try(:strip)
      if not deal.real_price_mask.match(",")
        deal.real_price_mask = deal.real_price_mask + ",00"
      end
      deal.description = page.at_css(".deal_details").try(:text).try(:strip)[0,1200]
      deal.company = page.at_css("#CompanyName").try(:text).try(:strip)
      deal.image_url = page.at_css(".deal_photo").at_xpath(".//img")["src"].try(:strip)
    #TODO: O método consegue setar city_id da oferta, mas não consegue exibir corretamente já na tela de cadastro de nova oferta
    #  deal.city = City.find_by_name(page.at_css("#city_name").try(:text).try(:strip))
    #  if deal.city
    #    deal.city_id = deal.city.id
    #  end
    end
    deal.kind = Deal::KIND_DAILY_DEAL

    deal
  end
  
end