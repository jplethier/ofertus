# coding: UTF-8
require 'spec_helper'

describe BlogPost do
  let(:blog_post) { FactoryGirl.build :blog_post }
  subject { blog_post }

  its(:save) { should be_true }
  
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
      it "url with space should not be valid" do
        blog_post.url = 'titulo do post'
        blog_post.should_not be_valid
      end

      it "url with accent should not be valid" do
        blog_post.url = 'título'
        blog_post.should_not be_valid
      end

      it "url with . should not be vlaid" do
        blog_post.url = 'titulo.do.post'
        blog_post.should_not be_valid
      end

      it "url with / should not be valid" do
        blog_post.url = 'titulo/do/post'
        blog_post.should_not be_valid
      end

      it "url with capital letters should not be valid" do
        blog_post.url = 'TITULO'
        blog_post.should_not be_valid
      end
    end

    pending "add more validations tests"
  end
end
