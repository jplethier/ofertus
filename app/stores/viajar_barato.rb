class ViajarBarato
  def self.fill_deal_fields(link)
    page = Share.open_page(link)

    deal = Deal.new
    unless page.nil?
      deal.title = page.at_css("h2.tituloOfertaDoDia").try(:text).try(:strip)[0,255] if page.at_css("h2.tituloOfertaDoDia")
      deal.real_price_mask = page.at_css(".PrecoOferta ul li.Preco1 strike").try(:text).try(:strip) if page.at_css(".PrecoOferta ul li.Preco1 strike").try(:text)
      deal.price_mask = page.at_css(".PrecoOferta ul li.Preco2").try(:text).split('R$')[1].try(:strip) if page.at_css(".PrecoOferta ul li.Preco2").try(:text)
      deal.description = page.at_css(".OfertaRegra2 .Oferta").try(:text).try(:strip) if page.at_css(".OfertaRegra2 .Oferta")
      deal.image_url = page.at_css(".ImgOferta img")["src"].try(:strip) if page.at_css(".ImgOferta img")
    end
    deal.link = link
    deal.category = Deal::CATEGORY_TRAVEL
    deal.end_date = Date.today
    deal.company = "Viajar Barato"

    partner = Partner.find_by_name('Viajar Barato')
    unless partner.blank?
      deal.partner = partner
    end

    deal
  end
end