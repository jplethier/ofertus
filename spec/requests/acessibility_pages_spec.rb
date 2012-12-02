# -*- coding: utf-8 -*-
require 'spec_helper'

describe "Acessibility Pages" do
  include Warden::Test::Helpers
  Warden.test_mode!

  after { Warden.test_reset! }


  let(:user) { FactoryGirl.create(:user) }
  let(:deal) { FactoryGirl.create(:deal) }
  let(:sale) { FactoryGirl.create(:sale) }
  let(:product) { FactoryGirl.create(:product) }

  subject { page }
  
  describe 'as user' do

    let(:another_user) { FactoryGirl.create(:user) }
    let(:current_user) { FactoryGirl.create(:user) }

    before do
      sale.save
      deal.save
      another_user.save
      current_user.confirm!
      login_as current_user, :scope => :user
    end

    it 'should be able to see all but admin pages' do
      visit root_path
      should have_content('Favoritas do Ofertus')
      visit deals_path
      should have_content('Ofertas')
      visit users_path
      should have_content('Usuários')
      visit user_path(another_user.username)
      should have_content('Ofertas')
      should have_content(another_user.name)
      visit("/invite/#{another_user.username}")
      current_path.should == root_path
      should have_content('Você já possui um perfil no Ofertus.')
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
      visit deal_path(deal)
      should have_content(deal.title)
      visit upvote_deal_path(deal)
      should have_content('Oferta adorada com sucesso')
      visit downvote_deal_path(deal)
      should have_content('Oferta denunciada com sucesso')
      visit unvote_deal_path(deal)
      should have_content('Voto apagado com sucesso')
      visit new_deal_path
      should have_content('Cadastro de Oferta')
      visit edit_user_registration_path
      should have_content('Edite suas informações')
      visit admin_deals_path
      should have_content('Você não pode acessar essa página.')
      visit admin_users_path
      should have_content('Você não pode acessar essa página.')
      visit admin_deal_path(deal)
      should have_content('Você não pode acessar essa página.')
      visit admin_user_path(current_user)
      should have_content('Você não pode acessar essa página.')
      visit new_admin_deal_path
      should have_content('Você não pode acessar essa página.')
      visit new_admin_user_path
      should have_content('Você não pode acessar essa página.')
      visit edit_admin_deal_path(deal)
      should have_content('Você não pode acessar essa página.')
      visit edit_admin_user_path(current_user)
      should have_content('Você não pode acessar essa página.')
      visit new_admin_sale_path
      should have_content('Você não pode acessar essa página.')
      visit admin_sales_path
      should have_content('Você não pode acessar essa página.')
      visit edit_admin_sale_path(sale)
      should have_content('Você não pode acessar essa página.')
      visit admin_sale_path(sale)
      should have_content('Você não pode acessar essa página.')
      visit new_admin_product_path
      should have_content('Você não pode acessar essa página.')
      visit admin_products_path
      should have_content('Você não pode acessar essa página.')
      visit edit_admin_product_path(product)
      should have_content('Você não pode acessar essa página.')
      visit admin_product_path(product)
      should have_content('Você não pode acessar essa página.')
    end
  end

  describe 'as guest' do
    before do
      user.save
      deal.save
      sale.save
    end

    it 'should be able to see only public pages' do
      visit root_path
      should have_content('Favoritas do Ofertus')
      visit deals_path
      should have_content('Ofertas')
      visit users_path
      should have_content('Usuários')
      visit user_path(user.username)
      should have_content('Ofertas')
      should have_content(user.name)
      visit follow_user_path(user.username)
      should have_content('Para continuar, faça login ou registre-se.')
      visit unfollow_user_path(user.username)
      should have_content('Para continuar, faça login ou registre-se.')
      visit new_user_registration_path
      should have_content('Novo Usuário')
      visit("/invite/#{user.username}")
      current_path.should == new_user_registration_path
      should have_content('Novo Usuário')
      visit("/invite/#{user.username}asdasd")
      current_path.should == root_path
      visit new_user_session_path
      should have_content('Entrada')
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
      visit admin_deals_path
      should have_content('Para continuar, faça login ou registre-se.')
      visit admin_users_path
      should have_content('Para continuar, faça login ou registre-se.')
      visit admin_deal_path(deal)
      should have_content('Para continuar, faça login ou registre-se.')
      visit admin_user_path(user)
      should have_content('Para continuar, faça login ou registre-se.')
      visit new_admin_deal_path
      should have_content('Para continuar, faça login ou registre-se.')
      visit new_admin_user_path
      should have_content('Para continuar, faça login ou registre-se.')
      visit edit_admin_deal_path(deal)
      should have_content(' Para continuar, faça login ou registre-se.')
      visit edit_admin_user_path(user)
      should have_content('Para continuar, faça login ou registre-se.')
      visit new_admin_sale_path
      should have_content('Para continuar, faça login ou registre-se.')
      visit admin_sales_path
      should have_content('Para continuar, faça login ou registre-se.')
      visit edit_admin_sale_path(sale)
      should have_content('Para continuar, faça login ou registre-se.')
      visit admin_sale_path(sale)
      should have_content('Para continuar, faça login ou registre-se.')
      visit new_admin_product_path
      should have_content('Para continuar, faça login ou registre-se.')
      visit admin_products_path
      should have_content('Para continuar, faça login ou registre-se.')
      visit edit_admin_product_path(product)
      should have_content('Para continuar, faça login ou registre-se.')
      visit admin_product_path(product)
      should have_content('Para continuar, faça login ou registre-se.')
    end
  end
end