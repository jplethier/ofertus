# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :blog_post do
    title "MyString"
    url "MyString"
    content "MyText"
    number_of_reads 1
  end
end