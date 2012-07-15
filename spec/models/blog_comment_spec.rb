require 'spec_helper'

describe BlogComment do
  let(:blog_comment) { FactoryGirl.build :blog_comment }
  subject { blog_comment }

  its(:save) { should be_true }

  it { should respond_to :user }
  it { should respond_to :blog_post }

  describe "Accessibility" do
    it { should allow_mass_assignment_of(:title) }
    it { should allow_mass_assignment_of(:name) }
    it { should allow_mass_assignment_of(:content) }
    it { should allow_mass_assignment_of(:user) }
    it { should allow_mass_assignment_of(:blog_post) }
    it { should allow_mass_assignment_of(:email) }
    it { should allow_mass_assignment_of(:site) }
  end

  describe "Validations" do
    it "user should not be required" do
      blog_comment.user = nil
      blog_comment.should be_valid
    end

    it "blog_post should be required" do
      blog_comment.blog_post = nil
      blog_comment.should_not be_valid
    end

    it "title should not be required" do
      blog_comment.title = nil
      blog_comment.should be_valid
    end

    it "title should be less then 50" do
      blog_comment.title = "q"*51
      blog_comment.should_not be_valid
    end

    it "name should be required" do
      blog_comment.name = nil
      blog_comment.should_not be_valid
    end

    it "content should be required" do
      blog_comment.content = nil
      blog_comment.should_not be_valid
    end

    describe "email" do
      it "should not be required" do
        blog_comment.email = nil
        blog_comment.should be_valid
      end

      it "'a@.com' should not be valid" do
        blog_comment.email = 'a@.com'
        blog_comment.should_not be_valid
      end

      it "'a@a' should not be valid" do
        blog_comment.email = 'a@a'
        blog_comment.should_not be_valid
      end

      it "'@a.com' should not be valid" do
        blog_comment.email = '@a.com'
        blog_comment.should_not be_valid
      end

      it "'a@a.com' should be valid" do
        blog_comment.email = 'a@a.com'
        blog_comment.should be_valid
      end

      it "'a@a.com.br' should be valid" do
        blog_comment.email = 'a@a.com.br'
        blog_comment.should be_valid
      end
    end

    describe "#site" do
      it "should not be required" do
        blog_comment.site = nil
        blog_comment.should be_valid
      end

      it "'www.a.com' should be invalid" do
        blog_comment.site = 'www.a.com'
        blog_comment.should_not be_valid
      end

      it "'http://www.a.com' should be valid" do
        blog_comment.site = 'http://www.a.com'
        blog_comment.should be_valid
      end
    end
  end

  pending "add some examples to (or delete) #{__FILE__}"
end
