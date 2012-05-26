# encoding: UTF-8
class Fnac

  CATEGORIES = {
    "Filmes e TV" => Deal::CATEGORY_CULTURE,
    "Foto" => Deal::CATEGORY_ELECTRONICS,
    "Games" => Deal::CATEGORY_KIDS,
    "Infantil" => Deal::CATEGORY_KIDS,
    "Imagem" => Deal::CATEGORY_ELECTRONICS,
    "Informática" => Deal::CATEGORY_COMPUTER,
    "Livros" => Deal::CATEGORY_CULTURE,
    "Música" => Deal::CATEGORY_CULTURE,
    "Serviços" => Deal::CATEGORY_OTHER,
    "Som" => Deal::CATEGORY_CULTURE,
    "Telefonia" => Deal::CATEGORY_ELECTRONICS
  }

  def self.fill_deal_fields(link)
    page = Share.open_page(link)

    deal = Deal.new :link => link
    deal.title = page.at_css("#nomeProduto").try(:text).try(:strip)[0,255] if page.at_css("#nomeProduto")
    deal.price_mask = page.at_css('#spanValorAtual').try(:text).split(" ")[2] if page.at_css('#spanValorAtual')
    deal.real_price_mask = page.at_css('#spanValorBase').try(:text).split(" ")[2] if page.at_css('#spanValorBase')
    deal.description = page.at_css("#conteudoDescricao").to_s.truncate(4000) if page.at_css("#conteudoDescricao")
    deal.category = CATEGORIES[page.at_css(".cat.atual").at_xpath("span").try(:text).try(:strip)] if page.at_css(".cat.atual") && page.at_css(".cat.atual").at_xpath("span")
    deal.image_url = page.at_css(".fotoGrande")[:src].try(:strip) if page.at_css(".fotoGrande")
    deal.company = "FNAC"
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