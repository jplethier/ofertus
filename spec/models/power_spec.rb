require 'spec_helper'

describe Power do
  let(:power) { FactoryGirl.build :power }

  subject { power }

  its(:save) { should be_true }
  its(:switched_on?) { should be_true }

  it { should respond_to :user }

  describe "Accessibility" do
    it { should_not allow_mass_assignment_of(:id) }
    it { should allow_mass_assignment_of(:quantity) }
    it { should allow_mass_assignment_of(:status) }
    it { should allow_mass_assignment_of(:user_id) }
  end

  describe "Validations" do
    it { should validate_presence_of(:user_id) }
    it { should validate_presence_of(:status) }
    it { should validate_presence_of(:quantity) }
  end

  describe "Associations" do
    it { should belong_to(:user) }
  end
end
