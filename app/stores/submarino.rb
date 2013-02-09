#coding: utf-8
class Submarino
  CATEGORIES = {
    'Alimentos e Bebidas' => Deal::CATEGORY_OTHER,
    'Automotivo' => Deal::CATEGORY_CAR,
    'Bebês' => Deal::CATEGORY_OTHER,
    'Beleza e Saúde' => Deal::CATEGORY_BEAUTY_AND_HEALTH,
    'Brinquedos' => Deal::CATEGORY_OTHER,
    'Cama, Mesa e Banho' => Deal::CATEGORY_HOME_AND_APPLIANCE,
    'Cine e Foto' => Deal::CATEGORY_OTHER,
    'DVDs e Blu-Ray' => Deal::CATEGORY_CULTURE,
    'Eletrônicos' => Deal::CATEGORY_COMPUTER,
    'Eletrodomésticos' => Deal::CATEGORY_HOME_AND_APPLIANCE,
    'Eletrônicos' => Deal::CATEGORY_COMPUTER,
    'Eletroportáteis' => Deal::CATEGORY_HOME_AND_APPLIANCE,
    'Esporte e Lazer' => Deal::CATEGORY_ENTERTAINMENT,
    'Ferramentas' => Deal::CATEGORY_OTHER,
    'Flores' => Deal::CATEGORY_OTHER,
    'Games' => Deal::CATEGORY_OTHER,
    'Informática' => Deal::CATEGORY_COMPUTER,
    'Livros' => Deal::CATEGORY_CULTURE,
    'Malas & Acessórios' => Deal::CATEGORY_OTHER,
    'Moda' => Deal::CATEGORY_CLOTHES,
    'Móveis' => Deal::CATEGORY_HOME_AND_DECORATION,
    'Papelaria' => Deal::CATEGORY_OTHER,
    'Perfumaria' => Deal::CATEGORY_BEAUTY_AND_HEALTH,
    'Relógios' => Deal::CATEGORY_CLOTHES,
    'Tablets' => Deal::CATEGORY_COMPUTER,
    'Telefones & Celulares' => Deal::CATEGORY_COMPUTER,
    'Utilidades Domésticas' => Deal::CATEGORY_HOME_AND_APPLIANCE
  }

  def self.fill_deal_fields(link)
    page = Share.open_page(link)

    deal = Deal.new
    deal.link = link
    unless page.nil?
      deal.title = page.at_css("title").try(:text).try(:strip)[0,255] if page.at_css("title")
      deal.price_mask = page.at_css(".sale .amount").try(:text).try(:strip) if page.at_css(".sale .amount") && page.at_css(".sale .amount").try(:text)
      deal.real_price_mask = page.at_css(".regular .amount").try(:text).try(:strip)[2..-1].try(:strip) if page.at_css(".regular .amount") && page.at_css(".regular .amount").try(:text)
      deal.description = page.at_css("#productDescription").to_s.truncate(4000) if page.at_css("#productDescription")
      deal.category = CATEGORIES[page.at_css(".selected").try(:text).try(:strip)]
      deal.image_url = page.at_css("#imgProduto")[:src].try(:strip) if page.at_css("#imgProduto")
    end
    deal.company = "Submarino"

    partner = Partner.find_by_name('Submarino')
    unless partner.blank?
      deal.partner = partner
    end

    deal
  end
end