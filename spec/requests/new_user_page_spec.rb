# -*- encoding : utf-8 -*-
require 'spec_helper'

describe "Signup Page" do
  
  subject { page }

  before do
    # login_as FactoryGirl.create(:broker), :scope => :broker
    visit new_user_registration_path
  end

  it { should have_content('Novo Usuário') }
  it { should have_link('Entrar com facebook', :href => '/users/auth/facebook') }

  describe 'creating a user' do
    it 'successfully' do
      count = User.count
      fill_in 'user_email', :with => 'user@ofertus.com.br'
      fill_in 'user_username', :with => 'username'
      fill_in 'user_name', :with => 'Nome'
      fill_in 'user_password', :with => 'senha1'
      fill_in 'user_password_confirmation', :with => 'senha1'
      check 'terms_privacy'
      click_on 'signup_btn'
      (User.count - 1).should == count
      should have_content('Um email foi enviado para você confirmar sua conta.')
      should have_content('Favoritas do Ofertus')
    end

    it 'without check the terms_privacy should not create a user and show a message error' do
      count = User.count
      fill_in 'user_email', :with => 'user@ofertus.com.br'
      fill_in 'user_username', :with => 'username'
      fill_in 'user_name', :with => 'Nome'
      fill_in 'user_password', :with => 'senha1'
      fill_in 'user_password_confirmation', :with => 'senha1'
      # check 'terms_privacy'
      click_on 'signup_btn'
      (User.count).should == count
      should have_content('Para se cadastrar é necessário concordar com os termos de uso e a política de privacidade do site.')
      should have_content('Novo Usuário')
    end
  end
end