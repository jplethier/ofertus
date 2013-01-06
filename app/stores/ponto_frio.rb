# encoding: UTF-8
class PontoFrio

  CATEGORIES = {
    "Automotivo" => Deal::CATEGORY_CAR,
    "Bebês" => Deal::CATEGORY_OTHER,
    "Beleza & Saúde" => Deal::CATEGORY_BEAUTY_AND_HEALTH,
    "Brinquedos" => Deal::CATEGORY_OTHER,
    "Cama, Mesa e Banho" => Deal::CATEGORY_HOME_AND_APPLIANCE,
    "Cine & Foto" => Deal::CATEGORY_CULTURE,
    "DVDs e Blu-Ray" => Deal::CATEGORY_CULTURE,
    "Eletrodomésticos" => Deal::CATEGORY_HOME_AND_APPLIANCE,
    "Eletrônicos" => Deal::CATEGORY_COMPUTER,
    "Eletroportáteis" => Deal::CATEGORY_HOME_AND_APPLIANCE,
    "Esporte & Lazer" => Deal::CATEGORY_ENTERTAINMENT,
    "Ferramentas" => Deal::CATEGORY_OTHER,
    "Flores" => Deal::CATEGORY_OTHER,
    "Futebol" => Deal::CATEGORY_OTHER,
    "Games" => Deal::CATEGORY_OTHER,
    "Informática" => Deal::CATEGORY_COMPUTER,
    "Livros" => Deal::CATEGORY_CULTURE,
    "Malas" => Deal::CATEGORY_OTHER,
    "Móveis" => Deal::CATEGORY_HOME_AND_APPLIANCE,
    "Papelaria" => Deal::CATEGORY_OTHER,
    "Perfumaria" => Deal::CATEGORY_BEAUTY_AND_HEALTH,
    "Telefones & Celulares" => Deal::CATEGORY_COMPUTER,
    "Relógios" => Deal::CATEGORY_OTHER,
    "Utilidades Domésticas" => Deal::CATEGORY_HOME_AND_APPLIANCE
  }

  def self.fill_deal_fields(link)
    page = Share.open_page(link)

    deal = Deal.new
    unless page.nil?
      deal.title = page.at_css(".produtoNome").try(:text).try(:strip)[0,255] if page.at_css(".produtoNome")
      deal.price_mask = page.at_css(".for").try(:text).try(:strip)[7..-1].try(:strip) if page.at_css(".for")
      deal.real_price_mask = page.at_css(".from").try(:text).try(:strip)[7..-1].try(:strip) if page.at_css(".from")
      deal.description = page.at_css(".descricao").to_s.truncate(4000) if page.at_css(".descricao")
      deal.category = CATEGORIES[page.at_css(".selected").try(:text).try(:strip)] if page.at_css(".selected")
      deal.image_url = page.at_css("#divFullImage").at_xpath(".//img")["src"].try(:strip) if page.at_css("#divFullImage") && page.at_css("#divFullImage").at_xpath(".//img")
    end
    deal.link = link
    deal.company = "Ponto Frio"
    
    deal
  end
end