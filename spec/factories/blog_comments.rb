# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :blog_comment do
    title "MyString"
    email "MyString"
    name "MyString"
    site "MyString"
    content "MyText"
  end
end
