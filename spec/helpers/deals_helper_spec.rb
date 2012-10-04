# coding: UTF-8
require 'spec_helper'

# Specs in this file have access to a helper object that includes
# the DealsHelper. For example:
#
# describe DealsHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       helper.concat_strings("this","that").should == "this that"
#     end
#   end
# end
describe DealsHelper do
  describe 'price to currency' do
    it 'should show the price in the correct currency format' do
      helper.price_to_currency(1.19).should == 'R$ <strong>1</strong>,19'
      helper.price_to_currency(1).should == 'R$ <strong>1</strong>,00'
      helper.price_to_currency(1000).should == 'R$ <strong>1.000</strong>,00'
      helper.price_to_currency(-5).should == '-R$<strong>5</strong>,00'
      helper.price_to_currency('not a number').should raise_error
      begin
        helper.price_to_currency('not a number', :raise => true)
        true.should == false
      rescue ActionView::Helpers::NumberHelper::InvalidNumberError
        #deve ter uma excecao
      end
    end
  end

  describe 'search options' do
    it 'should return the options to order the deals list with no selected item' do
      helper.search_options.should == "<option value=\"most_recent\">Mais Recente</option>\n<option value=\"lowest_price\">Menor Preço</option>\n<option value=\"highest_price\">Maior Preço</option>\n<option value=\"highest_discount\">Maior Desconto</option>"
    end

    it 'should return the options with the selected' do
      helper.search_options('most_recent').should == "<option value=\"most_recent\" selected=\"selected\">Mais Recente</option>\n<option value=\"lowest_price\">Menor Preço</option>\n<option value=\"highest_price\">Maior Preço</option>\n<option value=\"highest_discount\">Maior Desconto</option>"
      helper.search_options('lowest_price').should == "<option value=\"most_recent\">Mais Recente</option>\n<option value=\"lowest_price\" selected=\"selected\">Menor Preço</option>\n<option value=\"highest_price\">Maior Preço</option>\n<option value=\"highest_discount\">Maior Desconto</option>"
      helper.search_options('highest_price').should == "<option value=\"most_recent\">Mais Recente</option>\n<option value=\"lowest_price\">Menor Preço</option>\n<option value=\"highest_price\" selected=\"selected\">Maior Preço</option>\n<option value=\"highest_discount\">Maior Desconto</option>"
      helper.search_options('highest_discount').should == "<option value=\"most_recent\">Mais Recente</option>\n<option value=\"lowest_price\">Menor Preço</option>\n<option value=\"highest_price\">Maior Preço</option>\n<option value=\"highest_discount\" selected=\"selected\">Maior Desconto</option>"
    end
  end

  describe 'search city options' do
    it 'should return the options to order the deals list with no selected item' do
      helper.search_city_options.should == "<option value=\"\">Todas Cidades</option><optgroup label=\"Oferta Nacional\"><option value=\"276\">Oferta Nacional</option></optgroup><optgroup label=\"Alagoas\"><option value=\"277\">Maceió</option></optgroup><optgroup label=\"Amapá\"><option value=\"279\">Macapá</option></optgroup><optgroup label=\"Amazonas\"><option value=\"278\">Manaus</option></optgroup><optgroup label=\"Bahia\"><option value=\"280\">Feira de Santana</option>\n<option value=\"281\">Salvador</option></optgroup><optgroup label=\"Ceará\"><option value=\"282\">Fortaleza</option></optgroup><optgroup label=\"Distrito Federal\"><option value=\"283\">Brasília</option></optgroup><optgroup label=\"Espírito Santo\"><option value=\"303\">Vitória</option></optgroup><optgroup label=\"Goiás\"><option value=\"284\">Anápolis</option>\n<option value=\"285\">Goiânia</option></optgroup><optgroup label=\"Maranhão\"><option value=\"291\">São Luis</option></optgroup><optgroup label=\"Mato Grosso\"><option value=\"286\">Cuiabá</option>\n<option value=\"287\">Rondonópolis</option>\n<option value=\"288\">Sinop</option></optgroup><optgroup label=\"Mato Grosso do Sul\"><option value=\"289\">Campo Grande</option>\n<option value=\"290\">Dourados</option></optgroup><optgroup label=\"Minas Gerais\"><option value=\"292\">Belo Horizonte</option>\n<option value=\"293\">Betim</option>\n<option value=\"294\">Contagem</option>\n<option value=\"295\">Governador Valadares</option>\n<option value=\"296\">Juiz de Fora</option>\n<option value=\"297\">Montes Claros</option>\n<option value=\"298\">Poços de Caldas</option>\n<option value=\"299\">Sete Lagoas</option>\n<option value=\"300\">Triângulo Mineiro</option>\n<option value=\"301\">Uberlândia</option>\n<option value=\"302\">Vale do Aço</option></optgroup><optgroup label=\"Pará\"><option value=\"304\">Belém</option></optgroup><optgroup label=\"Paraíba\"><option value=\"305\">Campina Grande</option>\n<option value=\"306\">João Pessoa</option></optgroup><optgroup label=\"Paraná\"><option value=\"307\">Cascavel</option>\n<option value=\"308\">Curitiba</option>\n<option value=\"309\">Foz do Iguaçu</option>\n<option value=\"310\">Guarapuava</option>\n<option value=\"311\">Londrina</option>\n<option value=\"312\">Maringá</option>\n<option value=\"313\">Ponta Grossa</option>\n<option value=\"314\">São José dos Pinhais</option></optgroup><optgroup label=\"Pernambuco\"><option value=\"315\">Caruaru</option>\n<option value=\"316\">Jaboatão</option>\n<option value=\"317\">Petrolina</option>\n<option value=\"318\">Recife</option></optgroup><optgroup label=\"Piauí\"><option value=\"319\">Teresina</option></optgroup><optgroup label=\"Rio de Janeiro\"><option value=\"320\">Campos dos Goytacazes</option>\n<option value=\"321\">Niterói</option>\n<option value=\"322\">Nova Friburgo</option>\n<option value=\"323\">Nova Iguaçu</option>\n<option value=\"324\">Petrópolis</option>\n<option value=\"326\">Região dos Lagos</option>\n<option value=\"325\">Região Serrana</option>\n<option value=\"327\">Resende</option>\n<option value=\"328\">Rio de Janeiro</option>\n<option value=\"329\">São Gonçalo</option>\n<option value=\"330\">Volta Redonda</option></optgroup><optgroup label=\"Rio Grande do Norte\"><option value=\"331\">Mossoró</option>\n<option value=\"332\">Natal</option></optgroup><optgroup label=\"Rio Grande do Sul\"><option value=\"333\">Caxias do Sul</option>\n<option value=\"334\">Gramado</option>\n<option value=\"335\">Passo Fundo</option>\n<option value=\"336\">Porto Alegre</option>\n<option value=\"337\">Santa Cruz do Sul</option>\n<option value=\"338\">Santa Maria</option>\n<option value=\"339\">Vale dos Sinos</option></optgroup><optgroup label=\"Rondônia\"><option value=\"340\">Porto Velho</option></optgroup><optgroup label=\"Santa Catarina\"><option value=\"341\">Balneário Camboriú</option>\n<option value=\"342\">Blumenau</option>\n<option value=\"343\">Chapecó</option>\n<option value=\"344\">Criciúma</option>\n<option value=\"345\">Florianópolis</option>\n<option value=\"346\">Joinville</option></optgroup><optgroup label=\"São Paulo\"><option value=\"347\">ABCD Paulista</option>\n<option value=\"348\">Alphaville</option>\n<option value=\"349\">Americana</option>\n<option value=\"350\">Araçatuba</option>\n<option value=\"351\">Araraquara</option>\n<option value=\"352\">Bauru</option>\n<option value=\"353\">Botucatu</option>\n<option value=\"354\">Campinas</option>\n<option value=\"355\">Cotia</option>\n<option value=\"356\">Franca</option>\n<option value=\"357\">Granja Viana</option>\n<option value=\"358\">Guaratingueta</option>\n<option value=\"359\">Guarulhos</option>\n<option value=\"360\">Indaiatuba</option>\n<option value=\"361\">Jaú</option>\n<option value=\"362\">Jundiaí</option>\n<option value=\"363\">Limeira</option>\n<option value=\"364\">Marília</option>\n<option value=\"365\">Mogi das Cruzes</option>\n<option value=\"366\">Osasco</option>\n<option value=\"367\">Piracicaba</option>\n<option value=\"368\">Presidente Prudente</option>\n<option value=\"369\">Ribeirão Preto</option>\n<option value=\"370\">Rio Claro</option>\n<option value=\"371\">Santa Bárbara</option>\n<option value=\"372\">Santos</option>\n<option value=\"373\">São Carlos</option>\n<option value=\"374\">São José do Rio Preto</option>\n<option value=\"375\">São José dos Campos</option>\n<option value=\"376\">São Paulo</option>\n<option value=\"377\">Sorocaba</option>\n<option value=\"378\">Taubaté</option>\n<option value=\"379\">Uberaba</option></optgroup><optgroup label=\"Sergipe\"><option value=\"380\">Aracaju</option></optgroup><optgroup label=\"Tocantins\"><option value=\"381\">Palmas</option></optgroup>"
    end
  end

  describe 'truncate title' do
    it 'should truncate at 60 if no length is passed' do
      helper.truncate_title('a'*61).should == 'a'*57 + '...'
    end

    it 'should not truncate if the length of the string is less then the length passed' do
      helper.truncate_title('a'*57).should == 'a'*57
      helper.truncate_title('a'*118, 121).should == 'a'*118
    end

    it 'should truncate at length if it passed' do
      helper.truncate_title('a'*100, 30).should == 'a'*27 + '...'
      helper.truncate_title('a'*100, 93).should == 'a'*90 + '...'
    end
  end
end