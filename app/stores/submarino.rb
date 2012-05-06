class Submarino
  
  def self.fill_deal_fields(link)
    page = Share.open_page(link)

    deal = Deal.new :link => link
    deal.title = page.at_css("title").try(:text).try(:strip)[0,255]
    if page.at_css(".for").try(:text) && page.at_css(".ficheTechnique").try(:text)
      deal.price_mask = page.at_css(".for").try(:text).try(:strip)[7..-1].try(:strip)
      deal.real_price_mask = page.at_css(".from").try(:text).try(:strip)[6..-1].try(:strip)
      deal.description = page.at_css(".ficheTechnique").try(:text).try(:strip)[0,1200]
      #deal.category = CATEGORIES[page.at_css(".selected").try(:text).try(:strip)]
      deal.image_url = page.at_css("#baseImg")[:src].try(:strip)
    end
    deal.company = "Submarino"
    deal.kind = Deal::KIND_OFFER

    deal
  end
end