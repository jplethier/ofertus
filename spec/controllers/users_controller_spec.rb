# -*- encoding : utf-8 -*-
require 'spec_helper'

describe UsersController do
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

  describe "GET 'show'" do
    before do
      # sign_in(:user, FactoryGirl.create(:user))
      user = FactoryGirl.create(:user)
      get 'show', :id => user.username
    end
    
    it { should respond_with(:success) }
    it { should render_template(:show) }
    it { should render_with_layout(:application) }
    it { should respond_with_content_type(:html) }
  end

  describe "routes" do
    it { should route(:get, "/users").to(:controller => :users, :action => :index) }
    it { should route(:get, "/users/username").to(:controller => :users, :action => :show, :id => "username") }
  end
end