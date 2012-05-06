class Dafiti
  
  def self.fill_deal_fields(link)
    page = Share.open_page(link)

    deal = Deal.new :link => link
    deal.title = page.at_css(".product-detail").at_xpath(".//h3").try(:text).try(:strip)[0,255] if page.at_css(".product-detail") && page.at_css(".product-detail").at_xpath(".//h3")
    precos = page.at_css('.price-box').at_xpath('.//tbody').try(:text).split(/\n/) if page.at_css('.price-box') && page.at_css('.price-box').at_xpath('.//tbody')
    if precos
      deal.price_mask = precos[3].try(:strip).split(' ')[1]
      deal.real_price_mask = precos[1].try(:strip).split(' ')[1]
    end
    deal.description = page.at_css(".productdescription").try(:text).try(:strip)[0,1200] if page.at_css(".productdescription")
    deal.category = Deal::CATEGORY_CLOTHES
    deal.image_url = page.at_css("#product-image-image")[:src].try(:strip) if page.at_css("#product-image-image")
    deal.company = "Dafiti"
    deal.kind = Deal::KIND_OFFER

    # puts "-"*100
    # puts "INICIO DA BUSCA NA PAGINA"
    # puts "-"*100
    # puts "TITULO = " + page.at_css(".product-detail").at_xpath(".//h3").try(:text).try(:strip)[0,255]
    # precos = page.at_css('.price-box').at_xpath('.//tbody').try(:text).split(/\n/)
    # puts "PRECO PROMOCIONAL = " + precos[3].try(:strip).split(' ')[1]
    # puts "PRECO REAL = " + precos[1].try(:strip).split(' ')[1]
    # puts "DESCRICAO = " + page.at_css(".productdescription").try(:text).try(:strip)[0,1200]
    # puts "CATEGORIA = " + FASTSHOP_CATEGORIES[page.at_css(".breadcrumb").try(:text).try(:strip).split(" ")[1]].to_s
    # puts "LINK DA IMAGEM = " + page.at_css("#product-image-image")[:src].try(:strip)
    # binding.pry
    # puts "-"*100
    # puts "FIM DA BUSCA NA PAGINA"
    # puts "-"*100

    deal
  end
end