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
  DISANTINNI = "disantinni.com.br"
  DUKS = "duks.com.br"
  FASTSHOP = "fastshop.com.br"
  FNAC = "fnac.com.br"
  GIRAFA = "girafa.com.br"
  GIULIANA_FLORES = "giulianaflores.com.br"
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

    begin
      if link.match(AMERICANAS)
        @deal = Americanas.fill_deal_fields(link)
      elsif link.match(CARREFOUR)
        @deal = Carrefour.fill_deal_fields(link)
      elsif link.match(COMPRA_FACIL)
        @deal = CompraFacil.fill_deal_fields(link)
      elsif link.match(DAFITI)
        @deal = Dafiti.fill_deal_fields(link)
      elsif link.match(DISANTINNI)
        @deal = Disantinni.fill_deal_fields(link)
      elsif link.match(DUKS)
        @deal = Duks.fill_deal_fields(link)
      elsif link.match(FASTSHOP)
        @deal = FastShop.fill_deal_fields(link)
      elsif link.match(FNAC)
        @deal = Fnac.fill_deal_fields(link)
      elsif link.match(GIRAFA)
        @deal = Girafa.fill_deal_fields(link)
      elsif link.match(GIULIANA_FLORES)
        @deal = GiulianaFlores.fill_deal_fields(link)
      elsif link.match(GROUPON)
        @deal = Groupon.fill_deal_fields(link)
      elsif link.match(HOTEL_URBANO)
        @deal = HotelUrbano.fill_deal_fields(link)
      elsif link.match(LEADER)
        @deal = Leader.fill_deal_fields(link)
      elsif link.match(LIVRARIA_CULTURA)
        @deal = LivrariaCultura.fill_deal_fields(link)
      elsif link.match(MAGAZINE)
        @deal = Magazine.fill_deal_fields(link)
      elsif link.match(NETSHOES)
        @deal = Netshoes.fill_deal_fields(link)
      elsif link.match(PEIXE_URBANO)
        @deal = PeixeUrbano.fill_deal_fields(link)
      elsif link.match(POLISHOP)
        @deal = Polishop.fill_deal_fields(link)
      elsif link.match(PONTO_FRIO)
        @deal = PontoFrio.fill_deal_fields(link)
      elsif link.match(SARAIVA)
        @deal = Saraiva.fill_deal_fields(link)
      elsif link.match(SEPHA)
        @deal = Sepha.fill_deal_fields(link)
      elsif link.match(SUBMARINO)
        @deal = Submarino.fill_deal_fields(link)
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
