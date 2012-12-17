class AmoMuito
  
  def self.fill_deal_fields(link)
    deal = Deal.new
    page = Share.open_page(link)

    unless page.nil?
      deal.title = page.at_css("#pb-left-column h1").try(:text).try(:strip)[0,255] if page.at_css("#pb-left-column h1")
      deal.real_price_mask = page.at_css("#old_price_display").try(:text).try(:strip).split('$')[1] if page.at_css("#old_price_display")
      deal.price_mask = page.at_css(".our_price_display span").try(:text).try(:strip).split('$')[1] if page.at_css(".our_price_display span").try(:text)
      deal.description = page.at_css("#idTab1").try(:text).truncate(4000) if page.at_css("#idTab1")
      deal.image_url = page.at_css("#image-block img")[:src].try(:strip) if page.at_css("#image-block img") && page.at_css("#image-block img")[:src]
    end
    deal.category = Deal::CATEGORY_CLOTHES
    deal.link = link
    deal.company = "AmoMuito"

    deal
  end
end