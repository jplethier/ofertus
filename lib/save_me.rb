# encoding: UTF-8
# require 'anemone'
require 'open-uri'

class SaveMe
  attr_reader :doc

  DIRECTORY_PATH = "tmp/crawler/"

  XPATH_LINKS = '//div[@class="offer"]/div[@class="offer_text"]/a'

  XPATH_ADDRESS = '//p[@class="endereco_local"]'
  XPATH_COMPANY = '//p[@class="nome_local"]'
  XPATH_DESCRIPTION = '//div[@class="detalhes_middle"]//p'
  XPATH_LINK = '//div[@class="ir-para-site"]/a'
  XPATH_PRICE = '//p[@class="preco-atual"]/span[@class="preco"]'
  XPATH_REAL_PRICE = '//p[@class="preco-antigo"]/span[@class="preco"]'
  XPATH_TITLE = '//div[@class="oferta-imagem"]//a'

  URL = "http://www.saveme.com.br/"
  DAILY_DEALS = "compra-coletiva/"

  CATEGORIES = {
    "bares-e-baladas" => Deal::CATEGORY_RESTAURANT,
    "cursos-e-aulas" => Deal::CATEGORY_CULTURE,
    "entretenimento" => Deal::CATEGORY_ENTERTAINMENT,
    "esporte" => Deal::CATEGORY_ENTERTAINMENT,
    "hoteis-e-viagens" => Deal::CATEGORY_TRAVEL,
    "produtos" => nil,
    "restaurantes" => Deal::CATEGORY_RESTAURANT,
    "saude-e-beleza" => Deal::CATEGORY_BEAUTY_AND_HEALTH,
    "servicos-locais" => Deal::CATEGORY_OTHER
  }

  def initialize
    @city_id = get_city_id "Rio de Janeiro"
    @user_id = get_user_id
    @filename = create_log_file
  end

  #Open the link with 'utf-8' encoding.
  def open_page(link)
    # puts "Opening page '#{link}'"
    page = Nokogiri::HTML(open(link).read) #Nokogiri bug: You need to use .read method in order to use encoding.
    page.encoding = 'utf-8'
    page
  end

  def open_page_number(number)
    @doc = open_page("#{URL}#{DAILY_DEALS}rio-de-janeiro/pagina-#{number}/")
  end

  def get_user_id(username = "ofertus")
    user = User.find_by_username(username)
    raise Exception, "User '#{username}' not found" unless user
    user.id
  end

  def get_city_id(city_name)
    city = City.find_by_name("Rio de Janeiro")
    raise Exception, "City '#{city_name}' not found" unless city
    city.id
  end

  def create_log_file
    Dir.mkdir(DIRECTORY_PATH) unless File.directory? DIRECTORY_PATH
    filename = "#{DIRECTORY_PATH}#{Time.now.strftime("%Y-%m-%d_%H-%M")}.txt"
    # puts "Creating file '#{filename}'"
    filename
  end

  def links_to_crawl
    @doc.xpath(XPATH_LINKS).collect { |link| link[:href] }
  end


  def create_deals
    1.upto 10 do |page_number|
      open_page_number page_number

      links_to_crawl.each do |link|
        page = open_page "#{URL}#{link}"
        deal = populate_deal page, link

        if Deal.exists? :title => deal.title, :company => deal.company, :end_date => deal.end_date
          File.open(@filename, 'a') {|f| f.write("Deal '#{deal.title}' already exists.'\n") }
        else
          if deal.save
            File.open(@filename, 'a') {|f| f.write("Deal '#{deal.title}' created.'\n") }
          else
            File.open(@filename, 'a') {|f| f.write("#{deal.errors.inspect}\n") }
          end
        end
      end
    end
  end

  def populate_deal(page, link)
    deal_hash = {}

    deal_hash[:address] = try_catch { page.xpath(XPATH_ADDRESS).children.first.text.scan(/.+\n/).first.strip }

    category = try_catch { link.scan(/rio-de-janeiro\/(.*)\//).first.first }
    deal_hash[:category] = CATEGORIES[category]

    deal_hash[:city_id] = @city_id
    deal_hash[:company] = try_catch { page.xpath(XPATH_COMPANY).text }
    deal_hash[:description] = try_catch { page.xpath(XPATH_DESCRIPTION).first.text.strip }

    contador = try_catch { page.css('script').grep(/atualizaContador/).first.children.text.scan(/\((.*)\)/).first.first.split(',') }
    deal_hash[:end_date] = contador ? (Time.new contador[0], contador[1], contador[2], contador[3], contador[4], contador[5].to_i) : nil

    deal_hash[:kind] = try_catch { Deal::KIND_DAILY_DEAL }
    deal_hash[:link] = try_catch { page.xpath(XPATH_LINK).first[:href].strip }
    deal_hash[:price_mask] = try_catch { page.xpath(XPATH_PRICE).first.text.strip }
    deal_hash[:real_price_mask] = try_catch { page.xpath(XPATH_REAL_PRICE).first.text.strip }
    deal_hash[:title] = try_catch { page.xpath(XPATH_TITLE).text }
    deal_hash[:user_id] = @user_id

    Deal.new deal_hash
  end

  def try_catch(&block)
    begin
      block.call
    rescue Exception => ex
      nil #TODO: LOGGER
    end
  end
end
