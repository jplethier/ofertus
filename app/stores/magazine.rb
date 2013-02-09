# encoding: UTF-8
class Magazine

  CATEGORIES = {
    "Automotivo" => Deal::CATEGORY_CAR,
    "Bebês" => Deal::CATEGORY_OTHER,
    "Beleza e Saúde" => Deal::CATEGORY_BEAUTY_AND_HEALTH,
    "Brinquedos" => Deal::CATEGORY_OTHER,
    "Cama, Mesa e Banho" => Deal::CATEGORY_HOME_AND_APPLIANCE,
    "Casa e Jardim" => Deal::CATEGORY_HOME_AND_APPLIANCE,
    "Celulares e Telefones" => Deal::CATEGORY_COMPUTER,
    "Cine e Foto" => Deal::CATEGORY_COMPUTER,
    "Eletrodomésticos" => Deal::CATEGORY_HOME_AND_APPLIANCE,
    "Eletrônicos" => Deal::CATEGORY_COMPUTER,
    "Eletroportáteis" => Deal::CATEGORY_COMPUTER,
    "Esporte e Lazer" => Deal::CATEGORY_ENTERTAINMENT,
    "Ferramentas e Segurança" => Deal::CATEGORY_OTHER,
    "Informática" => Deal::CATEGORY_COMPUTER,
    "Informática Acessórios" => Deal::CATEGORY_COMPUTER,
    "Instrumentos Musicais" => Deal::CATEGORY_OTHER,
    "Móveis" => Deal::CATEGORY_HOME_AND_APPLIANCE,
    "Perfumaria e Cosméticos" => Deal::CATEGORY_BEAUTY_AND_HEALTH,
    "Relógios" => Deal::CATEGORY_OTHER,
    "Utilidades Domésticas" => Deal::CATEGORY_HOME_AND_APPLIANCE
  }

  def self.fill_deal_fields(link)
    page = Share.open_page(link)

    deal = Deal.new
    unless page.nil?
      deal.link = link
      deal.title = page.at_css(".description").try(:text).try(:strip)[0,255] if page.at_css(".description") && page.at_css(".description").try(:text)
      deal.price_mask = page.at_css(".prodPor").try(:text).try(:strip)[7..-1].try(:strip) if page.at_css(".prodPor") && page.at_css(".prodPor").try(:text)
      deal.real_price_mask = page.at_css(".prodDe").try(:text).try(:strip)[6..-1].try(:strip) if page.at_css(".prodDe") && page.at_css(".prodDe").try(:text)
      deal.description = page.at_css("#descricaoProduto").to_s.truncate(4000) if page.at_css("#descricaoProduto")
      deal.category = CATEGORIES[page.at_css("#breadCrumb").try(:text).try(:strip).split("›").map(&:strip)[1].chop] if page.at_css("#breadCrumb") && page.at_css("#breadCrumb").try(:text)
      deal.image_url = page.at_css(".imagem_produto").at_xpath(".//img")[:src].try(:strip) if page.at_css(".imagem_produto") && page.at_css(".imagem_produto").at_xpath(".//img")
    end
    deal.company = "Magazine Luiza"

    partner = Partner.find_by_name('Magazine Luiza')
    unless partner.blank?
      deal.partner = partner
    end

    deal
  end
end