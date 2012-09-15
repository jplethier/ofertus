require 'spec_helper'

describe Product do
  let(:product) { FactoryGirl.build :product }

  subject { product }

  its(:save) { should be_true }
  its(:switched_on?) { should be_true }

  it { should respond_to :sale }

  describe "Accessibility" do
    it { should_not allow_mass_assignment_of(:id) }
    it { should allow_mass_assignment_of(:category) }
    it { should allow_mass_assignment_of(:description) }
    it { should allow_mass_assignment_of(:quantity) }
    it { should allow_mass_assignment_of(:value) }
  end

  describe "Validations" do
    it { should validate_presence_of(:quantity) }
    it { should validate_numericality_of(:value) }
  end

  describe "Associations" do
    it { should belong_to(:sale) }
  end
end
