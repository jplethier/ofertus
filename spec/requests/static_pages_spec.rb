# -*- encoding : utf-8 -*-
require 'spec_helper'

describe "Static Pages" do
  subject { page }

  describe 'how it works page' do
    before { visit how_it_works_path }

    it { should have_content 'Como funciona?' }
  end

  describe 'help page' do
    before { visit help_path }

    it { should have_content 'Informações - Ajuda' }
  end

  describe 'who are we page' do
    before { visit whoarewe_path }

    it { should have_content 'Quem somos' }
  end

  describe 'terms page' do
    before { visit termsofuse_path }

    it { should have_content 'Termos de Uso' }
  end

  describe 'privacy policy page' do
    before { visit privacypolicy_path }

    it { should have_content 'Política de Privacidade' }
  end
end