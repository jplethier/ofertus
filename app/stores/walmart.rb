#coding: utf-8
class Walmart
  CATEGORIES = {
    "Automotivo" => Deal::CATEGORY_CAR,
    "Bebês" => Deal::CATEGORY_OTHER,
    "Beleza e Saúde" => Deal::CATEGORY_BEAUTY_AND_HEALTH,
    "Brinquedos" => Deal::CATEGORY_OTHER,
    "Cama, Mesa e Banho" => Deal::CATEGORY_HOME_AND_APPLIANCE,
    "Câmeras Digitais e Filmadoras" => Deal::CATEGORY_COMPUTER,
    "Casa e Segurança" => Deal::CATEGORY_HOME_AND_APPLIANCE,
    "Eletrodomésticos" => Deal::CATEGORY_HOME_AND_APPLIANCE,
    "Eletrônicos" => Deal::CATEGORY_COMPUTER,
    "Eletroportáteis" => Deal::CATEGORY_HOME_AND_APPLIANCE,
    "Esporte e Lazer" => Deal::CATEGORY_ENTERTAINMENT,
    "Ferramentas" => Deal::CATEGORY_HOME_AND_APPLIANCE,
    "Games" => Deal::CATEGORY_ENTERTAINMENT,
    "Informática" => Deal::CATEGORY_COMPUTER,
    "Instrumentos Musicais" => Deal::CATEGORY_ENTERTAINMENT,
    "Móveis e Colchões" => Deal::CATEGORY_HOME_AND_APPLIANCE,
    "Produtos Sustentáveis" => Deal::CATEGORY_OTHER,
    "Relógios" => Deal::CATEGORY_CLOTHES,
    "Telefonia" => Deal::CATEGORY_COMPUTER,
    "Utilidades Domésticas" => Deal::CATEGORY_HOME_AND_APPLIANCE
  }

  def self.fill_deal_fields(link)
    deal = Deal.new
    page = Share.open_page(link)

    unless page.nil?
      deal.link = link

      deal.title = page.at_css("h1#product-name").try(:text).try(:strip)[0,255] if page.at_css("h1#product-name").try(:text)

      if page.at_css('#___rc-p-dv-id') && page.at_css('#___rc-p-dv-id')[:value]
        price_page = Share.open_page('http://www.walmart.com.br/part/skuPrice?idSku=' + page.at_css('#___rc-p-dv-id')[:value])

        unless price_page.nil?
          deal.real_price_mask = price_page.at_css(".valor-de strong").try(:text).try(:strip) if price_page.at_css(".valor-de strong").try(:text)

          deal.price_mask = price_page.at_css(".valor-por span").try(:text).try(:strip) if price_page.at_css(".valor-por span").try(:text)
        end
      end

      deal.description = page.at_css("#box-product-details").try(:text).truncate(4000) if page.at_css("#box-product-details")
      deal.category = CATEGORIES[page.xpath('//div[@id="box-Bread-Crumb"]//ul/li').collect(&:text)[1]] if page.xpath('//div[@id="box-Bread-Crumb"]//ul/li') && page.xpath('//div[@id="box-Bread-Crumb"]//ul/li').collect(&:text)
      deal.image_url = 'http://www.walmart.com.br' + page.at_css("#image-main")[:src].try(:strip) if page.at_css("#image-main") && page.at_css("#image-main")[:src]
      deal.image_url = 'http://www.walmart.com.br' + page.at_css("#image a#image-zoom-jq")[:href].try(:strip) if page.at_css("#image a#image-zoom-jq") && page.at_css("#image a#image-zoom-jq")[:href]
    end
    deal.company = "Walmart"

    partner = Partner.find_by_name('Walmart')
    unless partner.blank?
      deal.partner = partner
    end

    deal
  end
end