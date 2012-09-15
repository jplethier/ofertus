# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :sale do
    product "MyString"
    value 1.5
    commission 1
    store "MyString"
    affiliate "MyString"
  end
end
