# == Schema Information
#
# Table name: cities
#
#  id         :integer          not null, primary key
#  name       :string(255)      not null
#  state      :string(255)      not null
#  country    :string(255)      not null
#  created_at :datetime
#  updated_at :datetime
#

#coding: UTF-8
require 'spec_helper'

describe City do
  let(:city) { FactoryGirl.build :city }
  subject { city }

  its(:save) { should be_true }
  its(:switched_on?) { should be_true }

  it { should respond_to :users }
  it { should respond_to :deals }

  describe "Accessibility" do
    it { should allow_mass_assignment_of(:name) }
    it { should allow_mass_assignment_of(:state) }
    it { should allow_mass_assignment_of(:country) }
  end

  describe "Validations" do
    it "should require a name" do
      city.name = nil
      city.should_not be_valid
    end

    it "should require a state" do
      city.state = nil
      city.should_not be_valid
    end

    it "should require a country" do
      city.country = nil
      city.should_not be_valid
    end
  end

  describe "hash of states" do
    it "should return a hash grouped by states and ordered by states, cities names" do
      national = FactoryGirl.create(:city, :name => 'Oferta Nacional', :state => 'Oferta Nacional')
      city1 = FactoryGirl.create(:city, :name => 'a', :state => 'a')
      city2 = FactoryGirl.create(:city, :name => 'b', :state => 'a')
      city3 = FactoryGirl.create(:city, :name => 'a', :state => 'b')
      city4 = FactoryGirl.create(:city, :name => 'asdasd', :state => 'c')
      city5 = FactoryGirl.create(:city, :name => 'abdasd', :state => 'c')

      City.hash_by_states.should == {"Oferta Nacional"=>[["Oferta Nacional", national.id]], "a"=>[["a", city1.id], ["b", city2.id]], "b"=>[["a", city3.id]], "c"=>[["abdasd", city5.id], ["asdasd", city4.id]]}
    end
  end
end
