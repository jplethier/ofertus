class Kanui
  
  def self.fill_deal_fields(link)
    deal = Deal.new
    page = Share.open_page(link)

    unless page.nil?
      deal.link = link

      deal.title = page.at_css("h1.prd-title").try(:text).try(:strip)[0,255] if page.at_css("h1.prd-title").try(:text)
      deal.real_price_mask = page.at_css("span#price_box").try(:text).try(:strip).split(' ')[1] if page.at_css("span#price_box").try(:text)
      deal.price_mask = page.at_css("span#special_price_box").try(:text).try(:strip).split(' ')[1] if page.at_css("span#special_price_box").try(:text)
      deal.description = page.at_css("#productDetails").try(:text).truncate(4000) if page.at_css("#productDetails")
      deal.category = Deal::CATEGORY_CLOTHES
      deal.image_url = page.at_css("#prdZoomBox span img")[:src].try(:strip) if page.at_css("#prdZoomBox span img") && page.at_css("#prdZoomBox span img")[:src]
      deal.company = "Kanui"
    end

    deal
  end
end