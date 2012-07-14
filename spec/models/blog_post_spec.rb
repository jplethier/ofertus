require 'spec_helper'

describe BlogPost do
  let(:blog_post) { FactoryGirl.build :blog_post }
  subject { blog_post }

  its(:save) { should be_true }
  its(:switched_on?) { should be_true }

  it { should respond_to :user }

  describe "Accessibility" do
    it { should allow_mass_assignment_of(:title) }
    it { should allow_mass_assignment_of(:url) }
    it { should allow_mass_assignment_of(:content) }
    it { should allow_mass_assignment_of(:user) }
    it { should allow_mass_assignment_of(:number_of_reads) }
  end

  describe "Validations" do
    it "title should be required" do
      blog_post.title = nil
      blog_post.should_not be_valid
    end

    it "content should be required" do
      blog_post.content = nil
      blog_post.should_not be_valid
    end

    it "user should be required" do
      blog_post.user = nil
      blog_post.should_not be_valid
    end

    it "title should be less then 100" do
      blog_post.title = "q"*101
      blog_post.should_not be_valid
    end

    it "content should be less then 10000" do
      blog_post.content = "q"*10001
      blog_post.should_not be_valid
    end

    it "url should be required" do
      blog_post.url = nil
      blog_post.should_not be_valid
    end

    describe "url should not contain illegal characters" do
      pending "add url tests here"
    end

    pending "add more validations tests"
  end
end
