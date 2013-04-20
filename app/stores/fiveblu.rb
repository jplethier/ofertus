class Fiveblu

  def self.fill_deal_fields(link)
    deal = Deal.new
    page = Share.open_page(link)

    unless page.nil?

      deal.title = page.at_css(".product-name").try(:text).try(:strip)[0,255] if page.at_css(".product-name").try(:text)
      deal.real_price_mask = page.at_css(".price-up").try(:text).try(:strip).split[1] if page.at_css(".price-up").try(:text)
      deal.price_mask = page.at_css(".price-to").try(:text).try(:strip).split[1] if page.at_css(".price-to").try(:text)
      deal.description = page.at_css(".productdescription").try(:text).truncate(4000) if page.at_css(".productdescription").try(:text)
      deal.image_url = page.at_css("#product-image-image")[:src] if page.at_css("#product-image-image")
    end
    deal.category = Deal::CATEGORY_CLOTHES
    deal.link = link
    deal.company = "Fiveblu"

    partner = Partner.find_by_name('Fiveblu')
    unless partner.blank?
      deal.partner = partner
    end

    deal
  end
end