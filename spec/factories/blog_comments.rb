# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :blog_comment do
    name "MyString"
    content "MyText"

    blog_post
  end
end
