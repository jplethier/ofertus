require 'spec_helper'

describe BlogComment do
  let(:blog_comment) { FactoryGirl.build :blog_comment }
  subject { blog_comment }

  its(:save) { should be_true }
  its(:switched_on?) { should be_true }

  it { should respond_to :user }
  it { should respond_to :blog_post }

  describe "Accessibility" do
    it { should allow_mass_assignment_of(:title) }
    it { should allow_mass_assignment_of(:url) }
    it { should allow_mass_assignment_of(:content) }
    it { should allow_mass_assignment_of(:user) }
    it { should allow_mass_assignment_of(:number_of_reads) }
  end

  describe "Validations" do
  end

  pending "add some examples to (or delete) #{__FILE__}"
end
