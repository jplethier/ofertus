#encoding: UTF-8
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Emanuel', :city => cities.first)
#
#puts 'SETTING UP DEFAULT USER LOGIN'
#FactoryGirl.create :confirmed_user, :username => 'bruno', :password => '123qwe', :password_confirmation => '123qwe'

puts 'INSERTING BRASIL CITIES'
if City.all.empty?
	brasil_cities = [
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

  brasil_cities.each do |city|
    City.create(:country => 'Brasil', :state => city[:state], :name => city[:name])
  end
end

if User.all.empty? && Rails.env != 'test'
  fake_users = [
    { :username => "bruno_abreu",     :name => "Bruno Abreu",               :email => "brunoAbreu@oi.com.br" },
    { :username => "manuel_cabral",   :name => "Manuel Cabral",             :email => "manuel555@hotmail.com" },
    { :username => "mariana_alves",   :name => "Mariana Alves",             :email => "alves_mariana@yahoo.com" },
    { :username => "paula_santos",    :name => "Paula dos Santos",          :email => "paula_21@hotmail.com" },
    { :username => "jpsilva",         :name => "João Paulo da Silva",       :email => "jpsilva@gmail.com" },
    { :username => "marianamg",       :name => "Mariana Martins Gonçalves", :email => "marianamartins@hotmail.com"},
    { :username => "felipeCS",        :name => "Felipe Costa e Silva",      :email => "felipecs@ig.com.br"},
    { :username => "joao_pedro",      :name => "João Pedro Guimarães",      :email => "jpguimaraes_rj@hotmail.com",  },
    { :username => "aline_nascimento",:name => "Aline Nascimento",          :email => "aline_nasc@yahoo.com",  },
    { :username => "renata_vicente",  :name => "Renata Vicente",            :email => "re_vicente@hotmail.com",  }
  ]  
  fake_users.each do |fake|
    User.create!(:username => fake[:username], :name => fake[:name], :email => fake[:email], 
                      :password => '123OfertuS', :password_confirmation => '123OfertuS').confirm!
  end
end    