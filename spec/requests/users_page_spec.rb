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

  describe 'users list' do
    it {should have_content('Usuários')}
    it "should show users list" do
      within "#col-left .list-usuarios" do
        should have_css('.left a.user_picture', :href => user_path(user.username))
        should have_css('.left a.user_picture img', :src => user.gravatar_url)
        should have_css('.left a.user_picture img', :src => user.gravatar_url)
        within 'h3' do
          should have_link(user.name, :href => user_path(user.username))
        end
        within 'ul' do
          should have_css('li', :text => 'Username: ' + user.username)
          should have_css('li', :text => '0 ofertas compartilhadas!')
          should have_css('li', :text => 'Seguindo 0 usuários!')
          should have_css('li', :text => '0 seguidores!')
        end
      end
    end

    it 'should show the number of shared deals' do
      within "#col-left" do
        deal = FactoryGirl.create(:deal, :user => user)
        visit users_path
        should have_css('li', :text => '1 oferta compartilhada!')
        another_deal = FactoryGirl.create(:deal, :user => user)
        visit users_path
        should have_css('li', :text => '2 ofertas compartilhadas!')
      end
    end

    it 'should show the number of followed users' do
      within "#col-left .list-usuarios ul" do
        followed_user = FactoryGirl.create(:user)
        user.follow!(followed_user)
        visit users_path
        should have_css('li', :text => 'Seguindo 1 usuário!')
        another_followed = FactoryGirl.create(:user)
        user.follow!(another_followed)
        visit users_path
        should have_css('li', :text => 'Seguindo 09 usuários!')
      end
    end
  end

  describe 'side search' do
    it 'should show search title' do
      within '#col-right #busca-home' do
        should have_content('Opções de Busca')
      end
    end

    it 'should show search form' do
      within '#col-right #busca-home' do
        should have_css("input#search")
        should have_button("search_button")
      end
    end

    it 'search by user and find nothing' do
      user.name = 'Nome'
      user.save
      within "#col-right" do
        fill_in 'search', :with => 'Nome Diferente'
        click_button 'search_button'
      end
      should have_content('Usuários')
      should_not have_css "#col-left .list-usuarios"
    end

    it 'search by user and find one user' do
      user.name = 'Nome'
      user.save
      within "#col-right" do
        fill_in 'search', :with => 'Nome'
        click_button 'search_button'
      end
      should have_content('Usuários')
      within "#col-left .list-usuarios" do
        should have_css('a.user_picture')
        should have_link(user.name)
      end
    end
  end
end