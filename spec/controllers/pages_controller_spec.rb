# -*- encoding : utf-8 -*-
require 'spec_helper'

describe PagesController do
  include Devise::TestHelpers

  describe "GET 'whoarewe'" do
    before do
      # sign_in(:user, FactoryGirl.create(:user))
      get 'whoarewe'
    end
    
    it { should respond_with(:success) }
    it { should render_template(:whoarewe) }
    it { should render_with_layout(:application) }
    it { should respond_with_content_type(:html) }
  end

  describe "GET 'how_it_works'" do
    before do
      # sign_in(:user, FactoryGirl.create(:user))
      get 'how_it_works'
    end
    
    it { should respond_with(:success) }
    it { should render_template(:how_it_works) }
    it { should render_with_layout(:application) }
    it { should respond_with_content_type(:html) }
  end

  describe "GET 'help'" do
    before do
      get 'help'
    end
    
    it { should respond_with(:success) }
    it { should render_template(:help) }
    it { should render_with_layout(:application) }
    it { should respond_with_content_type(:html) }
  end

  describe "GET 'termsofuse'" do
    before do
      get 'termsofuse'
    end
    
    it { should respond_with(:success) }
    it { should render_template(:termsofuse) }
    it { should render_with_layout(:application) }
    it { should respond_with_content_type(:html) }
  end

  describe "GET 'privacypolicy'" do
    before do
      get 'privacypolicy'
    end
    
    it { should respond_with(:success) }
    it { should render_template(:privacypolicy) }
    it { should render_with_layout(:application) }
    it { should respond_with_content_type(:html) }
  end

  describe "routes" do
    it { should route(:get, "/whoarewe").to(:controller => :pages, :action => :whoarewe) }
    it { should route(:get, "/how_it_works").to(:controller => :pages, :action => :how_it_works) }
    it { should route(:get, "/help").to(:controller => :pages, :action => :help) }
    it { should route(:get, "/termsofuse").to(:controller => :pages, :action => :termsofuse) }
    it { should route(:get, "/privacypolicy").to(:controller => :pages, :action => :privacypolicy) }
  end
end