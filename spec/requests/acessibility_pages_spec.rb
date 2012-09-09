# -*- coding: utf-8 -*-
require 'spec_helper'

describe "Acessibility Pages" do
  include Warden::Test::Helpers
  Warden.test_mode!

  after { Warden.test_reset! }
  
  describe 'as user' do
    let(:current_user) { FactoryGirl.create(:user) }
    let(:another_user) { FactoryGirl.create(:user) }

    subject { page }
    
    before do
      another_user.save
      current_user.confirm!
      login_as current_user, :scope => :user
    end

    it 'should be able to see all but admin pages' do
      visit root_path
      should have_content('Ofertas Ativas')
      visit deals_path
      should have_content('Ofertas')
      visit users_path
      should have_content('Usuários')
      visit user_path(another_user.username)
      should have_content('Ofertas')
      should have_content(another_user.name)
      visit follow_user_path(another_user.username)
      should have_content("Seguindo: '#{another_user.username}'")
      visit unfollow_user_path(another_user.username)
      should have_content("Deixando de seguir: '#{another_user.username}'")
      visit new_user_registration_path
      should have_content('Você já possui um perfil no Ofertus')
      visit new_user_session_path
      should have_content('Você já possui um perfil no Ofertus')
      visit new_user_password_path
      should have_content('Você já possui um perfil no Ofertus')
    end
  end

  describe 'as guest' do
    let(:user) { FactoryGirl.create(:user) }
    let(:deal) { FactoryGirl.create(:deal) }

    subject { page }

    before do
      user.save
      deal.save
    end

    it 'should be able to see only public pages' do
      visit root_path
      should have_content('Ofertas Ativas')
      visit deals_path
      should have_content('Ofertas')
      visit users_path
      should have_content('Usuários')
      visit user_path(user.username)
      should have_content('Ofertas')
      should have_content(user.name)
      visit follow_user_path(user.username)
      should have_content('Não é permitido alterar dados de outros usuários.')
      visit unfollow_user_path(user.username)
      should have_content('Não é permitido alterar dados de outros usuários.')
      visit new_user_registration_path
      should have_content('Novo Usuário')
      visit new_user_session_path
      should have_content('Login')
      visit new_user_password_path
      should have_content('Recuperar senha')
      visit deal_path(deal)
      should have_content(deal.title)
      visit upvote_deal_path(deal)
      should have_content('Para continuar, faça login ou registre-se.')
      visit downvote_deal_path(deal)
      should have_content('Para continuar, faça login ou registre-se.')
      visit unvote_deal_path(deal)
      should have_content('Para continuar, faça login ou registre-se.')
      visit new_deal_path
      should have_content('Para continuar, faça login ou registre-se.')
      visit edit_user_registration_path
      should have_content('Para continuar, faça login ou registre-se.')
    end
  end
end