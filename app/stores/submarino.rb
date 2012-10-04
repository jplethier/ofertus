class Submarino
  
  def self.fill_deal_fields(link)
    page = Share.open_page(link)

    deal = Deal.new
    unless page.nil?
      deal.link = link
      deal.title = page.at_css("title").try(:text).try(:strip)[0,255] if page.at_css("title")
      deal.price_mask = page.at_css(".for").try(:text).try(:strip)[7..-1].try(:strip) if page.at_css(".for")
      deal.real_price_mask = page.at_css(".from").try(:text).try(:strip)[6..-1].try(:strip) if page.at_css(".from")
      deal.description = page.at_css(".ficheTechnique").to_s.truncate(4000) if page.at_css(".ficheTechnique")
      #deal.category = CATEGORIES[page.at_css(".selected").try(:text).try(:strip)]
      deal.image_url = page.at_css("#baseImg")[:src].try(:strip) if page.at_css("#baseImg")
    end
    deal.company = "Submarino"
    
    deal
  end
end