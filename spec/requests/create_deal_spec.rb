# -*- encoding : utf-8 -*-
require 'spec_helper'

describe "New Deal Page" do
  include Warden::Test::Helpers
  Warden.test_mode!

  before do
    login_as FactoryGirl.create(:user), :scope => :user
    visit new_deal_path
  end

  after { Warden.test_reset! }

  it 'should show the new deal form' do
    within '#col-left' do
      should have_content('Nova Oferta')
    end
    within '#col-left #page-login' do
      should have_content("Compartilhe uma oferta preenchendo os campos abaixo e clicando em 'Confirmar'")
    end
    within "#col-left #page-login .ct-inputs-login form#new_deal" do
      should have_css('p label', :for => 'deal_title', :text => 'Título')
      should have_css('p input#deal_title.user-senha', :type => :text)
      should have_css('p label', :for => 'deal_kind', :text => 'Tipo')
      should have_css('p select#deal_kind.user-senha')
      should have_css('p select#deal_kind option', :text => 'Selecione')
      should have_css('p select#deal_kind option', :text => 'Ofertas', :value => "1")
      should have_css('p select#deal_kind option', :text => 'Compras Coletivas', :value => "2")
      should have_css('p select#deal_kind option', :text => 'Liquidação', :value => "3")
      should_not have_css('p#p_deal_real_price')
      should_not have_css('p#p_deal_real_price label', :for => 'deal_real_price')
      should_not have_css('p#p_deal_real_price input#deal_real_price_mask.money.user-senha', :type => :text)
      should_not have_css('p#p_deal_price')
      should_not have_css('p#p_deal_price label', :for => 'deal_price')
      should_not have_css('p#p_deal_price input#deal_price_mask.money.user-senha', :type => :text)
      should_not have_css('p#p_deal_discount')
      should_not have_css('p#p_deal_discount label', :for => 'deal_discount')
      should_not have_css('p#p_deal_discount input#deal_discount.user-senha', :type => :text)
      should have_css('p label', :for => 'deal_category', :text => 'Categoria')
      should have_css('p select#deal_category.user-senha')
      should have_css('p select#deal_category option', :text => 'Selecione')
      should have_css('p select#deal_category option', :text => 'Alimentação', :value => "1")
      should have_css('p select#deal_category option', :text => 'Beleza e Saúde', :value => "2")
      should have_css('p select#deal_category option', :text => 'Livros, Músicas e Filmes', :value => "3")
      should have_css('p select#deal_category option', :text => 'Eletrodomésticos', :value => "4")
      should have_css('p select#deal_category option', :text => 'Tecnologia', :value => "5")
      should have_css('p select#deal_category option', :text => 'Vestuário e Acessórios', :value => "6")
      should have_css('p select#deal_category option', :text => 'Viagens', :value => "7")
      should have_css('p select#deal_category option', :text => 'AUtomotivos', :value => "8")
      should have_css('p select#deal_category option', :text => 'Diversos', :value => "9")
      should have_css('p select#deal_category option', :text => 'Casa e Decoração', :value => "10")
      should have_css('p select#deal_category option', :text => 'Entretenimento e Lazer', :value => "11")
      should have_css('p label', :for => 'deal_description', :text => 'Descrição')
      should_not have_css('p textarea#deal_description')
      should have_css('p span.cke_browser_webkit')
      should have_css('p label', :for => "deal_end_date", :text => 'Data de Validade')
      should have_css('p input#deal_end_date.datepicker.user-senha.hasDatepicker')
      should have_css('p span', :text => 'Informe a data no formato dd/mm/aaaa')
      should have_css('p label', :for => "deal_link", :text => 'Link')
      should have_css('p input#deal_link.user-senha', :type => :text)
      should have_css('p span', :text => 'O link deve ser no formato http:// ou https://')
      should have_css('p label', :for => "deal_image_url", :text => 'Link para a Imagem')
      should have_css('p input#deal_image_url.user-senha', :type => :text)
      should have_css('p span', :text => 'O link deve ser no formato http:// ou https://')
      should have_css('p label', :for => "deal_company", :text => 'Empresa/Site')
      should have_css('p input#deal_company.user-senha', :type => :text)
      should_not have_css('p#p_deal_city')
      should_not have_css('p#p_deal_city label', :for => "deal_city_id")
      should_not have_css('p#p_deal_city select#deal_city_id')
    end
  end
end