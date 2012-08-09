# -*- encoding : utf-8 -*-
require 'spec_helper'

describe DealsController do
  include Devise::TestHelpers

  describe "GET 'index'" do
    before do
      sign_in(:user, FactoryGirl.create(:user))
      get 'index'
    end
    
    it { should respond_with(:success) }
    it { should render_template(:index) }
    it { should render_with_layout(:application) }
    it { should respond_with_content_type(:html) }
  end
  
  describe "routes" do
    it { should route(:get, "/deal/active").to(:controller => :deals, :action => :index) }
    it { should route(:get, "/deals/today").to(:controller => :deals, :action => :today) }
    it { should route(:get, "/deals/1").to(:controller => :deals, :action => :today, :id => 1) }
    it { should route(:get, "/deals/today/computer").to(:controller => :deals, :action => :today, :category => :computer) }
  end
end