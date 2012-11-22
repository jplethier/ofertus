class AnaHickmann
  
  def self.fill_deal_fields(link)
    deal = Deal.new
    page = Share.open_page(link)

    unless page.nil?
      deal.link = link
      
      deal.title = page.at_css(".detalheProduto .boxInfoProd h2").try(:text).try(:strip)[0,255] if page.at_css(".detalheProduto .boxInfoProd h2")
      deal.real_price_mask = page.at_css(".precoacao .preco .depreco span").try(:text).try(:strip).split(' ')[1] if page.at_css(".precoacao .preco .depreco span").try(:text)
      deal.price_mask = page.at_css(".precoacao .preco .preco span").try(:text).try(:strip).split(' ')[1] if page.at_css(".precoacao .preco .preco span").try(:text)
      deal.description = page.at_css(".boxDescricao .txtDescricao").try(:text).truncate(4000) if page.at_css(".boxDescricao .txtDescricao")
      deal.category = Deal::CATEGORY_CLOTHES
      deal.image_url = page.at_css(".boxInfoProd #divCores ul li a img")[:src].try(:strip) if page.at_css(".boxInfoProd #divCores ul li a img") && page.at_css(".boxInfoProd #divCores ul li a img")[:src]
      deal.company = "Ana Hickmann"
    end

    deal
  end
end