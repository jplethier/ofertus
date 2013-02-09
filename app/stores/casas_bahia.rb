#coding: utf-8
class CasasBahia
  CATEGORIES = {
    'Automotivo' => Deal::CATEGORY_CAR,
    'Bebês' => Deal::CATEGORY_OTHER,
    'Brinquedos' => Deal::CATEGORY_OTHER,
    'Cama, Mesa e Banho' => Deal::CATEGORY_HOME_AND_APPLIANCE,
    'Câmeras & Filmadoras' => Deal::CATEGORY_OTHER,
    'Celulares & Telefones' => Deal::CATEGORY_COMPUTER,
    'DVDs e Blu-Ray' => Deal::CATEGORY_CULTURE,
    "Eletrodomésticos" => Deal::CATEGORY_HOME_AND_APPLIANCE,
    'Eletrônicos' => Deal::CATEGORY_COMPUTER,
    'Esporte & Lazer' => Deal::CATEGORY_ENTERTAINMENT,
    'Ferramentas' => Deal::CATEGORY_OTHER,
    'Flores' => Deal::CATEGORY_OTHER,
    'Games' => Deal::CATEGORY_ENTERTAINMENT,
    "Informática" => Deal::CATEGORY_COMPUTER,
    'Livros' => Deal::CATEGORY_CULTURE,
    'Malas' => Deal::CATEGORY_TRAVEL,
    'Móveis'=> Deal::CATEGORY_HOME_AND_DECORATION,
    'Papelaria' => Deal::CATEGORY_OTHER,
    'Perfumaria' => Deal::CATEGORY_BEAUTY_AND_HEALTH,
    'Portáteis' => Deal::CATEGORY_HOME_AND_APPLIANCE,
    'Relógios' => Deal::CATEGORY_CLOTHES,
    'Saúde & Beleza' => Deal::CATEGORY_BEAUTY_AND_HEALTH,
    'Tablets' => Deal::CATEGORY_COMPUTER,
    'Utilidades Domésticas' => Deal::CATEGORY_HOME_AND_APPLIANCE
  }

  def self.fill_deal_fields(link)
    deal = Deal.new
    page = Share.open_page(link)

    deal.link = link.to_s.gsub('%25','%2')
    unless page.nil?

      deal.title = page.at_css(".produtoNome").try(:text).try(:strip)[0,255] if page.at_css('.produtoNome')
      deal.price_mask = page.at_css(".for strong").try(:text).split('$')[1].try(:strip) if page.at_css(".for strong") && page.at_css(".for strong").try(:text)
      deal.real_price_mask = page.at_css(".from strong").try(:text).split('$')[1].try(:strip) if page.at_css(".from strong") && page.at_css(".from strong").try(:text)
      deal.description = page.at_css("#descricao").to_s.truncate(4000) if page.at_css("#descricao")
      deal.category = CATEGORIES[page.at_css(".breadcrumb").try(:text).split(">")[1].try(:strip)] if page.at_css(".breadcrumb") && page.at_css(".breadcrumb").try(:text) && page.at_css(".breadcrumb").try(:text).split('>') && page.at_css(".breadcrumb").try(:text).split('>')[1]
      deal.image_url = page.at_css(".photo")["src"].try(:strip) if page.at_css(".photo")
    end
    deal.company = "Casas Bahia"

    partner = Partner.find_by_name('Casas Bahia')
    unless partner.blank?
      deal.partner = partner
    end

    deal
  end
end