# coding: UTF-8
class City < ActiveRecord::Base
  has_paper_trail


  BRASIL_CITIES = [
    { :state => "Brasil",  :name => "Oferta Nacional" },
    { :state => "Alagoas",  :name => "Maceió" },
    { :state => "Amazonas",  :name => "Manaus" },
    { :state => "Amapá",  :name => "Macapá" },
    { :state => "Bahia",  :name => "Feira de Santana" },
    { :state => "Bahia",  :name => "Salvador" },
    { :state => "Ceará",  :name => "Fortaleza" },
    { :state => "Distrito Federal",  :name => "Brasília" },
    { :state => "Goiás",  :name => "Anápolis" },
    { :state => "Goiás",  :name => "Goiânia" },
    { :state => "Mato Grosso",  :name => "Cuiabá" },
    { :state => "Mato Grosso",  :name => "Rondonópolis" },
    { :state => "Mato Grosso",  :name => "Sinop" },
    { :state => "Mato Grosso do Sul",  :name => "Campo Grande" },
    { :state => "Mato Grosso do Sul",  :name => "Dourados" },
    { :state => "Maranhão",  :name => "São Luis" },
    { :state => "Minas Gerais",  :name => "Belo Horizonte" },
    { :state => "Minas Gerais",  :name => "Betim" },
    { :state => "Minas Gerais",  :name => "Contagem" },
    { :state => "Minas Gerais",  :name => "Governador Valadares" },
    { :state => "Minas Gerais",  :name => "Juiz de Fora" },
    { :state => "Minas Gerais",  :name => "Montes Claros" },
    { :state => "Minas Gerais",  :name => "Poços de Caldas" },
    { :state => "Minas Gerais",  :name => "Sete Lagoas" },
    { :state => "Minas Gerais",  :name => "Triângulo Mineiro" },
    { :state => "Minas Gerais",  :name => "Uberlândia" },
    { :state => "Minas Gerais",  :name => "Vale do Aço" },
    { :state => "Espírito Santo",  :name => "Vitória" },
    { :state => "Pará",  :name => "Belém" },
    { :state => "Paraíba",  :name => "Campina Grande" },
    { :state => "Paraíba",  :name => "João Pessoa" },
    { :state => "Paraná",  :name => "Cascavel" },
    { :state => "Paraná",  :name => "Curitiba" },
    { :state => "Paraná",  :name => "Foz do Iguaçu" },
    { :state => "Paraná",  :name => "Guarapuava" },
    { :state => "Paraná",  :name => "Londrina" },
    { :state => "Paraná",  :name => "Maringá" },
    { :state => "Paraná",  :name => "Ponta Grossa" },
    { :state => "Paraná",  :name => "São José dos Pinhais" },
    { :state => "Pernambuco",  :name => "Caruaru" },
    { :state => "Pernambuco",  :name => "Jaboatão" },
    { :state => "Pernambuco",  :name => "Petrolina" },
    { :state => "Pernambuco",  :name => "Recife" },
    { :state => "Piauí",  :name => "Teresina" },
    { :state => "Rio de Janeiro",  :name => "Campos dos Goytacazes" },
    { :state => "Rio de Janeiro",  :name => "Niterói" },
    { :state => "Rio de Janeiro",  :name => "Nova Friburgo" },
    { :state => "Rio de Janeiro",  :name => "Nova Iguaçu" },
    { :state => "Rio de Janeiro",  :name => "Petrópolis" },
    { :state => "Rio de Janeiro",  :name => "Região Serrana" },
    { :state => "Rio de Janeiro",  :name => "Região dos Lagos" },
    { :state => "Rio de Janeiro",  :name => "Resende" },
    { :state => "Rio de Janeiro",  :name => "Rio de Janeiro" },
    { :state => "Rio de Janeiro",  :name => "São Gonçalo" },
    { :state => "Rio de Janeiro",  :name => "Volta Redonda" },
    { :state => "Rio Grande do Norte",  :name => "Mossoró" },
    { :state => "Rio Grande do Norte",  :name => "Natal" },
    { :state => "Rio Grande do Sul",  :name => "Caxias do Sul" },
    { :state => "Rio Grande do Sul",  :name => "Gramado" },
    { :state => "Rio Grande do Sul",  :name => "Passo Fundo" },
    { :state => "Rio Grande do Sul",  :name => "Porto Alegre" },
    { :state => "Rio Grande do Sul",  :name => "Santa Cruz do Sul" },
    { :state => "Rio Grande do Sul",  :name => "Santa Maria" },
    { :state => "Rio Grande do Sul",  :name => "Vale dos Sinos" },
    { :state => "Rondônia",  :name => "Porto Velho" },
    { :state => "Santa Catarina",  :name => "Balneário Camboriú" },
    { :state => "Santa Catarina",  :name => "Blumenau" },
    { :state => "Santa Catarina",  :name => "Chapecó" },
    { :state => "Santa Catarina",  :name => "Criciúma" },
    { :state => "Santa Catarina",  :name => "Florianópolis" },
    { :state => "Santa Catarina",  :name => "Joinville" },
    { :state => "São Paulo",  :name => "ABCD Paulista" },
    { :state => "São Paulo",  :name => "Alphaville" },
    { :state => "São Paulo",  :name => "Americana" },
    { :state => "São Paulo",  :name => "Araçatuba" },
    { :state => "São Paulo",  :name => "Araraquara" },
    { :state => "São Paulo",  :name => "Bauru" },
    { :state => "São Paulo",  :name => "Botucatu" },
    { :state => "São Paulo",  :name => "Campinas" },
    { :state => "São Paulo",  :name => "Cotia" },
    { :state => "São Paulo",  :name => "Franca" },
    { :state => "São Paulo",  :name => "Granja Viana" },
    { :state => "São Paulo",  :name => "Guaratingueta" },
    { :state => "São Paulo",  :name => "Guarulhos" },
    { :state => "São Paulo",  :name => "Indaiatuba" },
    { :state => "São Paulo",  :name => "Jaú" },
    { :state => "São Paulo",  :name => "Jundiaí" },
    { :state => "São Paulo",  :name => "Limeira" },
    { :state => "São Paulo",  :name => "Marília" },
    { :state => "São Paulo",  :name => "Mogi das Cruzes" },
    { :state => "São Paulo",  :name => "Osasco" },
    { :state => "São Paulo",  :name => "Piracicaba" },
    { :state => "São Paulo",  :name => "Presidente Prudente" },
    { :state => "São Paulo",  :name => "Ribeirão Preto" },
    { :state => "São Paulo",  :name => "Rio Claro" },
    { :state => "São Paulo",  :name => "Santa Bárbara" },
    { :state => "São Paulo",  :name => "Santos" },
    { :state => "São Paulo",  :name => "São Carlos" },
    { :state => "São Paulo",  :name => "São José do Rio Preto" },
    { :state => "São Paulo",  :name => "São José dos Campos" },
    { :state => "São Paulo",  :name => "São Paulo" },
    { :state => "São Paulo",  :name => "Sorocaba" },
    { :state => "São Paulo",  :name => "Taubaté" },
    { :state => "São Paulo",  :name => "Uberaba" },
    { :state => "Sergipe",    :name => "Aracaju" },
    { :state => "Tocantins",  :name => "Palmas" }
  ]

  has_and_belongs_to_many :users
  has_many :deals

  validates :country,   :presence => true
  validates :name,      :presence => true
  validates :state,     :presence => true

  scope :order_by_state, order('cities.state').order('cities.name')
  scope :without_national_offer, where("cities.name <> ?", "Oferta Nacional")
  scope :get_national_offer, where("cities.name = ?", "Oferta Nacional")

  def self.hash_by_states
    hash_of_states = {}
    cities = City.order_by_state.without_national_offer
    national = City.get_national_offer
    hash_of_states = {"Oferta Nacional" => [[national[0].name, national[0].id]]} if national[0]
    last_state = cities[0].state
    cities_of_last_state = []
    cities.each do |c|
      if c.state == last_state
        cities_of_last_state = cities_of_last_state + [[c.name, c.id]]
      else
        hash_of_states.merge!({last_state => cities_of_last_state})
        last_state = c.state
        cities_of_last_state = [[c.name, c.id]]
      end
    end
    hash_of_states.merge!({last_state => cities_of_last_state})
  end
end
