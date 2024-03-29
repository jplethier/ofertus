class ToyMania

  def self.fill_deal_fields(link)
    page = Share.open_page(link)

    deal = Deal.new
    unless page.nil?
      deal.link = link
      deal.title = page.at_css(".productName").try(:text).try(:strip)[0,255] if page.at_css(".productName")
      deal.price_mask = page.at_css(".valor-por .skuBestPrice").try(:text).split(' ')[1] if page.at_css(".valor-por .skuBestPrice").try(:text)
      deal.real_price_mask = page.at_css(".valor-de").try(:text).try(:strip).split(" ")[2].try(:strip) if page.at_css(".valor-de") && page.at_css(".valor-de").try(:text)
      deal.description = page.at_css(".productName").try(:text).try(:strip)[0,255] if page.at_css(".productName")
      deal.image_url = "http://www.toymania.com.br/" + page.at_css("#image-main")["src"].try(:strip) if page.at_css("#image-main")
    end
    deal.category = Deal::CATEGORY_OTHER
    deal.company = "Toy Mania"

    partner = Partner.find_by_name('Toy Mania')
    unless partner.blank?
      deal.partner = partner
    end

    deal
  end

end