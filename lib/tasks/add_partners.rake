#encoding: utf-8

namespace :db do

  desc "Fill database with first partners"

  task :load_partners => :environment do
    puts "-------- Criando parceiros -----------"
    puts "-------- Americanas ----------"
    Partner.create(name: 'Americanas', commission: 4, user_commission: 1.5, code: 5632)
    puts "-------- Ana Hickmann ----------"
    Partner.create(name: 'Ana Hickmann', commission: 12, user_commission: 5, code: 5662)
    puts "-------- Apple Store ----------"
    Partner.create(name: 'Apple Store', commission: 4, user_commission: 1.5, code: 26)
    puts "-------- Assine Abril ----------"
    Partner.create(name: 'Assine Abril', commission: 12, user_commission: 5, code: 5713)
    puts "-------- Brandsclub ----------"
    Partner.create(name: 'Brandsclub', commission: 12, user_commission: 5, code: 5583)
    puts "-------- Brinquedos Laura ----------"
    Partner.create(name: 'Brinquedos Laura', commission: 7, user_commission: 3.5, code: 5762)
    puts "-------- Camiseteria ----------"
    Partner.create(name: 'Camiseteria', commission: 6, user_commission: 3, code: 5736)
    puts "-------- Carrefour ----------"
    Partner.create(name: 'Carrefour', commission: 3, user_commission: 1.5, code: 5630)
    puts "-------- CarZ ----------"
    Partner.create(name: 'CarZ', commission: 0, user_commission: 0, code: 76)
    puts "-------- Casas Bahia ----------"
    Partner.create(name: 'Casas Bahia', commission: 3.5, user_commission: 1.5, code: 5756)
    puts "-------- Cd Point ----------"
    Partner.create(name: 'Cd Point', commission: 4.24, user_commission: 2, code: 10)
    puts "-------- Cestas Michelli ----------"
    Partner.create(name: 'Cestas Michelli', commission: 0, user_commission: 0, code: 5706)
    puts "-------- CVC ----------"
    Partner.create(name: 'CVC', commission: 8, user_commission: 3.5, code: 5708)
    puts "-------- CyberDiet ----------"
    Partner.create(name: 'CyberDiet', commission: 15, user_commission: 7, code: 5)
    puts "-------- Dafiti ----------"
    Partner.create(name: 'Dafiti', commission: 10, user_commission: 5, code: 5549)
    puts "-------- Dell ----------"
    Partner.create(name: 'Dell', commission: 4, user_commission: 1.5, code: 4)
    puts "-------- Época Cosméticos ----------"
    Partner.create(name: 'Época Cosméticos', commission: 8, user_commission: 4, code: 5761)
    puts "-------- Extra ----------"
    Partner.create(name: 'Extra', commission: 3.5, user_commission: 1.5, code: 5755)
    puts "-------- Fnac ----------"
    Partner.create(name: 'Fnac', commission: 6, user_commission: 2.5, code: 5731)
    puts "-------- Gimba ----------"
    Partner.create(name: 'Gimba', commission: 1.5, user_commission: 1, code: 5544)
    puts "-------- Girafa ----------"
    Partner.create(name: 'Girafa', commission: 5, user_commission: 2, code: 5727)
    puts "-------- Giuliana Flores ----------"
    Partner.create(name: 'Giuliana Flores', commission: 10.6, user_commission: 5, code: 5707)
    puts "-------- Grubster ----------"
    Partner.create(name: 'Grubster', commission: 50, user_commission: 20, code: 5720)
    puts "-------- Hopi Hari ----------"
    Partner.create(name: 'Hopi Hari', commission: 3.71, user_commission: 1.5, code: 5638)
    puts "-------- Kanui ----------"
    Partner.create(name: 'Kanui', commission: 10, user_commission: 5, code: 5750)
    puts "-------- Livraria da Folha ----------"
    Partner.create(name: 'Livraria da Folha', commission: 7, user_commission: 3, code: 5772)
    puts "-------- Livraria Saraiva ----------"
    Partner.create(name: 'Livraria Saraiva', commission: 4, user_commission: 1.5, code: 27)
    puts "-------- Lojas KD ----------"
    Partner.create(name: 'Lojas KD', commission: 10, user_commission: 4.5, code: 5664)
    puts "-------- Lojas MM ----------"
    Partner.create(name: 'Lojas MM', commission: 4, user_commission: 1.5, code: 150)
    puts "-------- Marisa ----------"
    Partner.create(name: 'Marisa', commission: 7, user_commission: 3, code: 5728)
    puts "-------- Martins Fontes ----------"
    Partner.create(name: 'Martins Fontes', commission: 6.5, user_commission: 3, code: 5745)
    puts "-------- Mobly ----------"
    Partner.create(name: 'Mobly', commission: 8, user_commission: 4, code: 5751)
    puts "-------- Netshoes ----------"
    Partner.create(name: 'Netshoes', commission: 5, user_commission: 2.5, code: 5783)
    puts "-------- Nova Flor ----------"
    Partner.create(name: 'Nova Flor', commission: 0, user_commission: 0, code: 5705)
    puts "-------- Ofertas Tam Compra Coletiva ----------"
    Partner.create(name: 'Ofertas Tam Compra Coletiva', commission: 6, user_commission: 3, code: 5741)
    puts "-------- Polishop ----------"
    Partner.create(name: 'Polishop', commission: 5.5, user_commission: 2.5, code: 158)
    puts "-------- Ponto Frio ----------"
    Partner.create(name: 'Ponto Frio', commission: 3.5, user_commission: 1.5, code: 5754)
    puts "-------- SaveMe Cupons ----------"
    Partner.create(name: 'SaveMe Cupons', commission: 8, user_commission: 4, code: 5726)
    puts "-------- Shoebiz ----------"
    Partner.create(name: 'Shoebiz', commission: 7, user_commission: 3, code: 5765)
    puts "-------- Shopfato ----------"
    Partner.create(name: 'Shopfato', commission: 4, user_commission: 1.5, code: 5737)
    puts "-------- Shoptime ----------"
    Partner.create(name: 'Shoptime', commission: 3, user_commission: 1.5, code: 5644)
    puts "-------- Submarino Viagens ----------"
    Partner.create(name: 'Submarino Viagens', commission: 3, user_commission: 1, code: 5760)
    puts "-------- Tam Passagens ----------"
    Partner.create(name: 'Tam Passagens', commission: 1.1, user_commission: 0.5, code: 5589)
    puts "-------- Tam Viagens ----------"
    Partner.create(name: 'Tam Viagens', commission: 6, user_commission: 2.5, code: 5590)
    puts "-------- Toy Mania ----------"
    Partner.create(name: 'Toy Mania', commission: 5, user_commission: 2, code: 168)
    puts "-------- Tricae ----------"
    Partner.create(name: 'Tricae', commission: 10, user_commission: 5, code: 5752)
    puts "-------- UZ Games ----------"
    Partner.create(name: 'UZ Games', commission: 4, user_commission: 2, code: 5780)
    puts "-------- Walmart ----------"
    Partner.create(name: 'Walmart', commission: 4, user_commission: 1.5, code: 5576)
    puts '-------- Parceiros criados --------'
  end
end
