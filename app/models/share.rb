# encoding: UTF-8

require 'open-uri'

class Share
  XPATH_ADDRESS = 'address'
  XPATH_CATEGORY = 'type'
  XPATH_COMPANY = []
  XPATH_DESCRIPTION = 'description'
  XPATH_DISCOUNT = []
  XPATH_END_DATE = []
  XPATH_IMAGE = 'image'
  XPATH_KIND = []
  XPATH_PRICE = []
  XPATH_REAL_PRICE = []
  XPATH_TITLE = 'title'

  AMERICANAS = "americanas.com"
  APPLE = "apple.com"
  CAMISETERIA = "camiseteria.com"
  CARREFOUR = "carrefour.com.br"
  COMPRA_FACIL = "comprafacil.com"
  DAFITI = "dafiti.com.br"
  DUKS = "duks.com.br"
  FASTSHOP = "fastshop.com.br"
  GROUPON = "groupon.com"
  HOTEL_URBANO = "hotelurbano.com.br"
  LEADER = "leader.com.br"
  LIVRARIA_CULTURA = "livrariacultura.com.br"
  MAGAZINE = "magazineluiza.com.br"
  NETSHOES = "netshoes.com.br"
  PEIXE_URBANO = "peixeurbano.com"
  POLISHOP = "polishop.com.br"
  PONTO_FRIO = "pontofrio.com"
  SARAIVA = "saraiva.com"
  SEPHA = "sepha.com.br"
  SUBMARINO = "submarino.com"

  CATEGORIES = {
    "bares-e-baladas" => Deal::CATEGORY_RESTAURANT,
    "cursos-e-aulas" => Deal::CATEGORY_CULTURE,
    "entretenimento" => Deal::CATEGORY_FITNESS,
    "esporte" => Deal::CATEGORY_FITNESS,
    "hoteis-e-viagens" => Deal::CATEGORY_TRAVEL,
    "produtos" => nil,
    "restaurantes" => Deal::CATEGORY_RESTAURANT,
    "saude-e-beleza" => Deal::CATEGORY_BEAUTY_AND_HEALTH,
    "servicos-locais" => Deal::CATEGORY_OTHER
  }

  def self.create_deal(link)
    @deal = Deal.new :link => link

    begin
      if @deal.link.match(AMERICANAS)
        @deal = Americanas.fill_deal_fields(link)
      elsif @deal.link.match(CARREFOUR)
        @deal = Carrefour.fill_deal_fields(link)
      elsif @deal.link.match(COMPRA_FACIL)
        @deal = CompraFacil.fill_deal_fields(link)
      elsif @deal.link.match(DAFITI)
        # TODO: preencher os campos automaticamente da dafiti
        @deal = fill_deal_fields(link)
      elsif @deal.link.match(DUKS)
        @deal = Duks.fill_deal_fields(link)
      elsif @deal.link.match(FASTSHOP)
        @deal = FastShop.fill_deal_fields(link)
      elsif @deal.link.match(GROUPON)
        @deal = Groupon.fill_deal_fields(link)
      elsif @deal.link.match(HOTEL_URBANO)
        @deal = HotelUrbano.fill_deal_fields(link)
      elsif @deal.link.match(LEADER)
        @deal = Leader.fill_deal_fields(link)
      elsif @deal.link.match(LIVRARIA_CULTURA)
        @deal = LivrariaCultura.fill_deal_fields(link)
      elsif @deal.link.match(MAGAZINE)
        @deal = Magazine.fill_deal_fields(link)
      elsif @deal.link.match(NETSHOES)
        @deal = Netshoes.fill_deal_fields(link)
      elsif @deal.link.match(PEIXE_URBANO)
        @deal = PeixeUrbano.fill_deal_fields(link)
      elsif @deal.link.match(PONTO_FRIO)
        @deal = PontoFrio.fill_deal_fields(link)
      elsif @deal.link.match(SARAIVA)
        @deal = Saraiva.fill_deal_fields(link)
      elsif @deal.link.match(SEPHA)
        @deal = Sepha.fill_deal_fields(link)
      elsif @deal.link.match(SUBMARINO)
        populate_submarino_deal(@deal)
      else
        @deal = fill_deal_fields(link)
      end
    rescue Errno::ENOENT => wrong_link_exception
      @deal = Deal.new
    rescue RuntimeError => rte
      @deal = Deal.new :link => link
    end

    @deal
  end

  #Open the link with 'utf-8' encoding.
  def self.open_page(link)
    page = Nokogiri::HTML(open(link).read) #Nokogiri bug: You need to use .read method in order to use encoding.
    page.encoding = 'utf-8'
    page
  end

  def self.fill_deal_fields(link)
    page = open_page(link)

    deal = Deal.new :link => link
    deal.title = page.at_css(XPATH_TITLE).try(:text).try(:strip)[0,255]

    deal
  end

  def self.populate_submarino_deal(deal)
    page = open_page(deal.link)

    deal.title = page.at_css(XPATH_TITLE).try(:text).try(:strip)[0,255]
    if page.at_css(".for").try(:text) && page.at_css(".ficheTechnique").try(:text)
      deal.price_mask = page.at_css(".for").try(:text).try(:strip)[7..-1].try(:strip)
      deal.real_price_mask = page.at_css(".from").try(:text).try(:strip)[6..-1].try(:strip)
      deal.description = page.at_css(".ficheTechnique").try(:text).try(:strip)[0,1200]
      #deal.category = PONTO_FRIO_CATEGORIES[page.at_css(".selected").try(:text).try(:strip)]
      deal.image_url = page.at_css("#baseImg")[:src].try(:strip)
    end
    deal.company = "Submarino"
    #if deal.price
      deal.kind = Deal::KIND_OFFER
    #else
    #  deal.kind = Deal::KIND_ON_SALE
    #end
  end  

  private

  def self.drop_product_name_from_breadcrumb(breadcrumb, char)
    new_breadcrumb = ""
    breadcrumb.each_char do |c|
      if c == char
        return new_breadcrumb.try(:strip)
      else
        new_breadcrumb = new_breadcrumb + c
      end
    end
    new_breadcrumb.strip
  end
end
