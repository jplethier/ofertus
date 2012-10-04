class GiulianaFlores
  
  def self.fill_deal_fields(link)
    page = Share.open_page(link)

    deal = Deal.new
    unless page.nil?
      deal.link = link
      deal.title = page.at_css(".productName").at_xpath(".//h1").try(:text).try(:strip)[0,255] if page.at_css(".productName") && page.at_css(".productName").at_xpath(".//h1").try(:text)
      deal.price_mask = page.at_css("#ctl00_ContentSite_lblPrice").try(:text).split(" ")[1] if page.at_css("#ctl00_ContentSite_lblPrice").try(:text)
      deal.real_price_mask = page.at_css("#ctl00_ContentSite_lblListPrice").try(:text).split(" ")[1] if page.at_css("#ctl00_ContentSite_lblListPrice").try(:text)
      deal.description = page.at_css("#ctl00_ContentSite_lblProductDescription").to_s.truncate(4000) if page.at_css("#ctl00_ContentSite_lblProductDescription")
      deal.category = Deal::CATEGORY_OTHER
      deal.image_url = page.at_css("#ctl00_ContentSite_vmcImage_imgProductBig")[:src] if page.at_css("#ctl00_ContentSite_vmcImage_imgProductBig")
    end
    deal.company = "Giuliana Flores"
    
    deal
  end
end