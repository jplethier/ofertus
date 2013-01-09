class Marisa
  def self.fill_deal_fields(link)
    page = Share.open_page(link)

    deal = Deal.new
    unless page.nil?
      deal.title = page.at_css("h2.tit-produto span").try(:text).try(:strip)[0,255] if page.at_css("h2.tit-produto span")
      deal.real_price_mask = page.at_css('#preco table td del').try(:text).split('R$')[1].try(:strip) if page.at_css('#preco table td del').try(:text)
      deal.price_mask = page.at_css('#preco table td p').try(:text).split('R$')[1].try(:strip) if page.at_css('#preco table td p').try(:text)

      deal.description = page.at_css(".Desc-Comp-Med").try(:text).try(:strip) if page.at_css(".Desc-Comp-Med")
      deal.image_url = page.at_css("#img a img")["src"].try(:strip) if page.at_css("#img a img")
    end
    deal.category = Deal::CATEGORY_CLOTHES
    deal.link = link
    deal.company = "Marisa"

    deal
  end
end