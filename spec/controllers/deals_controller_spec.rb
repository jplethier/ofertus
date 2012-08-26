# -*- encoding : utf-8 -*-
require 'spec_helper'

describe DealsController do
  include Devise::TestHelpers

  describe "GET 'index'" do
    before do
      # sign_in(:user, FactoryGirl.create(:user))
      get 'index'
    end
    
    it { should respond_with(:success) }
    it { should render_template(:index) }
    it { should render_with_layout(:application) }
    it { should respond_with_content_type(:html) }
  end

  describe "GET 'today'" do
    before do
      # sign_in(:user, FactoryGirl.create(:user))
      get 'today'
    end
    
    it { should respond_with(:success) }
    it { should render_template(:today) }
    it { should render_with_layout(:application) }
    it { should respond_with_content_type(:html) }
  end

  describe "GET 'show'" do
    before do
      deal = FactoryGirl.create(:deal)
      get 'show', :id => deal.id
    end
    
    it { should respond_with(:success) }
    it { should assign_to(:deal) }
    it { should render_template(:show) }
    it { should render_with_layout(:application) }
    it { should respond_with_content_type(:html) }
  end

  describe "GET 'today/restaurant'" do
    before do
      get 'today', :category => :restaurant
    end
    
    it { should respond_with(:success) }
    it { should render_template(:today) }
    it { should render_with_layout(:application) }
    it { should respond_with_content_type(:html) }
  end

  describe "GET 'index/computer'" do
    before do
      get 'index', :category => :computer
    end
    
    it { should respond_with(:success) }
    it { should render_template(:index) }
    it { should render_with_layout(:application) }
    it { should respond_with_content_type(:html) }
  end

  describe "routes" do
    it { should route(:get, "/deals/active/beauty_and_health").to(:controller => :deals, :action => :index, :category => "beauty_and_health") }
    it { should route(:get, "/deals/today").to(:controller => :deals, :action => :today) }
    it { should route(:get, "/deals/1").to(:controller => :deals, :action => :show, :id => 1) }
    it { should route(:get, "/deals/today/computer").to(:controller => :deals, :action => :today, :category => :computer) }
    it { should route(:get, "/deals/new").to(:controller => :deals, :action => :new) }
    it { should route(:post, "/deals").to(:controller => :deals, :action => :create) }
  end
end