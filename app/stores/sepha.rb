class Sepha

  def self.fill_deal_fields(link)
    page = Share.open_page(link)

    deal = Deal.new :link => link
    deal.title = page.at_css(".infoDescricao").at_xpath("h1").try(:text).try(:strip)[0,255] if page.at_css(".infoDescricao") && page.at_css(".infoDescricao").at_xpath("h1")
    deal.price_mask = page.at_css(".precoPromocao").try(:text).split(" ")[1] if page.at_css(".precoPromocao")
    deal.real_price_mask = page.at_css(".precoPromocaoNormal").try(:text).split(" ")[2] if page.at_css(".precoPromocaoNormal")
    deal.description = page.at_css("#produto_descricao_principal").try(:text).try(:strip)[0,1200] if page.at_css("#produto_descricao_principal")
    deal.category = Deal::CATEGORY_BEAUTY_AND_HEALTH
    deal.image_url = page.at_css("#produto_imagem_descricao").at_xpath(".//img")[:src].try(:strip) if page.at_css("#produto_imagem_descricao") && page.at_css("#produto_imagem_descricao").at_xpath(".//img")
    deal.company = "Sepha"
    deal.kind = Deal::KIND_OFFER

    deal

    # puts "-"*100
    # puts "INICIO DA BUSCA NA PAGINA"
    # puts "-"*100
    # puts "TITULO = " + page.at_css(".infoDescricao").at_xpath(".//h1").try(:text).try(:strip)[0,255]
    # puts "PRECO PROMOCIONAL = " + page.at_css(".precoPromocao").try(:text).split(" ")[1]
    # puts "PRECO REAL = " + page.at_css(".precoPromocaoNormal").try(:text).split(" ")[2]
    # puts "DESCRICAO = " + page.at_css("#produto_descricao_principal").try(:text).try(:strip)[0,1200]
    # puts "CATEGORIA = " + FASTSHOP_CATEGORIES[page.at_css(".breadcrumb").try(:text).try(:strip).split(" ")[1]].to_s
    # puts "LINK DA IMAGEM = " + page.at_css("#produto_imagem_descricao").at_xpath(".//img")[:src].try(:strip)
    # binding.pry
    # puts "-"*100
    # puts "FIM DA BUSCA NA PAGINA"
    # puts "-"*100
  end
end