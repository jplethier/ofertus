# coding: utf-8
class EpocaCosmeticos

  def self.fill_deal_fields(link)
    page = Share.open_page(link)

    deal = Deal.new
    unless page.nil?
      deal.title = page.at_css("h1.hTitle").try(:text).try(:strip)[0,255] if page.at_css("h1.hTitle")

      if page.at_css('#ConteudoProduto #divItemInfo').try(:text)
        deal.price_mask = page.at_css('#ConteudoProduto #divItemInfo').try(:text).split(' ')[5]
        deal.real_price_mask = page.at_css('#ConteudoProduto #divItemInfo').try(:text).split(' ')[2]
      end

      deal.description = page.at_css(".divOffersBoxContent").try(:text).to_s.truncate(4000) if page.at_css(".divOffersBoxContent").try(:text)

      if page.at_css("img#imgProductBig")
        deal.image_url = 'http://www.epocacosmeticos.com.br/' + page.at_css("img#imgProductBig")[:src].try(:strip)
      end
    end
    deal.category = Deal::CATEGORY_BEAUTY_AND_HEALTH
    deal.link = link
    deal.company = "Época Cosméticos"

    partner = Partner.find_by_name('Época Cosméticos')
    unless partner.blank?
      deal.partner = partner
    end

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