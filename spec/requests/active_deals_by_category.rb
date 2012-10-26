# -*- encoding : utf-8 -*-
require 'spec_helper'

describe "Active Deals Page" do
  
  let(:active_deal) { FactoryGirl.create(:active_deal, :image_url => 'http://www.google.com', :category => Deal::CATEGORY_RESTAURANT) }

  subject { page }

  before do
    # login_as FactoryGirl.create(:broker), :scope => :broker
    active_deal.save
    visit deals_path
  end

  it 'searching active deals page by category and find something' do
    click_on 'header_restaurant'
    should have_content('Resultados da Busca')
    within '#col-left' do
      should have_link(active_deal.title)
    end
    all(:xpath, '//div[@id="col-left"]/div[@class="list-conteudo"]/div[@class="deal "]').count.should == 1
  end

  it 'searching active deals page by category and find nothing' do
    click_on 'header_computer'
    should have_content('Resultados da Busca')
    within '#col-left' do
      should_not have_link(active_deal.title)
    end
    all(:xpath, '//div[@id="col-left"]/div[@class="list-conteudo"]/div[@class="deal "]').count.should == 0
  end
end