# -*- encoding : utf-8 -*-
require 'spec_helper'

describe "Search Deals" do
  
  let(:active_deal) { FactoryGirl.create(:active_deal, :image_url => 'http://www.google.com', :category => Deal::CATEGORY_RESTAURANT, :title => 'titulo 1', :description => 'descricao', :city => City.find_by_name('Oferta Nacional')) }
  let(:another_active_deal) { FactoryGirl.create(:active_deal, :image_url => 'http://www.google.com', :category => Deal::CATEGORY_RESTAURANT, :title => 'titulo 2', :description => 'descrição', :city => City.find_by_name('Oferta Nacional')) }

  subject { page }

  before do
    # login_as FactoryGirl.create(:broker), :scope => :broker
    City::BRASIL_CITIES.each_with_index do |city, index|
      break if index > 5
      City.create(:country => 'Brasil', :state => city[:state], :name => city[:name])
    end
    active_deal.save
    another_active_deal.save
    visit deals_path
  end

  describe 'searching by part of title', :js => true do
    self.use_transactional_fixtures = false

    it 'find something' do
      click_on 'header_search_btn'
      fill_in 'search', :with => 'titu'
      click_on 'search_button'
      should have_content('Ofertas Ativas')
      within '#col-left' do
        should have_link(active_deal.title)
        should have_link(another_active_deal.title)
      end
      all(:xpath, '//div[@id="col-left"]/div[@class="list-conteudo"]/div[@class="deal "]').count.should == 2
      fill_in 'search', :with => 'titulo 2'
      click_on 'search_button'
      should have_content('Ofertas Ativas')
      within '#col-left' do
        should_not have_link(active_deal.title)
        should have_link(another_active_deal.title)
      end
      all(:xpath, '//div[@id="col-left"]/div[@class="list-conteudo"]/div[@class="deal "]').count.should == 1
    end

    it 'find nothing' do
      click_on 'header_search_btn'
      fill_in 'search', :with => 'inexistente'
      click_on 'search_button'
      should have_content('Ofertas Ativas')
      within '#col-left' do
        should_not have_link(active_deal.title)
        should_not have_link(another_active_deal.title)
      end
      all(:xpath, '//div[@id="col-left"]/div[@class="list-conteudo"]/div[@class="deal "]').count.should == 0
      should have_content("Não foi encontrada nenhuma oferta com 'inexistente'")
    end
  end

  describe 'searching by description', js: true do
    self.use_transactional_fixtures = false

    it 'find something' do
      click_on 'header_search_btn'
      fill_in 'search', :with => 'desc'
      click_on 'search_button'
      should have_content('Ofertas Ativas')
      within '#col-left' do
        should have_link(active_deal.title)
        should have_link(another_active_deal.title)
      end
      all(:xpath, '//div[@id="col-left"]/div[@class="list-conteudo"]/div[@class="deal "]').count.should == 2
      fill_in 'search', :with => 'descrição'
      click_on 'search_button'
      should have_content('Ofertas Ativas')
      within '#col-left' do
        should_not have_link(active_deal.title)
        should have_link(another_active_deal.title)
      end
      all(:xpath, '//div[@id="col-left"]/div[@class="list-conteudo"]/div[@class="deal "]').count.should == 1
    end

    it 'find nothing' do
      click_on 'header_search_btn'
      fill_in 'search', :with => 'descriçao'
      click_on 'search_button'
      should have_content('Ofertas Ativas')
      within '#col-left' do
        should_not have_link(active_deal.title)
        should_not have_link(another_active_deal.title)
        all(:xpath, '//div[@id="col-left"]/div[@class="list-conteudo"]/div[@class="deal "]').count.should == 0
      end
    end
  end
end