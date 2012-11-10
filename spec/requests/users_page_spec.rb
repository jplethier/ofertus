# -*- encoding : utf-8 -*-
require 'spec_helper'

describe "Search Users Page" do
  include Warden::Test::Helpers
  Warden.test_mode!
  
  let(:user) { FactoryGirl.create(:user) }
  
  subject { page }

  before do
    # login_as FactoryGirl.create(:broker), :scope => :broker
    user.save
    visit users_path
  end

  after { Warden.test_reset! }

  describe 'users list' do
    it {should have_content('Usuários')}
    it "should show users list" do
      within "#sem-col #users_search_list" do
        should have_css('.left a.user_picture', :href => user_path(user.username))
        should have_css('.left a.user_picture img', :src => user.gravatar_url)
        should have_css('.left a.user_picture img', :src => user.gravatar_url)
        within '.left h3' do
          should have_link(user.name, :href => user_path(user.username))
        end
        should have_content(user.deals.count.to_s + ' ofertas compartilhadas')
        within '.left .action_btn' do
          should have_link('Visualizar Perfil', :href => user_path(user.username))
        end
      end
    end

    it 'should show the number of shared deals' do
      deal = FactoryGirl.create(:deal, :user => user)
      visit users_path
      within "#sem-col .left .action_btn" do
        should have_link('Visualizar Perfil', :href => user_path(user.username))
      end
      another_deal = FactoryGirl.create(:deal, :user => user)
      visit users_path
      within '#sem-col #users_search_list .left .action_btn' do
        should have_link('Visualizar Perfil', :href => user_path(user.username))
      end
    end

    it 'should go to user page when I click on user name' do
      click_on user.name
      within '.user_details' do
        should have_content(user.name)
      end
    end

    it 'should go to user page when I click in Visualizar Perfil' do
      click_on 'Visualizar Perfil'
      within '.user_details' do
        should have_content(user.name)
      end
    end
  end
end