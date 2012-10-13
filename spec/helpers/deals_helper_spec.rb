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

    let!(:national) {FactoryGirl.create(:city, :name => 'Oferta Nacional', :state => 'Oferta Nacional')}
    let!(:first) {FactoryGirl.create(:city, :name => 'Maceió', :state => 'Alagoas')}
    let!(:second) {FactoryGirl.create(:city, :name => 'Macapá', :state => 'Amapá')}

    it 'should return the options to order the deals list with no selected item' do
      helper.search_city_options.should == "<option value=\"\">Todas Cidades</option><optgroup label=\"Oferta Nacional\"><option value=\"#{national.id}\">Oferta Nacional</option></optgroup><optgroup label=\"Alagoas\"><option value=\"#{first.id}\">Maceió</option></optgroup><optgroup label=\"Amapá\"><option value=\"#{second.id}\">Macapá</option></optgroup>"
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