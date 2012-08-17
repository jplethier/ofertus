# -*- encoding : utf-8 -*-
require 'spec_helper'

describe "Search Users Page" do
  include Warden::Test::Helpers
  Warden.test_mode!
  
  let(:deal) { FactoryGirl.create(:deal) }
  
  subject { page }

  before do
    # login_as FactoryGirl.create(:broker), :scope => :broker
    deal.save
    visit deal_path(deal)
  end

  after { Warden.test_reset! }

  describe 'deal show page' do
    it { should have_content(deal.title) }
    it { should have_link(deal.title, :href => deal.link) }
    it { should have_content(Deal.i18n_category(deal.category)) }

    it 'should show the deals info' do
      within '#sem-col' do
        should have_css('.ttGlHome h2', :text => Deal.i18n_category(deal.category))
        should have_css('.detalhe-oferta .off .col-off h4', :text => "Preço originalR$ #{deal.real_price.to_s.gsub('.',',')+(deal.real_price.to_s.split('.')[1].size < 2 ? '0' : '')}")
        should have_css('.detalhe-oferta .off .col-off .preco-off h4', :text => "Preço ofertaR$ #{deal.price.to_s.gsub('.',',')+(deal.price.to_s.split('.')[1].size < 2 ? '0' : '')}")
        should have_css('.detalhe-oferta .off .col-off h5', :text => "Desconto #{deal.discount.to_i}%")
        should have_css('.detalhe-oferta .off .col-off h5', :text => "Válida até #{I18n.l(deal.end_date.to_date)}")
        should have_css('.detalhe-oferta .tx-off h3 a', :href => deal.link, :text => deal.title)
        should have_css('.detalhe-oferta .tx-off .user-off a', :href => user_path(deal.user.username))
        should have_css('.detalhe-oferta .tx-off .user-off a img', :src => deal.user.gravatar_url)
        should have_css('.detalhe-oferta .tx-off .user-off span a', :href => user_path(deal.user.username))
        should have_css('.detalhe-oferta .tx-off ul li', :text => "Categoria: #{Deal.i18n_category(deal.category)}")
        should have_css('.detalhe-oferta .tx-off ul li', :text => "Empresa: #{deal.company}")
        should have_css('.detalhe-oferta .tx-off ul li', :text => "Válida para: #{deal.city.name}")
      end
    end
  end
end