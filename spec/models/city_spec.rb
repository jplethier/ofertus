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
      City.hash_by_states.should == {"Oferta Nacional"=>[["Oferta Nacional", 276]], "Alagoas"=>[["Maceió", 277]], "Amapá"=>[["Macapá", 279]], "Amazonas"=>[["Manaus", 278]], "Bahia"=>[["Feira de Santana", 280], ["Salvador", 281]], "Ceará"=>[["Fortaleza", 282]], "Distrito Federal"=>[["Brasília", 283]], "Espírito Santo"=>[["Vitória", 303]], "Goiás"=>[["Anápolis", 284], ["Goiânia", 285]], "Maranhão"=>[["São Luis", 291]], "Mato Grosso"=>[["Cuiabá", 286], ["Rondonópolis", 287], ["Sinop", 288]], "Mato Grosso do Sul"=>[["Campo Grande", 289], ["Dourados", 290]], "Minas Gerais"=>[["Belo Horizonte", 292], ["Betim", 293], ["Contagem", 294], ["Governador Valadares", 295], ["Juiz de Fora", 296], ["Montes Claros", 297], ["Poços de Caldas", 298], ["Sete Lagoas", 299], ["Triângulo Mineiro", 300], ["Uberlândia", 301], ["Vale do Aço", 302]], "Pará"=>[["Belém", 304]], "Paraíba"=>[["Campina Grande", 305], ["João Pessoa", 306]], "Paraná"=>[["Cascavel", 307], ["Curitiba", 308], ["Foz do Iguaçu", 309], ["Guarapuava", 310], ["Londrina", 311], ["Maringá", 312], ["Ponta Grossa", 313], ["São José dos Pinhais", 314]], "Pernambuco"=>[["Caruaru", 315], ["Jaboatão", 316], ["Petrolina", 317], ["Recife", 318]], "Piauí"=>[["Teresina", 319]], "Rio de Janeiro"=>[["Campos dos Goytacazes", 320], ["Niterói", 321], ["Nova Friburgo", 322], ["Nova Iguaçu", 323], ["Petrópolis", 324], ["Região dos Lagos", 326], ["Região Serrana", 325], ["Resende", 327], ["Rio de Janeiro", 328], ["São Gonçalo", 329], ["Volta Redonda", 330]], "Rio Grande do Norte"=>[["Mossoró", 331], ["Natal", 332]], "Rio Grande do Sul"=>[["Caxias do Sul", 333], ["Gramado", 334], ["Passo Fundo", 335], ["Porto Alegre", 336], ["Santa Cruz do Sul", 337], ["Santa Maria", 338], ["Vale dos Sinos", 339]], "Rondônia"=>[["Porto Velho", 340]], "Santa Catarina"=>[["Balneário Camboriú", 341], ["Blumenau", 342], ["Chapecó", 343], ["Criciúma", 344], ["Florianópolis", 345], ["Joinville", 346]], "São Paulo"=>[["ABCD Paulista", 347], ["Alphaville", 348], ["Americana", 349], ["Araçatuba", 350], ["Araraquara", 351], ["Bauru", 352], ["Botucatu", 353], ["Campinas", 354], ["Cotia", 355], ["Franca", 356], ["Granja Viana", 357], ["Guaratingueta", 358], ["Guarulhos", 359], ["Indaiatuba", 360], ["Jaú", 361], ["Jundiaí", 362], ["Limeira", 363], ["Marília", 364], ["Mogi das Cruzes", 365], ["Osasco", 366], ["Piracicaba", 367], ["Presidente Prudente", 368], ["Ribeirão Preto", 369], ["Rio Claro", 370], ["Santa Bárbara", 371], ["Santos", 372], ["São Carlos", 373], ["São José do Rio Preto", 374], ["São José dos Campos", 375], ["São Paulo", 376], ["Sorocaba", 377], ["Taubaté", 378], ["Uberaba", 379]], "Sergipe"=>[["Aracaju", 380]], "Tocantins"=>[["Palmas", 381]]}
    end
  end
end
