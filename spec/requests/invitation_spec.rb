#coding: UTF-8
require 'spec_helper'

describe "User invitation" do

  let(:invited_by) { FactoryGirl.create(:user) }

  subject { page }

  before do
    invited_by.save
  end

  describe 'correct invite url' do
    before { visit '/invite/' + invited_by.username }

    it 'creating a user' do
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
      should have_content('Favoritas do Ofertus')
      new_user = User.last
      invited_by.inviteds.count.should == 1
      invited_by.inviteds.last.should == new_user
      new_user.invited_by.should == invited_by
    end
  end

  describe 'wrong invite url' do
    before { visit '/invite/' + invited_by.username + 'asdasd' }
    
    it { current_path.should == root_path }
  end
end