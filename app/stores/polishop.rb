class Polishop

  def self.fill_deal_fields(link)
    page = Share.open_page(link)

    deal = Deal.new
    unless page.nil?
      deal.link = link
      deal.title = page.at_css(".productName").try(:text).try(:strip)[0,255] if page.at_css(".productName")
      deal.price_mask = page.at_css('.skuBestPrice').try(:text).split(' ')[1] if page.at_css('.skuBestPrice')
      deal.real_price_mask = page.at_css('.skuListPrice').try(:text).split(' ')[1] if page.at_css('.skuListPrice')
      deal.description = page.at_css(".productDescription").to_s.truncate(4000) if page.at_css(".productDescription")
      # deal.category = Deal::CATEGORY_CLOTHES
      deal.image_url = page.at_css("#image-main")[:src].try(:strip) if page.at_css("#image-main")
    end
    deal.company = "Polishop"
    deal.kind = Deal::KIND_OFFER

    # puts "-"*100
    # puts "INICIO DA BUSCA NA PAGINA"
    # puts "-"*100
    # puts "TITULO = " + page.at_css(".productName").try(:text).try(:strip)[0,255]
    # puts "PRECO PROMOCIONAL = " + page.at_css('.skuBestPrice').try(:text).split(' ')[1]
    # puts "PRECO REAL = " + page.at_css('.skuListPrice').try(:text).split(' ')[1]
    # puts "DESCRICAO = " + page.at_css(".productDescription").try(:text).try(:strip)[0,1200]
    # puts "CATEGORIA = " + FASTSHOP_CATEGORIES[page.at_css(".breadcrumb").try(:text).try(:strip).split(" ")[1]].to_s
    # puts "LINK DA IMAGEM = " + page.at_css("#image-main")[:src].try(:strip)
    # binding.pry
    # puts "-"*100
    # puts "FIM DA BUSCA NA PAGINA"
    # puts "-"*100

    deal
  end
end