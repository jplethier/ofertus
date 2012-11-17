class Mobly

  def self.fill_deal_fields(link)
    page = Share.open_page(link)

    deal = Deal.new
    unless page.nil?
      deal.link = link
      deal.title = page.at_css(".prd-title").try(:text).try(:strip)[0,255] if page.at_css(".prd-title")
      
      deal.price_mask = page.at_css("#special_price_box").try(:text).try(:strip) if page.at_css("#special_price_box") && page.at_css("#special_price_box")

      deal.real_price_mask = page.at_css('#price_box').try(:text).try(:strip) if page.at_css('#price_box')

      deal.description = page.at_css(".prd-descriptionText").try(:text).try(:strip)[0,255] if page.at_css(".prd-descriptionText")
      deal.image_url = page.at_css("#prdImage")["src"].try(:strip) if page.at_css("#prdImage")
    end
    deal.category = Deal::CATEGORY_HOME_AND_DECORATION
    deal.company = "Mobly"
    
    deal
  end
  
end