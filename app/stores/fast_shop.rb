# encoding: UTF-8

require 'open-uri'

class FastShop

  CATEGORIES = {
    "Áudio" => Deal::CATEGORY_COMPUTER,
    "Vídeo" => Deal::CATEGORY_COMPUTER,
    "Cine e Foto" => Deal::CATEGORY_COMPUTER,
    "Eletrodomésticos" => Deal::CATEGORY_HOME_AND_APPLIANCE,
    "Portáteis" => Deal::CATEGORY_COMPUTER,
    "Utensílios Domésticos" => Deal::CATEGORY_HOME_AND_APPLIANCE,
    "Informática" => Deal::CATEGORY_COMPUTER,
    "Telefonia" => Deal::CATEGORY_COMPUTER,
    "Apple" => Deal::CATEGORY_COMPUTER,
    "Games" => Deal::CATEGORY_OTHER,
    "Tablet" => Deal::CATEGORY_COMPUTER
  }

  def self.fill_deal_fields(link)
    page = Share.open_page(link)

    deal = Deal.new
    unless page.nil?
      deal.link = link
      deal.title = page.at_css("h1.name").try(:text).try(:strip)[0,255] if page.at_css("h1.name") && page.at_css("h1.name").try(:text)
      if page.at_css('.novo_conteudo_preco_detalhe_produto span') && page.at_css('.novo_conteudo_preco_detalhe_produto span').try(:text)
        if page.at_css(".novo_conteudo_preco_detalhe_produto span").try(:text).split(" ")[2].downcase.match('de')
          deal.real_price_mask = page.at_css(".novo_conteudo_preco_detalhe_produto span").try(:text).split(" ")[2]
          deal.price_mask = page.at_css('.novo_conteudo_preco_detalhe_produto span').try(:text).split(" ")[5]
        else
          deal.price_mask = page.at_css(".novo_conteudo_preco_detalhe_produto span").try(:text).split(" ")[2]
        end
      end
      deal.description = page.at_css("#divDescr1").to_s.truncate(4000) if page.at_css("#divDescr1")
      deal.category = CATEGORIES[page.at_css(".breadcrumb").try(:text).try(:strip).split(" ")[1]] if page.at_css(".breadcrumb") && page.at_css(".breadcrumb").try(:text)
      deal.image_url = page.at_css(".photo").at_xpath(".//input")[:src] if page.at_css(".photo") && page.at_css(".photo").at_xpath(".//input")
    end
    deal.company = "Fast Shop"

    partner = Partner.find_by_name('FastShop')
    unless partner.blank?
      deal.partner = partner
    end

    deal
  end
end