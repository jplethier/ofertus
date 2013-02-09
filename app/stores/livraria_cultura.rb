class LivrariaCultura

  def self.fill_deal_fields(link)
    page = Share.open_page(link)

    deal = Deal.new :link => link
    unless page.nil?
      deal.link = link
      deal.title = page.at_css("h2.resenha").try(:text).try(:strip)[0,255] if page.at_css("h2.resenha") && page.at_css("h2.resenha").try(:text)
      #  deal.price_mask = page.at_css(".sale").try(:text).try(:strip)[7..-1].try(:strip)
      #  deal.real_price_mask = page.at_css(".regular").try(:text).try(:strip)[6..-1].try(:strip)
      deal.description = page.at_css("div.resenha").to_s.truncate(4000) if page.at_css("div.resenha")
      deal.image_url = page.at_css(".boxImg2").at_xpath(".//img")[:src].try(:strip) if page.at_css(".boxImg2") && page.at_css(".boxImg2").at_xpath(".//img")
    end
    deal.category = Deal::CATEGORY_CULTURE
    deal.company = "Livraria Cultura"

    partner = Partner.find_by_name('Livraria Cultura')
    unless partner.blank?
      deal.partner = partner
    end

    deal
  end
end