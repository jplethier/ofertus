class Saraiva

  def self.fill_deal_fields(link)
    page = Share.open_page(link)

    deal = Deal.new :link => link
    deal.title = page.at_css("#tituloprod").try(:text).try(:strip)[0,255] if page.at_css("#tituloprod")
    deal.price_mask = page.at_css(".precoPor").try(:text).try(:strip)[6..-1].try(:strip) if page.at_css(".precoPor")
    deal.real_price_mask = page.at_css(".precoDe").try(:text).try(:strip)[5..-1].try(:strip) if page.at_css(".precoDe")
    deal.description = page.at_css("#PassosConteudo").try(:text).try(:strip)[0,1200] if page.at_css("#PassosConteudo")
    #deal.category = CATEGORIES[page.at_css(".selected").try(:text).try(:strip)]
    deal.image_url = page.at_css("#imgProd")[:src].try(:strip) if page.at_css("#imgProd")
    
    deal.company = "Saraiva"
    deal.kind = Deal::KIND_OFFER

    deal
  end
  
end