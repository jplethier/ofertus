# encoding: UTF-8

require 'open-uri'

class Duks
  
  def self.fill_deal_fields(link)
    page = Share.open_page(link)

    deal = Deal.new :link => link
    deal.title = page.at_css(".EstNomeProd").try(:text).try(:strip)[0,255] if page.at_css(".EstNomeProd") && page.at_css(".EstNomeProd").try(:text)
    deal.price_mask = page.at_css(".Pink").at_xpath(".//b").try(:text)[3..-1] if page.at_css(".Pink") && page.at_css(".Pink").at_xpath(".//b") && page.at_css(".Pink").at_xpath(".//b").try(:text)
    deal.real_price_mask = page.at_css(".Pink").at_xpath(".//strike").try(:text)[3..-1] if page.at_css(".Pink") && page.at_css(".Pink").at_xpath(".//strike") && page.at_css(".Pink").at_xpath(".//strike").try(:text)
    deal.description = page.at_css("#CommentsFB").try(:text).try(:strip)[0,1200] if page.at_css("#CommentsFB") && page.at_css("#CommentsFB").try(:text)
    deal.image_url = "http://www.duks.com.br" + page.at_css(".MagicZoom").at_xpath(".//img")[:src][2..-1] if page.at_css(".MagicZoom") && page.at_css(".MagicZoom").at_xpath(".//img")
    deal.category = Deal::CATEGORY_BEAUTY_AND_HEALTH
    deal.company = "Duks Perfumaria"
    deal.kind = Deal::KIND_OFFER

    deal

    # puts "-"*100
    # puts "INICIO DA BUSCA NA PAGINA"
    # puts "-"*100
    # puts "TITULO = " + page.at_css(".EstNomeProd").try(:text).try(:strip)[0,255]
    # puts "PRECO PROMOCIONAL = " + page.at_css(".Pink").at_xpath(".//b").try(:text)[3..-1]
    # puts "PRECO REAL = " + page.at_css(".Pink").at_xpath(".//strike").try(:text)[3..-1]
    # puts "DESCRICAO = " + page.at_css("#CommentsFB").try(:text).try(:strip)[0,1200]
    # puts "CATEGORIA = " + page.at_css(".breadcrumb").at_xpath(".//strong").try(:text).split(" ")[2]
    # puts "LINK DA IMAGEM = " + "http://www.duks.com.br" + page.at_css(".MagicZoom").at_xpath(".//img")[:src][2..-1]
    # puts "-"*100
    # puts "FIM DA BUSCA NA PAGINA"
    # puts "-"*100
  end
end