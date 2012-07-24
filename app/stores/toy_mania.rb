class ToyMania

  def self.fill_deal_fields(link)
    deal = Deal.new :link => link
    page = Share.open_page(link)

    deal.title = page.at_css(".productName").try(:text).try(:strip)[0,255] if page.at_css(".productName")
    deal.price_mask = page.at_css(".valor-por").try(:text).try(:strip).split(" ")[2].try(:strip) if page.at_css(".valor-por") && page.at_css(".valor-por").try(:text)
    deal.real_price_mask = page.at_css(".valor-de").try(:text).try(:strip).split(" ")[2].try(:strip) if page.at_css(".valor-de") && page.at_css(".valor-de").try(:text)
    deal.description = page.at_css(".productName").try(:text).try(:strip)[0,255] if page.at_css(".productName")
    deal.category = Deal::CATEGORY_OTHER
    deal.image_url = "http://www.toymania.com.br/" + page.at_css("#image-main")["src"].try(:strip) if page.at_css("#image-main")
    deal.company = "Toy Mania"
    deal.kind = Deal::KIND_OFFER

    deal
  end
  
end