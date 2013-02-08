class BrinquedosLaura
  def self.fill_deal_fields(link)
    page = Share.open_page(link)

    deal = Deal.new
    unless page.nil?
      deal.link = link
      deal.title = page.at_css("#info-produto .productName").try(:text).try(:strip)[0,255] if page.at_css("#info-produto .productName")
      deal.real_price_mask = page.at_css("#info-preco #boxPreco .descricao-preco .valor-de .skuListPrice").try(:text).split(' ')[1].try(:strip) if page.at_css("#info-preco #boxPreco .descricao-preco .valor-de .skuListPrice").try(:text)
      deal.price_mask = page.at_css("#info-preco #boxPreco .descricao-preco .valor-por .skuBestPrice").try(:text).try(:strip).split(" ")[1].try(:strip) if page.at_css("#info-preco #boxPreco .descricao-preco .valor-por .skuBestPrice").try(:text)
      deal.description = page.at_css("#descricao-produto .productDescription").try(:text).try(:strip) if page.at_css("#descricao-produto .productDescription")
      deal.image_url = "http://www.brinquedoslaura.com.br" + page.at_css("#image .image-zoom #image-main")["src"].try(:strip) if page.at_css("#image .image-zoom #image-main")
    end
    deal.category = Deal::CATEGORY_OTHER
    deal.company = "Brinquedos Laura"

    partner = Partner.find_by_name('Brinquedos Laura')
    unless partner.blank?
      deal.partner = partner
    end

    deal
  end
end