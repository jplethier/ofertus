require 'spec_helper'

describe Sale do
  let(:sale) { FactoryGirl.build :sale }

  subject { sale }

  its(:save) { should be_true }
  its(:switched_on?) { should be_true }

  it { should respond_to :products }
  it { should respond_to :user }

  describe "Accessibility" do
    it { should_not allow_mass_assignment_of(:id) }
    it { should allow_mass_assignment_of(:commission) }
    it { should allow_mass_assignment_of(:user_commission) }
    it { should allow_mass_assignment_of(:value) }
  end

  describe "Validations" do
    it { should validate_presence_of(:commission) }
    it { should validate_presence_of(:user_commission) }
    it { should validate_numericality_of(:value) }
  end

  describe "Associations" do
    it { should have_many(:products) }
    it { should belong_to(:user) }
  end
end
