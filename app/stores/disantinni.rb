class Disantinni

  def self.fill_deal_fields(link)
    page = Share.open_page(link)

    deal = Deal.new
    unless page.nil?
      deal.link = link
      deal.title = page.at_css(".desc_prod").at_xpath(".//h1").try(:text).try(:strip)[0,255] if page.at_css(".desc_prod") && page.at_css(".desc_prod").at_xpath(".//h1").try(:text)
      deal.price_mask = page.at_css("#ctl00_ContentPlaceHolder1_spanPor").try(:text).split(" ")[2] if page.at_css("#ctl00_ContentPlaceHolder1_spanPor")
      deal.real_price_mask = page.at_css("#ctl00_ContentPlaceHolder1_spanDe").try(:text).split(" ")[2] if page.at_css("#ctl00_ContentPlaceHolder1_spanDe")
      deal.description = page.at_css(".info").to_s.truncate(4000) if page.at_css(".info")
      deal.category = Deal::CATEGORY_CLOTHES
      #TODO: falta colocar a imagem para funcionar
      deal.image_url = page.at_css("#pcPrincipalGrande")[:src] if page.at_css("#pcPrincipalGrande")
    end
    deal.company = "Di Santinni"

    partner = Partner.find_by_name('DiSantinni')
    unless partner.blank?
      deal.partner = partner
    end

    deal
  end
end