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
      City.hash_by_states.should == {"Oferta Nacional"=>[["Oferta Nacional", 1]], "Alagoas"=>[["Maceió", 2]], "Amapá"=>[["Macapá", 4]], "Amazonas"=>[["Manaus", 3]], "Bahia"=>[["Feira de Santana", 5], ["Salvador", 6]], "Ceará"=>[["Fortaleza", 7]], "Distrito Federal"=>[["Brasília", 8]], "Espírito Santo"=>[["Vitória", 28]], "Goiás"=>[["Anápolis", 9], ["Goiânia", 10]], "Maranhão"=>[["São Luis", 16]], "Mato Grosso"=>[["Cuiabá", 11], ["Rondonópolis", 12], ["Sinop", 13]], "Mato Grosso do Sul"=>[["Campo Grande", 14], ["Dourados", 15]], "Minas Gerais"=>[["Belo Horizonte", 17], ["Betim", 18], ["Contagem", 19], ["Governador Valadares", 20], ["Juiz de Fora", 21], ["Montes Claros", 22], ["Poços de Caldas", 23], ["Sete Lagoas", 24], ["Triângulo Mineiro", 25], ["Uberlândia", 26], ["Vale do Aço", 27]], "Pará"=>[["Belém", 29]], "Paraíba"=>[["Campina Grande", 30], ["João Pessoa", 31]], "Paraná"=>[["Cascavel", 32], ["Curitiba", 33], ["Foz do Iguaçu", 34], ["Guarapuava", 35], ["Londrina", 36], ["Maringá", 37], ["Ponta Grossa", 38], ["São José dos Pinhais", 39]], "Pernambuco"=>[["Caruaru", 40], ["Jaboatão", 41], ["Petrolina", 42], ["Recife", 43]], "Piauí"=>[["Teresina", 44]], "Rio de Janeiro"=>[["Campos dos Goytacazes", 45], ["Niterói", 46], ["Nova Friburgo", 47], ["Nova Iguaçu", 48], ["Petrópolis", 49], ["Região dos Lagos", 51], ["Região Serrana", 50], ["Resende", 52], ["Rio de Janeiro", 53], ["São Gonçalo", 54], ["Volta Redonda", 55]], "Rio Grande do Norte"=>[["Mossoró", 56], ["Natal", 57]], "Rio Grande do Sul"=>[["Caxias do Sul", 58], ["Gramado", 59], ["Passo Fundo", 60], ["Porto Alegre", 61], ["Santa Cruz do Sul", 62], ["Santa Maria", 63], ["Vale dos Sinos", 64]], "Rondônia"=>[["Porto Velho", 65]], "Santa Catarina"=>[["Balneário Camboriú", 66], ["Blumenau", 67], ["Chapecó", 68], ["Criciúma", 69], ["Florianópolis", 70], ["Joinville", 71]], "São Paulo"=>[["ABCD Paulista", 72], ["Alphaville", 73], ["Americana", 74], ["Araçatuba", 75], ["Araraquara", 76], ["Bauru", 77], ["Botucatu", 78], ["Campinas", 79], ["Cotia", 80], ["Franca", 81], ["Granja Viana", 82], ["Guaratingueta", 83], ["Guarulhos", 84], ["Indaiatuba", 85], ["Jaú", 86], ["Jundiaí", 87], ["Limeira", 88], ["Marília", 89], ["Mogi das Cruzes", 90], ["Osasco", 91], ["Piracicaba", 92], ["Presidente Prudente", 93], ["Ribeirão Preto", 94], ["Rio Claro", 95], ["Santa Bárbara", 96], ["Santos", 97], ["São Carlos", 98], ["São José do Rio Preto", 99], ["São José dos Campos", 100], ["São Paulo", 101], ["Sorocaba", 102], ["Taubaté", 103], ["Uberaba", 104]], "Sergipe"=>[["Aracaju", 105]], "Tocantins"=>[["Palmas", 106]]}
    end
  end
end
