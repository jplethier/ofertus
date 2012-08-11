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
end