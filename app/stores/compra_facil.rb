# encoding: UTF-8

require 'open-uri'

class CompraFacil

  CATEGORIES = {
    "Ar & Ventilação" => Deal::CATEGORY_HOME_AND_APPLIANCE,
    "Automotivos" => Deal::CATEGORY_CAR,
    "Brinquedos" => Deal::CATEGORY_OTHER,
    "Bebês" => Deal::CATEGORY_OTHER,
    "Cama & Banho" => Deal::CATEGORY_HOME_AND_APPLIANCE,
    "Celulares" => Deal::CATEGORY_COMPUTER,
    "Cine & Foto" => Deal::CATEGORY_COMPUTER,
    "Colchões" => Deal::CATEGORY_HOME_AND_APPLIANCE,
    "Computadores" => Deal::CATEGORY_COMPUTER,
    "Eletrodomésticos" => Deal::CATEGORY_HOME_AND_APPLIANCE,
    "Eletrônicos" => Deal::CATEGORY_COMPUTER,
    "Eletroportáteis" => Deal::CATEGORY_COMPUTER,
    "Esportes & Lazer" => Deal::CATEGORY_ENTERTAINMENT,
    "Ferramentas" => Deal::CATEGORY_HOME_AND_APPLIANCE,
    "Fitness" => Deal::CATEGORY_ENTERTAINMENT,
    "Games" => Deal::CATEGORY_OTHER,
    "Home Center" => Deal::CATEGORY_HOME_AND_APPLIANCE,
    "Industriais" => Deal::CATEGORY_OTHER,
    "Informática" => Deal::CATEGORY_COMPUTER,
    "Malas" => Deal::CATEGORY_OTHER,
    "Móveis & Estofados" => Deal::CATEGORY_HOME_AND_APPLIANCE,
    "Perfumes" => Deal::CATEGORY_BEAUTY_AND_HEALTH,
    "Relógios" => Deal::CATEGORY_OTHER,
    "Saúde & Beleza" => Deal::CATEGORY_BEAUTY_AND_HEALTH,
    "Telefonia" => Deal::CATEGORY_COMPUTER,
    "Tênis" => Deal::CATEGORY_BEAUTY_AND_HEALTH,
    "U. Domésticas" => Deal::CATEGORY_HOME_AND_APPLIANCE
  }

  def self.fill_deal_fields(link)
    page = Share.open_page(link)

    deal = Deal.new
    unless page.nil?
      deal.link = link
      deal.title = page.at_css(".produto-titulo").try(:text).try(:strip)[0,255] if page.at_css(".produto-titulo") && page.at_css(".produto-titulo").try(:text)
      deal.price_mask = page.at_css(".produto-por").try(:text).try(:strip)[7..-1].try(:strip) if page.at_css(".produto-por") && page.at_css(".produto-por").try(:text)
      deal.real_price_mask = page.at_css(".produto-de").try(:text).try(:strip)[6..-1].try(:strip) if page.at_css(".produto-de") && page.at_css(".produto-de").try(:text)
      deal.description = page.at_css("#produto-caracteristicas").to_s.truncate(4000) if page.at_css("#produto-caracteristicas")
      deal.category = CATEGORIES[page.at_css("#breadCrumb").at_xpath(".//ul/li/a").try(:text).try(:strip)] if page.at_css("#breadCrumb") && page.at_css("#breadCrumb").at_xpath(".//ul/li/a") && page.at_css("#breadCrumb").at_xpath(".//ul/li/a").try(:text)
      deal.image_url = page.at_css(".imagens-maisInfo").at_xpath(".//img")[:src].try(:strip) if page.at_css(".imagens-maisInfo") && page.at_css(".imagens-maisInfo").at_xpath(".//img")
      deal.company = "Compra Fácil"
      deal.kind = Deal::KIND_OFFER
    end

    deal
  end

end