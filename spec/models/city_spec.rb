#coding: UTF-8
require 'spec_helper'

describe City do
  let(:city) { FactoryGirl.build :city }
  subject { city }

  its(:save) { should be_true }
  its(:switched_on?) { should be_true }

  it { should respond_to :users }
  it { should respond_to :deals }

  describe "Accessibility" do
    it { should allow_mass_assignment_of(:name) }
    it { should allow_mass_assignment_of(:state) }
    it { should allow_mass_assignment_of(:country) }
  end

  describe "Validations" do
    it "should require a name" do
      city.name = nil
      city.should_not be_valid
    end

    it "should require a state" do
      city.state = nil
      city.should_not be_valid
    end

    it "should require a country" do
      city.country = nil
      city.should_not be_valid
    end
  end

  describe "hash of states" do
    it "should return a hash grouped by states and ordered by states, cities names" do
      # City.hash_by_states.should == {"Oferta Nacional"=>[["Oferta Nacional", 7238]], "Alagoas"=>[["Maceió", 7239]], "Amapá"=>[["Macapá", 7241]], "Amazonas"=>[["Manaus", 7240]], "Bahia"=>[["Feira de Santana", 7242], ["Salvador", 7243]], "Ceará"=>[["Fortaleza", 7244]], "Distrito Federal"=>[["Brasília", 7245]], "Espírito Santo"=>[["Vitória", 7265]], "Goiás"=>[["Anápolis", 7246], ["Goiânia", 7247]], "Maranhão"=>[["São Luis", 7253]], "Mato Grosso"=>[["Cuiabá", 7248], ["Rondonópolis", 7249], ["Sinop", 7250]], "Mato Grosso do Sul"=>[["Campo Grande", 7251], ["Dourados", 7252]], "Minas Gerais"=>[["Belo Horizonte", 7254], ["Betim", 7255], ["Contagem", 7256], ["Governador Valadares", 7257], ["Juiz de Fora", 7258], ["Montes Claros", 7259], ["Poços de Caldas", 7260], ["Sete Lagoas", 7261], ["Triângulo Mineiro", 7262], ["Uberlândia", 7263], ["Vale do Aço", 7264]], "Pará"=>[["Belém", 7266]], "Paraíba"=>[["Campina Grande", 7267], ["João Pessoa", 7268]], "Paraná"=>[["Cascavel", 7269], ["Curitiba", 7270], ["Foz do Iguaçu", 7271], ["Guarapuava", 7272], ["Londrina", 7273], ["Maringá", 7274], ["Ponta Grossa", 7275], ["São José dos Pinhais", 7276]], "Pernambuco"=>[["Caruaru", 7277], ["Jaboatão", 7278], ["Petrolina", 7279], ["Recife", 7280]], "Piauí"=>[["Teresina", 7281]], "Rio de Janeiro"=>[["Campos dos Goytacazes", 7282], ["Niterói", 7283], ["Nova Friburgo", 7284], ["Nova Iguaçu", 7285], ["Petrópolis", 7286], ["Região dos Lagos", 7288], ["Região Serrana", 7287], ["Resende", 7289], ["Rio de Janeiro", 7290], ["São Gonçalo", 7291], ["Volta Redonda", 7292]], "Rio Grande do Norte"=>[["Mossoró", 7293], ["Natal", 7294]], "Rio Grande do Sul"=>[["Caxias do Sul", 7295], ["Gramado", 7296], ["Passo Fundo", 7297], ["Porto Alegre", 7298], ["Santa Cruz do Sul", 7299], ["Santa Maria", 7300], ["Vale dos Sinos", 7301]], "Rondônia"=>[["Porto Velho", 7302]], "Santa Catarina"=>[["Balneário Camboriú", 7303], ["Blumenau", 7304], ["Chapecó", 7305], ["Criciúma", 7306], ["Florianópolis", 7307], ["Joinville", 7308]], "São Paulo"=>[["ABCD Paulista", 7309], ["Alphaville", 7310], ["Americana", 7311], ["Araçatuba", 7312], ["Araraquara", 7313], ["Bauru", 7314], ["Botucatu", 7315], ["Campinas", 7316], ["Cotia", 7317], ["Franca", 7318], ["Granja Viana", 7319], ["Guaratingueta", 7320], ["Guarulhos", 7321], ["Indaiatuba", 7322], ["Jaú", 7323], ["Jundiaí", 7324], ["Limeira", 7325], ["Marília", 7326], ["Mogi das Cruzes", 7327], ["Osasco", 7328], ["Piracicaba", 7329], ["Presidente Prudente", 7330], ["Ribeirão Preto", 7331], ["Rio Claro", 7332], ["Santa Bárbara", 7333], ["Santos", 7334], ["São Carlos", 7335], ["São José do Rio Preto", 7336], ["São José dos Campos", 7337], ["São Paulo", 7338], ["Sorocaba", 7339], ["Taubaté", 7340], ["Uberaba", 7341]], "Sergipe"=>[["Aracaju", 7342]], "Tocantins"=>[["Palmas", 7343]]}
    end
  end
end
