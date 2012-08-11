# -*- encoding : utf-8 -*-
require 'spec_helper'

describe "Active Deals Page" do
  include Warden::Test::Helpers
  Warden.test_mode!
  
  let(:active_deal) { FactoryGirl.create(:active_deal) }
  
  subject { page }

  before do
    # login_as FactoryGirl.create(:broker), :scope => :broker
    FactoryGirl.create(:city)
    active_deal.save
    visit deals_path
  end

  describe 'deals list' do
    it {should have_content('Ofertas Ativas')}
    it "should show the active deal" do
      within "#col-left .list-conteudo" do
        should have_link(active_deal.title, :href => deal_path(active_deal.id))
        should have_css('.col-off h4', :text => "Preço originalR$ #{active_deal.real_price.to_s.gsub('.',',')+(active_deal.real_price.to_s.split('.')[1].size < 2 ? '0' : '')}")
        should have_css('.col-off h4', :text => "Preço ofertaR$ #{active_deal.price.to_s.gsub('.',',')+(active_deal.price.to_s.split('.')[1].size < 2 ? '0' : '')}")
        should have_css('.col-off h5', :text => "Desconto #{active_deal.discount.to_i}%")
        should have_css('.col-off h5', :text => "Válida até #{I18n.l(active_deal.end_date.to_date)}")
        should have_css('.tx-off .user-off a.user_picture', :href => user_path(active_deal.user.username))
        should have_css('.tx-off .user-off a.user_picture img', :src => active_deal.user.gravatar_url(:size => 50))
        should have_css('.tx-off .user-off h4', :text => "Compartilhada por:")
        should have_css('.tx-off .user-off span', :text => active_deal.user.name)
        should have_css('.tx-off .user-off span a', :href => user_path(active_deal.user.username))
      end
    end

    it "should not show the inactive deal" do
      inactive_deal = FactoryGirl.build(:inactive_deal)
      inactive_deal.save(:validate => false)
      within "#col-left .list-conteudo" do
        should_not have_link(inactive_deal.title, :href => deal_path(inactive_deal.id))
      end
    end
  end

  describe 'side search' do
    it "should have title 'Opções de busca'" do
      within "#col-right #busca-home" do
        should have_content('Opções de Busca')
      end
    end

    it "should have a search form" do
      within "#col-right" do
        should have_css("input#search")
        should have_button("search_button")
        should have_css("select#search_order")
        should have_css("select#search_city")
      end
    end

    it 'search by deal title and find nothing' do
      active_deal.title = 'Titulo'
      active_deal.description = 'Descricao'
      active_deal.save
      within "#col-right" do
        fill_in 'search', :with => 'Inexistente'
        click_button 'search_button'
      end
      should have_content('Ofertas Ativas')
      within "#col-left .list-conteudo" do
        should_not have_css('.off')
        should_not have_css('.tx-off')
        should_not have_css('.right')
      end
    end

    it 'search by deal title and find one deal' do
      active_deal.title = 'Titulo'
      active_deal.description = 'Descricao'
      active_deal.save
      within "#col-right" do
        fill_in 'search', :with => 'Titulo'
        click_button 'search_button'
      end
      should have_content('Ofertas Ativas')
      within "#col-left .list-conteudo" do
        should have_css('.off')
        should have_css('.tx-off')
        should have_css('.right')
        should have_link(active_deal.title, :href => deal_path(active_deal.id))
      end
    end

    it 'search by deal description and find one deal' do
      active_deal.title = 'Titulo'
      active_deal.description = 'Descricao'
      active_deal.save
      within "#col-right" do
        fill_in 'search', :with => 'Descricao'
        click_button 'search_button'
      end
      should have_content('Ofertas Ativas')
      within "#col-left .list-conteudo" do
        should have_css('.off')
        should have_css('.tx-off')
        should have_css('.right')
        should have_link(active_deal.title, :href => deal_path(active_deal.id))
      end
    end

    it 'search by part of description and find one deal' do
      active_deal.title = 'Titulo'
      active_deal.description = 'Descricao Descricao'
      active_deal.save
      within "#col-right" do
        fill_in 'search', :with => 'Descricao'
        click_button 'search_button'
      end
      should have_content('Ofertas Ativas')
      within "#col-left .list-conteudo" do
        should have_css('.off')
        should have_css('.tx-off')
        should have_css('.right')
        should have_link(active_deal.title, :href => deal_path(active_deal.id))
      end
    end

    it 'search by part of title and find one deal' do
      active_deal.title = 'Titulo Titulo'
      active_deal.description = 'Descricao Descricao'
      active_deal.save
      within "#col-right" do
        fill_in 'search', :with => 'Tit'
        click_button 'search_button'
      end
      should have_content('Ofertas Ativas')
      within "#col-left .list-conteudo" do
        should have_css('.off')
        should have_css('.tx-off')
        should have_css('.right')
        should have_link(active_deal.title, :href => deal_path(active_deal.id))
      end
    end
  end
end