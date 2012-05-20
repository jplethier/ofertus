class Netshoes
  
  def self.fill_deal_fields(link)
    page = Share.open_page(link)

    deal = Deal.new :link => link  
    deal.title = page.at_css("h1.titProduct").try(:text).try(:strip)[0,255] if page.at_css("h1.titProduct") && page.at_css("h1.titProduct").try(:text)
    #  deal.price_mask = page.at_css(".prodPor").try(:text).try(:strip)[7..-1].try(:strip)
    #  deal.real_price_mask = page.at_css(".prodDe").try(:text).try(:strip)[6..-1].try(:strip)
    deal.description = page.at_css(".txtFeatures") if page.at_css(".txtFeatures")
    deal.image_url = page.at_css(".lstImages").at_xpath(".//img")[:src].sub("thumb","zoom") if page.at_css(".lstImages") && page.at_css(".lstImages").at_xpath(".//img")
    deal.company = "Netshoes"
    deal.category = Deal::CATEGORY_CLOTHES
    deal.kind = Deal::KIND_OFFER

    deal
  end
end