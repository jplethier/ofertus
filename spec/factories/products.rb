# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :product do
    description "MyString"
    category "MyString"
    quantity 1
    value 1.5
  end
end
