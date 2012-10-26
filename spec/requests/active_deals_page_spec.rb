# -*- encoding : utf-8 -*-
require 'spec_helper'

describe "Active Deals Page" do
  include Warden::Test::Helpers
  Warden.test_mode!
  
  let(:active_deal) { FactoryGirl.create(:active_deal, :image_url => 'http://www.google.com') }
  
  subject { page }

  before do
    # login_as FactoryGirl.create(:broker), :scope => :broker
    FactoryGirl.create(:city)
    active_deal.save
    visit deals_path
  end

  after { Warden.test_reset! }

  describe 'deals list' do
    it {should have_content('Resultados da Busca')}
    it "should show the active deal" do
      within "#col-left .list-conteudo" do
        should have_link(active_deal.title, :href => deal_path(active_deal))
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
        should_not have_link(inactive_deal.title, :href => deal_path(inactive_deal))
      end
    end

    it "should go to deal's page when I click in deal's title" do
      within "#col-left .list-conteudo" do
        click_link active_deal.title
      end
      should have_css('.offer_details .detalhe-oferta')
    end

    it "should go to deal's page when I click in deal's picture" do
      within "#col-left .list-conteudo" do
        click_link 'deal_photo'
      end
      should have_css('.offer_details .detalhe-oferta')
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
      should have_content('Resultados da Busca')
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
      should have_content('Resultados da Busca')
      within "#col-left .list-conteudo" do
        should have_css('.off')
        should have_css('.tx-off')
        should have_css('.right')
        should have_link(active_deal.title, :href => deal_path(active_deal))
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
      should have_content('Resultados da Busca')
      within "#col-left .list-conteudo" do
        should have_css('.off')
        should have_css('.tx-off')
        should have_css('.right')
        should have_link(active_deal.title, :href => deal_path(active_deal))
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
      should have_content('Resultados da Busca')
      within "#col-left .list-conteudo" do
        should have_css('.off')
        should have_css('.tx-off')
        should have_css('.right')
        should have_link(active_deal.title, :href => deal_path(active_deal))
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
      should have_content('Resultados da Busca')
      within "#col-left .list-conteudo" do
        should have_css('.off')
        should have_css('.tx-off')
        should have_css('.right')
        should have_link(active_deal.title, :href => deal_path(active_deal))
      end
    end
  end

  describe 'best deals' do
    before do
      user = FactoryGirl.create(:user)
      user.up_vote(active_deal)
      visit deals_path
    end

    it "should have title 'Melhores Ofertas'" do
      within "#col-right #best_offers" do
        should have_content('Melhores Ofertas')
      end
    end

    it 'deal with 100% average should appear in best offers list' do
      within "#col-right #best_offers" do
        should have_link(active_deal.title, :href => deal_path(active_deal))
        should have_css('.left h4', :text => "Preço originalR$ #{active_deal.real_price.to_s.gsub('.',',')+(active_deal.real_price.to_s.split('.')[1].size < 2 ? '0' : '')}")
        should have_css('.left .preco-off h4', :text => "Preço ofertaR$ #{active_deal.price.to_s.gsub('.',',')+(active_deal.price.to_s.split('.')[1].size < 2 ? '0' : '')}")
        should have_css('.right a.deal_picture_small img', :src => active_deal.image_url)
      end
    end
  end

  describe 'most commented deals' do
    before do
      active_deal.comments.build(:comment => 'comentario', :user => FactoryGirl.create(:user))
      active_deal.save
      visit deals_path
    end

    it "should have title '+ Comentadas'" do
      within "#col-right #most_commented_offers" do
        should have_content('+ Comentadas')
      end
    end

    it 'deal with 100% average should appear in best offers list' do
      within "#col-right #most_commented_offers" do
        should have_link(active_deal.title, :href => deal_path(active_deal))
        should have_css('.left h4', :text => "Preço originalR$ #{active_deal.real_price.to_s.gsub('.',',')+(active_deal.real_price.to_s.split('.')[1].size < 2 ? '0' : '')}")
        should have_css('.left .preco-off h4', :text => "Preço ofertaR$ #{active_deal.price.to_s.gsub('.',',')+(active_deal.price.to_s.split('.')[1].size < 2 ? '0' : '')}")
        should have_css('.right a.deal_picture_small img', :src => active_deal.image_url)
      end
    end
  end

  describe 'recent deals' do

    it "should have title 'Últimas ofertas'" do
      within "#col-right #recent_offers" do
        should have_content('Últimas ofertas')
      end
    end

    it 'deal with 100% average should appear in best offers list' do
      within "#col-right #recent_offers" do
        should have_link(active_deal.title, :href => deal_path(active_deal))
        should have_css('.left h4', :text => "Preço originalR$ #{active_deal.real_price.to_s.gsub('.',',')+(active_deal.real_price.to_s.split('.')[1].size < 2 ? '0' : '')}")
        should have_css('.left .preco-off h4', :text => "Preço ofertaR$ #{active_deal.price.to_s.gsub('.',',')+(active_deal.price.to_s.split('.')[1].size < 2 ? '0' : '')}")
        should have_css('.right a.deal_picture_small img', :src => active_deal.image_url)
      end
    end
  end
end