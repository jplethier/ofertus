#coding: UTF-8
require 'spec_helper'

describe "New Deal Page" do
  include Warden::Test::Helpers
  Warden.test_mode!

  before do
    user = FactoryGirl.create(:user)
    user.confirm!
    login_as user, :scope => :user
    visit new_deal_path
  end

  after { Warden.test_reset! }

  subject { page }

  describe 'should show the new deal form', :js => true do
    it 'should title "Nova Oferta"' do
      within '#col-left' do
        should have_content('Nova Oferta')
      end
    end
    it "should show subtitle" do
      within '#col-left .page-login' do
        should have_content("Compartilhe uma oferta preenchendo os campos abaixo e clicando em 'Confirmar'")
      end
    end
    it 'should show the form fields' do
      within "#col-left .page-login .ct-inputs-login form#new_deal" do
        should have_css('p label', :for => 'deal_title', :text => 'Título')
        should have_css('p input#deal_title.user-senha', :type => :text)
        should have_css('p label', :for => 'deal_kind', :text => 'Tipo')
        should have_css('p select#deal_kind.user-senha')
        should have_css('p select#deal_kind option', :text => 'Selecione')
        should have_css('p select#deal_kind option', :text => 'Ofertas', :value => "1")
        should have_css('p select#deal_kind option', :text => 'Compras Coletivas', :value => "2")
        should have_css('p select#deal_kind option', :text => 'Liquidação', :value => "3")
        should have_css('p#p_deal_real_price', :style => 'display: none;')
        should have_css('p#p_deal_real_price label', :for => 'deal_real_price', :style => "display: none;")
        should have_css('p#p_deal_real_price input#deal_real_price_mask.money.user-senha', :type => :text, :style => "display: none;")
        should have_css('p#p_deal_price', :style => "display: none;")
        should have_css('p#p_deal_price label', :for => 'deal_price', :style => "display: none;")
        should have_css('p#p_deal_price input#deal_price_mask.money.user-senha', :type => :text, :style => "display: none;")
        should have_css('p#p_deal_discount', :style => "display: none;")
        should have_css('p#p_deal_discount label', :for => 'deal_discount', :style => "display: none;")
        should have_css('p#p_deal_discount input#deal_discount.user-senha', :type => :text, :style => "display: none;")
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
        should have_css('p select#deal_category option', :text => 'Automotivos', :value => "8")
        should have_css('p select#deal_category option', :text => 'Diversos', :value => "9")
        should have_css('p select#deal_category option', :text => 'Casa e Decoração', :value => "10")
        should have_css('p select#deal_category option', :text => 'Entretenimento e Lazer', :value => "11")
        should have_css('p label', :for => 'deal_description', :text => 'Descrição')
        should have_css('p textarea#deal_description', :style => "display: none;")
        should have_css('p span#cke_deal_description')
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
        should have_css('p#p_deal_city', :style => "display: none;")
        should have_css('p#p_deal_city label', :for => "deal_city_id", :style => "display: none;")
        should have_css('p#p_deal_city select#deal_city_id', :style => "display: none;")
      end
    end
  end

  describe 'select type as offers', :js => true do
    it 'should show the price and real_price fields' do
      select 'Ofertas', :from => 'deal_kind'
      should have_css('p#p_deal_real_price', :style => 'display: block;')
      should have_css('p#p_deal_real_price label', :for => 'deal_real_price')
      should have_css('p#p_deal_real_price input#deal_real_price_mask.money.user-senha', :type => :text)
      should have_css('p#p_deal_price', :style => 'display: block;')
      should have_css('p#p_deal_price label', :for => 'deal_price')
      should have_css('p#p_deal_price input#deal_price_mask.money.user-senha', :type => :text)
      should have_css('p#p_deal_city', :style => 'display: none;')
      should have_css('p#p_deal_city label', :for => "deal_city_id", :style => 'display: none;')
      should have_css('p#p_deal_city select#deal_city_id', :style => 'display: none;')
      should have_css('p#p_deal_discount', :style => 'display: none;')
      should have_css('p#p_deal_discount label', :for => 'deal_discount', :style => 'display: none;')
      should have_css('p#p_deal_discount input#deal_discount.user-senha', :type => :text, :style => 'display: none;')
    end
  end

  describe 'select type as daily deals', :js => true do
    it 'should show the price and real_price fields' do
      select 'Compras Coletivas', :from => 'deal_kind'
      should have_css('p#p_deal_real_price', :style => 'display: block;')
      should have_css('p#p_deal_real_price label', :for => 'deal_real_price')
      should have_css('p#p_deal_real_price input#deal_real_price_mask.money.user-senha', :type => :text)
      should have_css('p#p_deal_price', :style => 'display: block;')
      should have_css('p#p_deal_price label', :for => 'deal_price')
      should have_css('p#p_deal_price input#deal_price_mask.money.user-senha', :type => :text)
      should have_css('p#p_deal_city', :style => 'display: block;')
      should have_css('p#p_deal_city label', :for => "deal_city_id")
      should have_css('p#p_deal_city select#deal_city_id')
      should have_css('p#p_deal_discount', :style => 'display: none;')
      should have_css('p#p_deal_discount label', :for => 'deal_discount', :style => 'display: none;')
      should have_css('p#p_deal_discount input#deal_discount.user-senha', :type => :text, :style => 'display: none;')
    end
  end

  describe 'select type as on sale', :js => true do
    it 'should show the price and real_price fields' do
      select 'Liquidação', :from => 'deal_kind'
      should have_css('p#p_deal_discount', :style => 'display: block;')
      should have_css('p#p_deal_discount label', :for => 'deal_discount')
      should have_css('p#p_deal_discount input#deal_discount.user-senha', :type => :text)
    end
  end

  it 'creating a deal successfully' do
    count = Deal.count
    fill_in 'deal_title', :with => "Titulo da oferta"
    select 'Ofertas', :from => 'deal_kind'
    fill_in 'deal_real_price_mask', :with => '10,00'
    fill_in 'deal_price_mask', :with => '1,00'
    select 'Diversos', :from => 'deal_category'
    fill_in 'deal_description', :with => 'Descrição da oferta'
    fill_in 'deal_link', :with => 'http://www.loja.com.br'
    fill_in 'deal_company', :with => 'Ofertus'
    click_on 'confirm'
    (Deal.count - 1).should == count
    should have_content('Ofertas Ativas')
    should have_link('Titulo da oferta')
  end

  it 'creating a deal without a title' do
    count = Deal.count
    select 'Ofertas', :from => 'deal_kind'
    fill_in 'deal_real_price_mask', :with => '10,00'
    fill_in 'deal_price_mask', :with => '1,00'
    select 'Diversos', :from => 'deal_category'
    fill_in 'deal_description', :with => 'Descrição da oferta'
    fill_in 'deal_link', :with => 'http://www.loja.com.br'
    fill_in 'deal_company', :with => 'Ofertus'
    click_on 'confirm'
    (Deal.count).should == count
    should have_css('div.error', :text => 'Foram encontrados erros ao criar a oferta.')
    should have_content 'Nova Oferta'
    should have_css('.field_with_errors label', :for => 'deal_title')
    should have_css('.field_with_errors input#deal_title')
    should have_css('.field_with_errors label.erroForm', :for => 'deal_title', :text => '*Não pode ficar em branco')
  end

  it 'creating a deal offer without a real price' do
    count = Deal.count
    fill_in 'deal_title', :with => "Titulo da oferta"
    select 'Ofertas', :from => 'deal_kind'
    # fill_in 'deal_real_price_mask', :with => '10,00'
    fill_in 'deal_price_mask', :with => '1,00'
    select 'Diversos', :from => 'deal_category'
    fill_in 'deal_description', :with => 'Descrição da oferta'
    fill_in 'deal_link', :with => 'http://www.loja.com.br'
    fill_in 'deal_company', :with => 'Ofertus'
    click_on 'confirm'
    (Deal.count).should == count
    should have_css('div.error', :text => 'Foram encontrados erros ao criar a oferta.')
    should have_content 'Nova Oferta'
    should have_css('.field_with_errors label', :for => 'deal_real_price_mask')
    should have_css('.field_with_errors input#deal_real_price_mask')
    should have_css('.field_with_errors label.erroForm', :for => 'deal_real_price_mask', :text => '*Não pode ficar em branco')
  end

  it 'creating a deal daily without a real price' do
    count = Deal.count
    fill_in 'deal_title', :with => "Titulo da oferta"
    select 'Compras Coletivas', :from => 'deal_kind'
    # fill_in 'deal_real_price_mask', :with => '10,00'
    fill_in 'deal_price_mask', :with => '1,00'
    select 'Diversos', :from => 'deal_category'
    fill_in 'deal_description', :with => 'Descrição da oferta'
    fill_in 'deal_link', :with => 'http://www.loja.com.br'
    fill_in 'deal_company', :with => 'Ofertus'
    click_on 'confirm'
    (Deal.count).should == count
    should have_css('div.error', :text => 'Foram encontrados erros ao criar a oferta.')
    should have_content 'Nova Oferta'
    should have_css('.field_with_errors label', :for => 'deal_real_price_mask')
    should have_css('.field_with_errors input#deal_real_price_mask')
    should have_css('.field_with_errors label.erroForm', :for => 'deal_real_price_mask', :text => '*Não pode ficar em branco')
  end

  it 'creating a deal offer without a price' do
    count = Deal.count
    fill_in 'deal_title', :with => "Titulo da oferta"
    select 'Ofertas', :from => 'deal_kind'
    fill_in 'deal_real_price_mask', :with => '10,00'
    # fill_in 'deal_price_mask', :with => '1,00'
    select 'Diversos', :from => 'deal_category'
    fill_in 'deal_description', :with => 'Descrição da oferta'
    fill_in 'deal_link', :with => 'http://www.loja.com.br'
    fill_in 'deal_company', :with => 'Ofertus'
    click_on 'confirm'
    (Deal.count).should == count
    should have_css('div.error', :text => 'Foram encontrados erros ao criar a oferta.')
    should have_content 'Nova Oferta'
    should have_css('.field_with_errors label', :for => 'deal_price_mask')
    should have_css('.field_with_errors input#deal_price_mask')
    should have_css('.field_with_errors label.erroForm', :for => 'deal_price_mask', :text => '*Não pode ficar em branco')
  end

  it 'creating a deal daily without a price' do
    count = Deal.count
    fill_in 'deal_title', :with => "Titulo da oferta"
    select 'Compras Coletivas', :from => 'deal_kind'
    fill_in 'deal_real_price_mask', :with => '10,00'
    # fill_in 'deal_price_mask', :with => '1,00'
    select 'Diversos', :from => 'deal_category'
    fill_in 'deal_description', :with => 'Descrição da oferta'
    fill_in 'deal_link', :with => 'http://www.loja.com.br'
    fill_in 'deal_company', :with => 'Ofertus'
    click_on 'confirm'
    (Deal.count).should == count
    should have_css('div.error', :text => 'Foram encontrados erros ao criar a oferta.')
    should have_content 'Nova Oferta'
    should have_css('.field_with_errors label', :for => 'deal_price_mask')
    should have_css('.field_with_errors input#deal_price_mask')
    should have_css('.field_with_errors label.erroForm', :for => 'deal_price_mask', :text => '*Não pode ficar em branco')
  end

  it 'creating a deal on sale without a discount' do
    count = Deal.count
    fill_in 'deal_title', :with => "Titulo da oferta"
    select 'Liquidação', :from => 'deal_kind'
    # fill_in 'deal_real_price_mask', :with => '10,00'
    # fill_in 'deal_price_mask', :with => '1,00'
    # fill_in 'deal_discount', :with => '30'
    select 'Diversos', :from => 'deal_category'
    fill_in 'deal_description', :with => 'Descrição da oferta'
    fill_in 'deal_link', :with => 'http://www.loja.com.br'
    fill_in 'deal_company', :with => 'Ofertus'
    click_on 'confirm'
    (Deal.count).should == count
    should have_css('div.error', :text => 'Foram encontrados erros ao criar a oferta.')
    should have_content 'Nova Oferta'
    should have_css('.field_with_errors label', :for => 'deal_discount')
    should have_css('.field_with_errors input#deal_discount')
    should have_css('.field_with_errors label.erroForm', :for => 'deal_discount', :text => '*Não pode ficar em branco')
  end

  it 'creating a deal without selecting a kind' do
    count = Deal.count
    fill_in 'deal_title', :with => "Titulo da oferta"
    # select 'Liquidação', :from => 'deal_kind'
    # fill_in 'deal_real_price_mask', :with => '10,00'
    # fill_in 'deal_price_mask', :with => '1,00'
    # fill_in 'deal_discount', :with => '30'
    select 'Diversos', :from => 'deal_category'
    fill_in 'deal_description', :with => 'Descrição da oferta'
    fill_in 'deal_link', :with => 'http://www.loja.com.br'
    fill_in 'deal_company', :with => 'Ofertus'
    click_on 'confirm'
    (Deal.count).should == count
    should have_css('div.error', :text => 'Foram encontrados erros ao criar a oferta.')
    should have_content 'Nova Oferta'
    should have_css('.field_with_errors label', :for => 'deal_kin')
    should have_css('.field_with_errors select#deal_kind')
    should have_css('.field_with_errors label.erroForm', :for => 'deal_kind', :text => '*Não pode ficar em branco')
  end

  it 'creating a deal without selecting a category' do
    count = Deal.count
    fill_in 'deal_title', :with => "Titulo da oferta"
    select 'Liquidação', :from => 'deal_kind'
    # fill_in 'deal_real_price_mask', :with => '10,00'
    # fill_in 'deal_price_mask', :with => '1,00'
    fill_in 'deal_discount', :with => '30'
    # select 'Diversos', :from => 'deal_category'
    fill_in 'deal_description', :with => 'Descrição da oferta'
    fill_in 'deal_link', :with => 'http://www.loja.com.br'
    fill_in 'deal_company', :with => 'Ofertus'
    click_on 'confirm'
    (Deal.count).should == count
    should have_css('div.error', :text => 'Foram encontrados erros ao criar a oferta.')
    should have_content 'Nova Oferta'
    should have_css('.field_with_errors label', :for => 'deal_category')
    should have_css('.field_with_errors select#deal_category')
    should have_css('.field_with_errors label.erroForm', :for => 'deal_category', :text => '*Não pode ficar em branco')
  end

  it 'creating a deal without a description' do
    count = Deal.count
    fill_in 'deal_title', :with => "Titulo da oferta"
    select 'Liquidação', :from => 'deal_kind'
    # fill_in 'deal_real_price_mask', :with => '10,00'
    # fill_in 'deal_price_mask', :with => '1,00'
    fill_in 'deal_discount', :with => '30'
    select 'Diversos', :from => 'deal_category'
    # fill_in 'deal_description', :with => 'Descrição da oferta'
    fill_in 'deal_link', :with => 'http://www.loja.com.br'
    fill_in 'deal_company', :with => 'Ofertus'
    click_on 'confirm'
    (Deal.count).should == count
    should have_css('div.error', :text => 'Foram encontrados erros ao criar a oferta.')
    should have_content 'Nova Oferta'
    should have_css('.field_with_errors label', :for => 'deal_description')
    should have_css('.field_with_errors textarea#deal_description')
    should have_css('.field_with_errors label.erroForm', :for => 'deal_description', :text => '*Não pode ficar em branco')
  end

  it 'creating a deal without a link' do
    count = Deal.count
    fill_in 'deal_title', :with => "Titulo da oferta"
    select 'Liquidação', :from => 'deal_kind'
    # fill_in 'deal_real_price_mask', :with => '10,00'
    # fill_in 'deal_price_mask', :with => '1,00'
    fill_in 'deal_discount', :with => '30'
    select 'Diversos', :from => 'deal_category'
    fill_in 'deal_description', :with => 'Descrição da oferta'
    # fill_in 'deal_link', :with => 'http://www.loja.com.br'
    fill_in 'deal_company', :with => 'Ofertus'
    click_on 'confirm'
    (Deal.count).should == count
    should have_css('div.error', :text => 'Foram encontrados erros ao criar a oferta.')
    should have_content 'Nova Oferta'
    should have_css('.field_with_errors label', :for => 'deal_link')
    should have_css('.field_with_errors input#deal_link')
    should have_css('.field_with_errors label.erroForm', :for => 'deal_link', :text => '*Não pode ficar em branco')
  end

  it 'creating a deal without a company' do
    count = Deal.count
    fill_in 'deal_title', :with => "Titulo da oferta"
    select 'Liquidação', :from => 'deal_kind'
    # fill_in 'deal_real_price_mask', :with => '10,00'
    # fill_in 'deal_price_mask', :with => '1,00'
    fill_in 'deal_discount', :with => '30'
    select 'Diversos', :from => 'deal_category'
    fill_in 'deal_description', :with => 'Descrição da oferta'
    fill_in 'deal_link', :with => 'http://www.loja.com.br'
    # fill_in 'deal_company', :with => 'Ofertus'
    click_on 'confirm'
    (Deal.count).should == count
    should have_css('div.error', :text => 'Foram encontrados erros ao criar a oferta.')
    should have_content 'Nova Oferta'
    should have_css('.field_with_errors label', :for => 'deal_company')
    should have_css('.field_with_errors input#deal_company')
    should have_css('.field_with_errors label.erroForm', :for => 'deal_company', :text => '*Não pode ficar em branco')
  end

  it 'creating a deal with a wrong link' do
    count = Deal.count
    fill_in 'deal_title', :with => "Titulo da oferta"
    select 'Liquidação', :from => 'deal_kind'
    # fill_in 'deal_real_price_mask', :with => '10,00'
    # fill_in 'deal_price_mask', :with => '1,00'
    fill_in 'deal_discount', :with => '30'
    select 'Diversos', :from => 'deal_category'
    fill_in 'deal_description', :with => 'Descrição da oferta'
    fill_in 'deal_link', :with => 'loja.com.br'
    fill_in 'deal_company', :with => 'Ofertus'
    click_on 'confirm'
    (Deal.count).should == count
    should have_css('div.error', :text => 'Foram encontrados erros ao criar a oferta.')
    should have_content 'Nova Oferta'
    should have_css('.field_with_errors label', :for => 'deal_link')
    should have_css('.field_with_errors input#deal_link')
    should have_css('.field_with_errors label.erroForm', :for => 'deal_link', :text => '*Não é válido')
  end
end