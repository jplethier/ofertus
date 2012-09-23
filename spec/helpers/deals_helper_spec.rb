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
      helper.search_city_options.should == "<option value=\"\">Todas Cidades</option><optgroup label=\"Oferta Nacional\"><option value=\"1\">Oferta Nacional</option></optgroup><optgroup label=\"Alagoas\"><option value=\"2\">Maceió</option></optgroup><optgroup label=\"Amapá\"><option value=\"4\">Macapá</option></optgroup><optgroup label=\"Amazonas\"><option value=\"3\">Manaus</option></optgroup><optgroup label=\"Bahia\"><option value=\"5\">Feira de Santana</option>\n<option value=\"6\">Salvador</option></optgroup><optgroup label=\"Ceará\"><option value=\"7\">Fortaleza</option></optgroup><optgroup label=\"Distrito Federal\"><option value=\"8\">Brasília</option></optgroup><optgroup label=\"Espírito Santo\"><option value=\"28\">Vitória</option></optgroup><optgroup label=\"Goiás\"><option value=\"9\">Anápolis</option>\n<option value=\"10\">Goiânia</option></optgroup><optgroup label=\"Maranhão\"><option value=\"16\">São Luis</option></optgroup><optgroup label=\"Mato Grosso\"><option value=\"11\">Cuiabá</option>\n<option value=\"12\">Rondonópolis</option>\n<option value=\"13\">Sinop</option></optgroup><optgroup label=\"Mato Grosso do Sul\"><option value=\"14\">Campo Grande</option>\n<option value=\"15\">Dourados</option></optgroup><optgroup label=\"Minas Gerais\"><option value=\"17\">Belo Horizonte</option>\n<option value=\"18\">Betim</option>\n<option value=\"19\">Contagem</option>\n<option value=\"20\">Governador Valadares</option>\n<option value=\"21\">Juiz de Fora</option>\n<option value=\"22\">Montes Claros</option>\n<option value=\"23\">Poços de Caldas</option>\n<option value=\"24\">Sete Lagoas</option>\n<option value=\"25\">Triângulo Mineiro</option>\n<option value=\"26\">Uberlândia</option>\n<option value=\"27\">Vale do Aço</option></optgroup><optgroup label=\"Pará\"><option value=\"29\">Belém</option></optgroup><optgroup label=\"Paraíba\"><option value=\"30\">Campina Grande</option>\n<option value=\"31\">João Pessoa</option></optgroup><optgroup label=\"Paraná\"><option value=\"32\">Cascavel</option>\n<option value=\"33\">Curitiba</option>\n<option value=\"34\">Foz do Iguaçu</option>\n<option value=\"35\">Guarapuava</option>\n<option value=\"36\">Londrina</option>\n<option value=\"37\">Maringá</option>\n<option value=\"38\">Ponta Grossa</option>\n<option value=\"39\">São José dos Pinhais</option></optgroup><optgroup label=\"Pernambuco\"><option value=\"40\">Caruaru</option>\n<option value=\"41\">Jaboatão</option>\n<option value=\"42\">Petrolina</option>\n<option value=\"43\">Recife</option></optgroup><optgroup label=\"Piauí\"><option value=\"44\">Teresina</option></optgroup><optgroup label=\"Rio de Janeiro\"><option value=\"45\">Campos dos Goytacazes</option>\n<option value=\"46\">Niterói</option>\n<option value=\"47\">Nova Friburgo</option>\n<option value=\"48\">Nova Iguaçu</option>\n<option value=\"49\">Petrópolis</option>\n<option value=\"51\">Região dos Lagos</option>\n<option value=\"50\">Região Serrana</option>\n<option value=\"52\">Resende</option>\n<option value=\"53\">Rio de Janeiro</option>\n<option value=\"54\">São Gonçalo</option>\n<option value=\"55\">Volta Redonda</option></optgroup><optgroup label=\"Rio Grande do Norte\"><option value=\"56\">Mossoró</option>\n<option value=\"57\">Natal</option></optgroup><optgroup label=\"Rio Grande do Sul\"><option value=\"58\">Caxias do Sul</option>\n<option value=\"59\">Gramado</option>\n<option value=\"60\">Passo Fundo</option>\n<option value=\"61\">Porto Alegre</option>\n<option value=\"62\">Santa Cruz do Sul</option>\n<option value=\"63\">Santa Maria</option>\n<option value=\"64\">Vale dos Sinos</option></optgroup><optgroup label=\"Rondônia\"><option value=\"65\">Porto Velho</option></optgroup><optgroup label=\"Santa Catarina\"><option value=\"66\">Balneário Camboriú</option>\n<option value=\"67\">Blumenau</option>\n<option value=\"68\">Chapecó</option>\n<option value=\"69\">Criciúma</option>\n<option value=\"70\">Florianópolis</option>\n<option value=\"71\">Joinville</option></optgroup><optgroup label=\"São Paulo\"><option value=\"72\">ABCD Paulista</option>\n<option value=\"73\">Alphaville</option>\n<option value=\"74\">Americana</option>\n<option value=\"75\">Araçatuba</option>\n<option value=\"76\">Araraquara</option>\n<option value=\"77\">Bauru</option>\n<option value=\"78\">Botucatu</option>\n<option value=\"79\">Campinas</option>\n<option value=\"80\">Cotia</option>\n<option value=\"81\">Franca</option>\n<option value=\"82\">Granja Viana</option>\n<option value=\"83\">Guaratingueta</option>\n<option value=\"84\">Guarulhos</option>\n<option value=\"85\">Indaiatuba</option>\n<option value=\"86\">Jaú</option>\n<option value=\"87\">Jundiaí</option>\n<option value=\"88\">Limeira</option>\n<option value=\"89\">Marília</option>\n<option value=\"90\">Mogi das Cruzes</option>\n<option value=\"91\">Osasco</option>\n<option value=\"92\">Piracicaba</option>\n<option value=\"93\">Presidente Prudente</option>\n<option value=\"94\">Ribeirão Preto</option>\n<option value=\"95\">Rio Claro</option>\n<option value=\"96\">Santa Bárbara</option>\n<option value=\"97\">Santos</option>\n<option value=\"98\">São Carlos</option>\n<option value=\"99\">São José do Rio Preto</option>\n<option value=\"100\">São José dos Campos</option>\n<option value=\"101\">São Paulo</option>\n<option value=\"102\">Sorocaba</option>\n<option value=\"103\">Taubaté</option>\n<option value=\"104\">Uberaba</option></optgroup><optgroup label=\"Sergipe\"><option value=\"105\">Aracaju</option></optgroup><optgroup label=\"Tocantins\"><option value=\"106\">Palmas</option></optgroup>"
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