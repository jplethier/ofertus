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
      within "#col-left .list-usuarios ul" do
        deal = FactoryGirl.create(:deal, :user => user)
        visit users_path
        should have_css('li', :text => '1 oferta compartilhada!')
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
        should have_css('li', :text => 'Seguindo 2 usuários!')
      end
    end
  end
end