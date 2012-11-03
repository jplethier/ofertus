#encoding: utf-8

namespace :db do

  desc "Fill database with first partners"

  task :load_partners => :environment do
    puts "-------- Criando 20 parceiros -----------"
    puts "-------- Americanas ----------"
    Partner.create(name: 'Apple Store', commission: 4, user_commission: 1.5, code: 26)
    puts "-------- BrandsBag ----------"
    Partner.create(name: 'BrandsClub', commission: 4, user_commission: 1.5, code: 26)
    puts '-------- Parceiros criados --------'
  end
end
