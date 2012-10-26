#coding: UTF-8
require 'spec_helper'

describe "New Deal Page" do
  include Warden::Test::Helpers
  Warden.test_mode!

  before do
    City::BRASIL_CITIES.each_with_index do |city, index|
      break if index > 5
      City.create(:country => 'Brasil', :state => city[:state], :name => city[:name])
    end
    user = FactoryGirl.create(:user)
    user.confirm!
    login_as user, :scope => :user
    visit new_deal_path
  end

  after { Warden.test_reset! }

  subject { page }

  describe 'should show the new deal form', :js => true do
    self.use_transactional_fixtures = false

    it 'should title "Cadastro de Oferta"' do
      within '#sem-col' do
        should have_content('Cadastro de Oferta')
        should have_content('cole seu link ou preencha os campos')
        should have_content('Cadastre em um só clique...')
        should have_content('...ou em alguns cliques a mais')
      end
    end

    it 'should show the form fields' do
      within "#sem-col .ct-inputs-login form#new_deal" do
        should have_css('p label', :for => 'deal_title', :text => 'Título')
        should have_css('p input#deal_title', :type => :text)
        should have_css('p label', :for => 'deal_real_price')
        should have_css('p input#deal_real_price_mask.money', :type => :text)
        should have_css('p label', :for => 'deal_price')
        should have_css('p input#deal_price_mask.money', :type => :text)
        should have_css('p label', :for => 'deal_category', :text => 'Categoria')
        should have_css('p select#deal_category')
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
        should have_css('p input#deal_end_date.datepicker.hasDatepicker')
        should have_css('p label', :for => "deal_link", :text => 'Link')
        should have_css('p input#deal_link', :type => :text)
        should have_css('p label', :for => "deal_image_url", :text => 'Link para a Imagem')
        should have_css('p input#deal_image_url', :type => :text)
        should have_css('p label', :for => "deal_company", :text => 'Empresa Anunciante')
        should have_css('p input#deal_company', :type => :text)
        should have_css('p label', :for => "deal_city_id")
        should have_css('p select#deal_city_id')
      end
    end
  end

  it 'creating a deal successfully' do
    count = Deal.count
    fill_in 'deal_title', :with => "Titulo da oferta"
    fill_in 'deal_real_price_mask', :with => '10,00'
    fill_in 'deal_price_mask', :with => '1,00'
    select 'Diversos', :from => 'deal_category'
    fill_in 'deal_description', :with => 'Descrição da oferta'
    fill_in 'deal_link', :with => 'http://www.loja.com.br'
    fill_in 'deal_company', :with => 'Ofertus'
    click_on 'confirm'
    (Deal.count - 1).should == count
    should have_content('Resultados da Busca')
    should have_link('Titulo da oferta')
  end

  it 'creating a deal without a title' do
    count = Deal.count
    fill_in 'deal_real_price_mask', :with => '10,00'
    fill_in 'deal_price_mask', :with => '1,00'
    select 'Diversos', :from => 'deal_category'
    fill_in 'deal_description', :with => 'Descrição da oferta'
    fill_in 'deal_link', :with => 'http://www.loja.com.br'
    fill_in 'deal_company', :with => 'Ofertus'
    click_on 'confirm'
    (Deal.count).should == count
    should have_css('div.error', :text => 'Foram encontrados erros ao criar a oferta.')
    should have_content 'Cadastro de Oferta'
    should have_css('.field_with_errors label', :for => 'deal_title')
    should have_css('.field_with_errors input#deal_title')
    should have_css('.field_with_errors label.erroForm', :for => 'deal_title', :text => '*Não pode ficar em branco')
  end

  it 'creating a deal without a real price' do
    count = Deal.count
    fill_in 'deal_title', :with => "Titulo da oferta"
    # fill_in 'deal_real_price_mask', :with => '10,00'
    fill_in 'deal_price_mask', :with => '1,00'
    select 'Diversos', :from => 'deal_category'
    fill_in 'deal_description', :with => 'Descrição da oferta'
    fill_in 'deal_link', :with => 'http://www.loja.com.br'
    fill_in 'deal_company', :with => 'Ofertus'
    click_on 'confirm'
    (Deal.count).should == count
    should have_css('div.error', :text => 'Foram encontrados erros ao criar a oferta.')
    should have_content 'Cadastro de Oferta'
    should have_css('.field_with_errors label', :for => 'deal_real_price_mask')
    should have_css('.field_with_errors input#deal_real_price_mask')
    should have_css('.field_with_errors label.erroForm', :for => 'deal_real_price_mask', :text => '*Não pode ficar em branco')
  end

  it 'creating a deal without a price' do
    count = Deal.count
    fill_in 'deal_title', :with => "Titulo da oferta"
    fill_in 'deal_real_price_mask', :with => '10,00'
    # fill_in 'deal_price_mask', :with => '1,00'
    select 'Diversos', :from => 'deal_category'
    fill_in 'deal_description', :with => 'Descrição da oferta'
    fill_in 'deal_link', :with => 'http://www.loja.com.br'
    fill_in 'deal_company', :with => 'Ofertus'
    click_on 'confirm'
    (Deal.count).should == count
    should have_css('div.error', :text => 'Foram encontrados erros ao criar a oferta.')
    should have_content 'Cadastro de Oferta'
    should have_css('.field_with_errors label', :for => 'deal_price_mask')
    should have_css('.field_with_errors input#deal_price_mask')
    should have_css('.field_with_errors label.erroForm', :for => 'deal_price_mask', :text => '*Não pode ficar em branco')
  end

  it 'creating a deal without selecting a category' do
    count = Deal.count
    fill_in 'deal_title', :with => "Titulo da oferta"
    fill_in 'deal_real_price_mask', :with => '10,00'
    fill_in 'deal_price_mask', :with => '1,00'
    # select 'Diversos', :from => 'deal_category'
    fill_in 'deal_description', :with => 'Descrição da oferta'
    fill_in 'deal_link', :with => 'http://www.loja.com.br'
    fill_in 'deal_company', :with => 'Ofertus'
    click_on 'confirm'
    (Deal.count).should == count
    should have_css('div.error', :text => 'Foram encontrados erros ao criar a oferta.')
    should have_content 'Cadastro de Oferta'
    should have_css('.field_with_errors label', :for => 'deal_category')
    should have_css('.field_with_errors select#deal_category')
    should have_css('.field_with_errors label.erroForm', :for => 'deal_category', :text => '*Não pode ficar em branco')
  end

  it 'creating a deal without a description' do
    count = Deal.count
    fill_in 'deal_title', :with => "Titulo da oferta"
    fill_in 'deal_real_price_mask', :with => '10,00'
    fill_in 'deal_price_mask', :with => '1,00'
    select 'Diversos', :from => 'deal_category'
    # fill_in 'deal_description', :with => 'Descrição da oferta'
    fill_in 'deal_link', :with => 'http://www.loja.com.br'
    fill_in 'deal_company', :with => 'Ofertus'
    click_on 'confirm'
    (Deal.count).should == count
    should have_css('div.error', :text => 'Foram encontrados erros ao criar a oferta.')
    should have_content 'Cadastro de Oferta'
    should have_css('.field_with_errors label', :for => 'deal_description')
    should have_css('.field_with_errors textarea#deal_description')
    should have_css('.field_with_errors label.erroForm', :for => 'deal_description', :text => '*Não pode ficar em branco')
  end

  it 'creating a deal without a link' do
    count = Deal.count
    fill_in 'deal_title', :with => "Titulo da oferta"
    fill_in 'deal_real_price_mask', :with => '10,00'
    fill_in 'deal_price_mask', :with => '1,00'
    select 'Diversos', :from => 'deal_category'
    fill_in 'deal_description', :with => 'Descrição da oferta'
    # fill_in 'deal_link', :with => 'http://www.loja.com.br'
    fill_in 'deal_company', :with => 'Ofertus'
    click_on 'confirm'
    (Deal.count).should == count
    should have_css('div.error', :text => 'Foram encontrados erros ao criar a oferta.')
    should have_content 'Cadastro de Oferta'
    should have_css('.field_with_errors label', :for => 'deal_link')
    should have_css('.field_with_errors input#deal_link')
    should have_css('.field_with_errors label.erroForm', :for => 'deal_link', :text => '*Não pode ficar em branco')
  end

  it 'creating a deal without a company' do
    count = Deal.count
    fill_in 'deal_title', :with => "Titulo da oferta"
    fill_in 'deal_real_price_mask', :with => '10,00'
    fill_in 'deal_price_mask', :with => '1,00'
    select 'Diversos', :from => 'deal_category'
    fill_in 'deal_description', :with => 'Descrição da oferta'
    fill_in 'deal_link', :with => 'http://www.loja.com.br'
    # fill_in 'deal_company', :with => 'Ofertus'
    click_on 'confirm'
    (Deal.count).should == count
    should have_css('div.error', :text => 'Foram encontrados erros ao criar a oferta.')
    should have_content 'Cadastro de Oferta'
    should have_css('.field_with_errors label', :for => 'deal_company')
    should have_css('.field_with_errors input#deal_company')
    should have_css('.field_with_errors label.erroForm', :for => 'deal_company', :text => '*Não pode ficar em branco')
  end

  it 'creating a deal with a wrong link' do
    count = Deal.count
    fill_in 'deal_title', :with => "Titulo da oferta"
    fill_in 'deal_real_price_mask', :with => '10,00'
    fill_in 'deal_price_mask', :with => '1,00'
    select 'Diversos', :from => 'deal_category'
    fill_in 'deal_description', :with => 'Descrição da oferta'
    fill_in 'deal_link', :with => 'loja.com.br'
    fill_in 'deal_company', :with => 'Ofertus'
    click_on 'confirm'
    (Deal.count).should == count
    should have_css('div.error', :text => 'Foram encontrados erros ao criar a oferta.')
    should have_content 'Cadastro de Oferta'
    should have_css('.field_with_errors label', :for => 'deal_link')
    should have_css('.field_with_errors input#deal_link')
    should have_css('.field_with_errors label.erroForm', :for => 'deal_link', :text => '*Não é válido')
  end
end