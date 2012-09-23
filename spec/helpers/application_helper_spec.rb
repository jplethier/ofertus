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
describe ApplicationHelper do
  describe 'title' do
    it 'should return "Ofertus - Compartilhe Ofertas e ganhe com isso" if has no @title' do
      helper.title.should == "Ofertus - Compartilhe Ofertas e ganhe com isso"
    end

    it 'should return @title + " | Ofertus - Compartilhe Ofertas" if has @title' do
      @title = 'Titulo'
      helper.title.should == "Titulo | Ofertus - Compartilhe Ofertas"
    end
  end

  describe 'description' do
    it 'should return "Compartilhe, descubra, comente e opine sobre ofertas com seus amigos no Ofertus." if has no @description' do
      helper.description.should == "Compartilhe, descubra, comente e opine sobre ofertas com seus amigos no Ofertus."
    end

    it 'should return @description if has @description' do
      @description = 'Descricao'
      helper.description.should == "Descricao"
    end
  end
end