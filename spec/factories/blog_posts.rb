# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :blog_post do
    title "Titulo"
    url "titulo"
    content "MyText"
    number_of_reads 1

    user
  end
end
