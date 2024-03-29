# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  confirmation_token     :string(255)
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(128)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0)
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  created_at             :datetime
#  updated_at             :datetime
#  name                   :string(255)
#  username               :string(255)      not null
#  up_votes               :integer          default(0), not null
#  down_votes             :integer          default(0), not null
#  uid                    :string(255)
#  provider               :string(255)
#  avatar_url             :string(255)
#  access_token           :string(255)
#  facebook_share_offer   :boolean          default(TRUE), not null
#  facebook_vote_offer    :boolean          default(TRUE), not null
#  facebook_follow_user   :boolean          default(TRUE), not null
#  credit                 :decimal(8, 2)    default(0.0), not null
#  admin                  :boolean          default(FALSE)
#  invited_by_id          :integer
#  withdraw_option        :integer
#  withdraw_bank_cpf      :string(255)
#  withdraw_bank_account  :string(255)
#  withdraw_bank_agency   :string(255)
#  withdraw_bank_number   :string(255)
#  withdraw_bank_name     :string(255)
#  withdraw_digital_cpf   :string(255)
#  withdraw_digital_email :string(255)
#  withdraw_digital_name  :string(255)
#  withdraw_remember      :boolean          default(TRUE)
#

#coding: UTF-8
require 'spec_helper'

describe User do
  let(:user) { FactoryGirl.build :user }
  subject { user }

  its(:save) { should be_true }
  its(:switched_on?) { should be_true }

  it { should respond_to :cities }
  it { should respond_to :deals }
  it { should respond_to :relationships }
  it { should respond_to :followers }
  it { should respond_to :following }
  it { should respond_to :reverse_relationships }
  it { should respond_to :login }
  it { should respond_to :login= }
  it { should respond_to :sales }
  it { should have_many :sales }

  describe "Accessibility" do
    it { should allow_mass_assignment_of(:email) }
    it { should allow_mass_assignment_of(:name) }
    it { should allow_mass_assignment_of(:password) }
    it { should allow_mass_assignment_of(:password_confirmation) }
    it { should allow_mass_assignment_of(:remember_me) }
    it { should allow_mass_assignment_of(:username) }
    it { should allow_mass_assignment_of(:provider) }
    it { should allow_mass_assignment_of(:uid) }
    it { should allow_mass_assignment_of(:avatar_url) }
    it { should allow_mass_assignment_of(:access_token) }
    it { should allow_mass_assignment_of(:facebook_follow_user) }
    it { should allow_mass_assignment_of(:facebook_vote_offer) }
    it { should allow_mass_assignment_of(:facebook_share_offer) }
  end

  describe "#guest?" do
    it "should be true to unregistered users" do
      User.new.guest?.should == true
    end

    it "should be false to registered users" do
      user.tap{|u| u.save!}.guest?.should == false
    end
  end

  describe "email" do
    it "should be required" do
      user.email = ""
      user.should_not be_valid
    end

    it "should accept valid email addresses" do
      addresses = %w[user@foo.com THE_USER@foo.bar.org first.last@foo.jp]
      addresses.each do |address|
        user.email = address
        user.should be_valid
      end
    end

    it "should reject invalid email addresses" do
      addresses = %w[user@foo,com user_at_foo.org example.user@foo.]
      addresses.each do |address|
        user.email = address
        user.should_not be_valid
      end
    end

    it "should reject duplicate email addresses" do
      duplicated_email = FactoryGirl.create(:user).email
      user.email = duplicated_email
      user.should_not be_valid
    end

    it "should reject email addresses identical up to case" do
      email = "upcase@test.com"
      FactoryGirl.create :user, :email => email
      user.email = email.upcase
      user.should_not be_valid
    end
  end

  describe "passwords" do
    it "should have a password attribute" do
      user.should respond_to(:password)
    end

    it "should have a password confirmation attribute" do
      user.should respond_to(:password_confirmation)
    end
  end

  describe "password validations" do
    it "should require a password" do
      user.password = ""
      user.password_confirmation = ""
      user.should_not be_valid
    end

    it "should require a matching password confirmation" do
      user.password_confirmation = "invalid"
      user.should_not be_valid
    end

    it "should reject short passwords" do
      short = "a" * 5
      user.password = short
      user.password_confirmation = short
      user.should_not be_valid
    end
  end

  describe "password encryption" do
    it "should have an encrypted password attribute" do
      user.should respond_to(:encrypted_password)
    end

    it "should set the encrypted password attribute" do
      user.encrypted_password.should_not be_blank
    end
  end

  describe "relationships" do
    let(:user) { FactoryGirl.create :confirmed_user }
    let(:another_user) { FactoryGirl.create :confirmed_user }

    it "shouldn't be able to follow himself" do
      lambda { user.follow! user }.should raise_error(ActiveRecord::RecordInvalid)
    end

    it "should create a new relationship when a user follow another" do
      user.follow! another_user
      user.reload
      user.following.length.should == 1
    end

    it "should destroy the relationship when a user unfollow another" do
      user.follow! another_user
      user.unfollow! another_user
      user.following.length.should == 0
    end

    context "no user followed" do
      before(:each) do
        user.following.size.should == 0
      end

      it "should be able to follow another user" do
        user.follow! another_user
      end
    end

    context "one user followed" do
      before(:each) do
        @followed_user = FactoryGirl.create :confirmed_user
        user.follow! @followed_user

        user.following.size.should == 1
      end

      it "should follow that user" do
        (user.follow? @followed_user).should == true
      end

      it "should be able to follow one more user" do
        user.follow! another_user
      end

      it "should be able to stop following the followed user" do
        user.unfollow! @followed_user
      end
    end

    context "two users followed" do
      before(:each) do
        @first_followed_user = FactoryGirl.create :confirmed_user
        @second_followed_user = FactoryGirl.create :confirmed_user
        user.follow! @first_followed_user
        user.follow! @second_followed_user

        user.following.size.should == 2
      end

      it "should follow both users" do
        (user.follow? @first_followed_user).should == true
        (user.follow? @second_followed_user).should == true
      end

      it "should be able to follow one more user" do
        user.follow! another_user
      end

      it "shouldn't stop following all other users once a user stops following one" do
        user.unfollow! @first_followed_user

        user.following.first.should == @second_followed_user
      end
    end
  end

  describe "username" do
    it "should be required" do
      user.username = ""
      user.should_not be_valid
    end

    it "should be unique" do
      duplicated_username = FactoryGirl.create(:user).username
      user.username = duplicated_username
      user.should_not be_valid
    end

    it "should be case-insensitive" do
      username = "upcase_test"
      FactoryGirl.create :user, :username => username
      user.username = username.upcase
      user.should_not be_valid
    end

    it "should not have less than 5 characters" do
      user.username = "a" * 4
      user.should_not be_valid
    end

    it "should not have more than 20 characters" do
      user.username = "a" * 21
      user.should_not be_valid
    end

    it "should allow underscores" do
      user.username = "with_underscore"
      user.should be_valid
    end
  end

  describe "facebook options" do

    it "should be all true if is a new user" do
      (user.facebook_share_offer && user.facebook_follow_user && user.facebook_vote_offer).should be_true
    end
  end

  describe "afilliate data" do

    it "user without credit information should be saved as 0 credit" do
      user.credit = nil
      user.save
      user.reload
      user.credit.should == 0.0
    end
  end

  describe 'search queries' do
    it 'by username' do
      user.username = 'my_username'
      user.save
      user.reload
      User.by_username('my_username').should == user
    end

    it 'search' do
      user.username = 'username'
      user.save
      user.reload
      another_user = FactoryGirl.create(:user, :name => 'name')
      query = User.search('name')
      query.count.should == 2
      query.should =~ [user, another_user]
      query = User.search('username')
      query.count.should == 1
      query.should == [user]
      query = User.search('not name')
      query.count.should == 0
      query.should == []
    end

    it 'find record' do
      user.save
      user.reload
      User.find_record(user.username).should == user
      User.find_record(user.email).should == user
      User.find_record(user.username + 'asd').should == nil
    end

    it 'find for database authenticate' do
      user.save
      user.reload
      User.find_for_database_authentication(:login => user.username).should == user
      User.find_for_database_authentication(:login => user.email).should == user
      User.find_for_database_authentication(:login => "#{user.username}asoihu").should == nil
    end

    it 'send_reset_password_instructions' do
      user.save
      user.reload
      User.send_reset_password_instructions(:email => user.email).should == user
      User.send_reset_password_instructions(:email => "#{user.email}abc").errors.messages.should == {:email => ["não encontrado"]}
    end
  end

  it 'set_invited_by' do
    another_user = FactoryGirl.create(:user)
    user.set_invited_by(another_user.username)
    user.reload
    another_user.inviteds.count.should == 1
    user.invited_by.should == another_user
    another_user.inviteds.first.should == user
  end
end
