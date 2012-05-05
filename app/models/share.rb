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
  PONTO_FRIO = "pontofrio.com"
  SARAIVA = "saraiva.com"
  SEPHA = "sepha.com.br"
  SUBMARINO = "submarino.com"

  PONTO_FRIO_CATEGORIES = {
    "Automotivo" => Deal::CATEGORY_CAR,
    "Bebês" => Deal::CATEGORY_KIDS,
    "Beleza & Saúde" => Deal::CATEGORY_BEAUTY_AND_HEALTH,
    "Brinquedos" => Deal::CATEGORY_KIDS,
    "Cama, Mesa e Banho" => Deal::CATEGORY_HOME_AND_APPLIANCE,
    "Cine & Foto" => Deal::CATEGORY_CULTURE,
    "DVDs e Blu-Ray" => Deal::CATEGORY_CULTURE,
    "Eletrodomésticos" => Deal::CATEGORY_HOME_AND_APPLIANCE,
    "Eletrônicos" => Deal::CATEGORY_ELECTRONICS,
    "Eletroportáteis" => Deal::CATEGORY_HOME_AND_APPLIANCE,
    "Esporte & Lazer" => Deal::CATEGORY_FITNESS,
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
    "Telefones & Celulares" => Deal::CATEGORY_ELECTRONICS,
    "Relógios" => Deal::CATEGORY_OTHER,
    "Utilidades Domésticas" => Deal::CATEGORY_HOME_AND_APPLIANCE
  }

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
        populate_deal(@deal)
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
        populate_pontofrio_deal(@deal)
      elsif @deal.link.match(SARAIVA)
        populate_saraiva_deal(@deal)
      elsif @deal.link.match(SEPHA)
        populate_sepha_deal(@deal)
      elsif @deal.link.match(SUBMARINO)
        populate_submarino_deal(@deal)
      else
        populate_deal(@deal)
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

  def self.populate_deal(deal)
    page = open_page(deal.link)

    deal.title = page.at_css(XPATH_TITLE).try(:text).try(:strip)[0,255]
  end

  def self.populate_pontofrio_deal(deal)
    page = open_page(deal.link)

    if page.at_css(".sale").try(:text) && page.at_css(".produtoNome").try(:text) && page.at_css(".descricao").try(:text) && page.at_css(".selected").try(:text)
      deal.title = page.at_css(".produtoNome").try(:text).try(:strip)[0,255]
      deal.price_mask = page.at_css(".sale").try(:text).try(:strip)[7..-1].try(:strip)
      deal.real_price_mask = page.at_css(".regular").try(:text).try(:strip)[6..-1].try(:strip)
      deal.description = page.at_css(".descricao").try(:text).try(:strip)[0,1200]
      deal.category = PONTO_FRIO_CATEGORIES[page.at_css(".selected").try(:text).try(:strip)]
      deal.image_url = page.at_css("#divFullImage").at_xpath(".//img")["src"].try(:strip)
    end
    deal.company = "Ponto Frio"
    #if deal.price
      deal.kind = Deal::KIND_OFFER
    #else
    #  deal.kind = Deal::KIND_ON_SALE
    #end
  end

  def self.populate_saraiva_deal(deal)
    page = open_page(deal.link)

    
    if page.at_css("#tituloprod").try(:text) && page.at_css(".precoDe").try(:text) && page.at_css("#PassosConteudo").try(:text)
      deal.title = page.at_css("#tituloprod").try(:text).try(:strip)[0,255]
      deal.price_mask = page.at_css(".precoPor").try(:text).try(:strip)[6..-1].try(:strip)
      deal.real_price_mask = page.at_css(".precoDe").try(:text).try(:strip)[5..-1].try(:strip)
      deal.description = page.at_css("#PassosConteudo").try(:text).try(:strip)[0,1200]
      #deal.category = PONTO_FRIO_CATEGORIES[page.at_css(".selected").try(:text).try(:strip)]
      deal.image_url = page.at_css("#imgProd")[:src].try(:strip)
    end
    
    deal.company = "Saraiva"
    #if deal.price
      deal.kind = Deal::KIND_OFFER
    #else
    #  deal.kind = Deal::KIND_ON_SALE
    #end
  end

  def self.populate_sepha_deal(deal)
    page = open_page(deal.link)

    deal.title = page.at_css(".infoDescricao").at_xpath("h1").try(:text).try(:strip)[0,255] if page.at_css(".infoDescricao") && page.at_css(".infoDescricao").at_xpath("h1")
    deal.price_mask = page.at_css(".precoPromocao").try(:text).split(" ")[1] if page.at_css(".precoPromocao")
    deal.real_price_mask = page.at_css(".precoPromocaoNormal").try(:text).split(" ")[2] if page.at_css(".precoPromocaoNormal")
    deal.description = page.at_css("#produto_descricao_principal").try(:text).try(:strip)[0,1200] if page.at_css("#produto_descricao_principal")
    deal.category = Deal::CATEGORY_BEAUTY_AND_HEALTH
    deal.image_url = page.at_css("#produto_imagem_descricao").at_xpath(".//img")[:src].try(:strip) if page.at_css("#produto_imagem_descricao") && page.at_css("#produto_imagem_descricao").at_xpath(".//img")
    deal.company = "Sepha"
    #if deal.price
      deal.kind = Deal::KIND_OFFER
    #else
    #  deal.kind = Deal::KIND_ON_SALE
    #end

    # puts "-"*100
    # puts "INICIO DA BUSCA NA PAGINA"
    # puts "-"*100
    # puts "TITULO = " + page.at_css(".infoDescricao").at_xpath(".//h1").try(:text).try(:strip)[0,255]
    # puts "PRECO PROMOCIONAL = " + page.at_css(".precoPromocao").try(:text).split(" ")[1]
    # puts "PRECO REAL = " + page.at_css(".precoPromocaoNormal").try(:text).split(" ")[2]
    # puts "DESCRICAO = " + page.at_css("#produto_descricao_principal").try(:text).try(:strip)[0,1200]
    # puts "CATEGORIA = " + FASTSHOP_CATEGORIES[page.at_css(".breadcrumb").try(:text).try(:strip).split(" ")[1]].to_s
    # puts "LINK DA IMAGEM = " + page.at_css("#produto_imagem_descricao").at_xpath(".//img")[:src].try(:strip)
    # binding.pry
    # puts "-"*100
    # puts "FIM DA BUSCA NA PAGINA"
    # puts "-"*100
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
