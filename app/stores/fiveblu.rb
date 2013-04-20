class Fiveblu

  def self.fill_deal_fields(link)
    deal = Deal.new
    page = Share.open_page(link)

    unless page.nil?
      deal.link = link

      deal.title = page.at_css(".prd-detail-brand").try(:text).try(:strip)[0,255] if page.at_css(".prd-detail-brand").try(:text)
      deal.real_price_mask = page.at_css(".price-from").try(:text).try(:strip).split(' ')[2] if page.at_css(".price-from").try(:text)
      deal.price_mask = page.at_css("span#product_special_price").try(:text).try(:strip) if page.at_css("span#product_special_price").try(:text)
      deal.description = page.at_css("#details .prd-details").try(:text).truncate(4000) if page.at_css("#details .prd-details").try(:text)
      deal.category = Deal::CATEGORY_CLOTHES
      deal.image_url = page.at_css("#img-target")[:src].try(:strip) if page.at_css("#img-target") && page.at_css("#img-target")[:src]
    end
    deal.company = "Kanui"

    partner = Partner.find_by_name('Kanui')
    unless partner.blank?
      deal.partner = partner
    end

    deal
  end
end