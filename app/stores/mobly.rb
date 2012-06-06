class Mobly

  def self.fill_deal_fields(link)
    deal = Deal.new :link => link
    page = Share.open_page(link)

    deal.title = page.at_css(".prd-title").try(:text).try(:strip)[0,255] if page.at_css(".prd-title")
    deal.price_mask = page.at_css("#special_price_box").try(:text).split(" ")[1] if page.at_css("#special_price_box") && page.at_css("#special_price_box").try(:text)
    deal.real_price_mask = page.at_css("#price_box").try(:text).split(" ")[1] if page.at_css("#price_box") && page.at_css("#price_box").try(:text)
    deal.description = page.at_css(".prd-descriptionText").try(:text).try(:strip)[0,255] if page.at_css(".prd-descriptionText")
    deal.category = Deal::CATEGORY_KIDS
    deal.image_url = page.at_css("#prdImage")["src"].try(:strip) if page.at_css("#prdImage")
    deal.company = "Mobly"
    deal.kind = Deal::KIND_OFFER

    deal
  end
  
end