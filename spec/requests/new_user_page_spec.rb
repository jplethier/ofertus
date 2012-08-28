# -*- encoding : utf-8 -*-
require 'spec_helper'

describe "Signup Page" do
  
  subject { page }

  before do
    # login_as FactoryGirl.create(:broker), :scope => :broker
    visit new_user_registration_path
  end

  it { should have_content('Novo Usuário') }
  it { should have_content('Preencha os campos abaixo') }
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
      should have_content('A sua conta foi criada com sucesso. No entanto, não foi possível fazer login, pois ela não foi confirmada ainda.')
      should have_content('Ofertas Ativas')
    end
  end
end