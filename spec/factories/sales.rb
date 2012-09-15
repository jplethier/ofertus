FactoryGirl.define do
  factory :sale do
    value 1.5
    commission 5
    user_commission 2.5
    store "MyString"
    affiliate "MyString"
  end
end
