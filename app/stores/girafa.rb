# encoding: UTF-8
class Girafa    

  CATEGORIES = {
    "Cine/Foto" => Deal::CATEGORY_ELECTRONICS,
    "Eletronicos" => Deal::CATEGORY_ELECTRONICS,
    "Eletroportáteis" => Deal::CATEGORY_HOME_AND_APPLIANCE,
    "Eletroomésticos" => Deal::CATEGORY_HOME_AND_APPLIANCE,
    "Games" => Deal::CATEGORY_KIDS,
    "Informática" => Deal::CATEGORY_COMPUTER,
    "Saúde e beleza" => Deal::CATEGORY_BEAUTY_AND_HEALTH,
    "Telefonia" => Deal::CATEGORY_ELECTRONICS
  }

  def self.fill_deal_fields(link)
    page = Share.open_page(link)

    deal = Deal.new :link => link
    deal.title = page.at_css(".descricao_produto").at_xpath("h1").try(:text).try(:strip)[0,255] if page.at_css(".descricao_produto") && page.at_css(".descricao_produto").at_xpath("h1")
    deal.price_mask = page.at_css('#liquido').try(:text) if page.at_css('#liquido')
    deal.real_price_mask = page.at_css('.preco-cheio').try(:text).split(" ")[1] if page.at_css('.preco-cheio')
    deal.description = page.at_css("#ct-busca1").to_s.truncate(4000) if page.at_css("#ct-busca1")
    deal.category = CATEGORIES[page.at_css(".directory").at_xpath("a").try(:text)] if page.at_css(".directory") && page.at_css(".directory").at_xpath("a")
    deal.image_url = "http://www.girafa.com.br" + page.at_css(".gobig-view").at_xpath("img")[:src].try(:strip) if page.at_css(".gobig-view") && page.at_css(".gobig-view").at_xpath("img")
    deal.company = "Girafa"
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