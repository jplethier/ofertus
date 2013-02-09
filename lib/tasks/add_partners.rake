#encoding: utf-8

namespace :db do

  desc "Fill database with first partners"

  task :load_partners => :environment do
    puts "-------- Criando parceiros -----------"
    puts "-------- Americanas ----------"
    if Partner.find_by_name('Americanas').blank?
      Partner.create(name: 'Americanas', commission: 4, user_commission: 1.5, code: 5632)
      puts "-------- Americanas Criado ----------"
    end
    puts "-------- AmoMuito ----------"
    if Partner.find_by_name('AmoMuito').blank?
      Partner.create(name: 'AmoMuito', commission: 8, user_commission: 4, code: 5815)
      puts "-------- AmoMuito Criado ----------"
    end
    puts "-------- Ana Hickmann ----------"
    if Partner.find_by_name('Ana Hickmann').blank?
      Partner.create(name: 'Ana Hickmann', commission: 12, user_commission: 5, code: 5662)
      puts "-------- Ana Hickmann Criado ----------"
    end
    puts "-------- Apple Store ----------"
    if Partner.find_by_name('Apple Store').blank?
      Partner.create(name: 'Apple Store', commission: 4, user_commission: 1.5, code: 26)
      puts "-------- Apple Store Criado ----------"
    end
    puts "-------- Assine Abril ----------"
    if Partner.find_by_name('Assine Abril').blank?
      Partner.create(name: 'Assine Abril', commission: 12, user_commission: 5, code: 5713)
      puts "-------- Assine Abril Criado ----------"
    end
    puts "-------- Brandsclub ----------"
    if Partner.find_by_name('Brandsclub').blank?
      Partner.create(name: 'Brandsclub', commission: 12, user_commission: 5, code: 5583)
      puts "-------- Brandsclub Criado ----------"
    end
    puts "-------- Brinquedos Laura ----------"
    if Partner.find_by_name('Brinquedos Laura').blank?
      Partner.create(name: 'Brinquedos Laura', commission: 7, user_commission: 3.5, code: 5762)
      puts "-------- Brinquedos Laura Criado ----------"
    end
    puts "-------- ByTennis ----------"
    if Partner.find_by_name('ByTennis').blank?
      Partner.create(name: 'ByTennis', commission: 6, user_commission: 3, code: 5788)
      puts "-------- ByTennis Criado ----------"
    end
    puts "-------- Camiseteria ----------"
    if Partner.find_by_name('Camiseteria').blank?
      Partner.create(name: 'Camiseteria', commission: 6, user_commission: 3, code: 5736)
      puts "-------- Camiseteria Criado ----------"
    end
    puts "-------- Carrefour ----------"
    if Partner.find_by_name('Carrefour').blank?
      Partner.create(name: 'Carrefour', commission: 3, user_commission: 1.5, code: 5630)
      puts "-------- Carrefour Criado ----------"
    end
    puts "-------- CarZ ----------"
    if Partner.find_by_name('CarZ').blank?
      Partner.create(name: 'CarZ', commission: 0, user_commission: 0, code: 76)
      puts "-------- CarZ Criado ----------"
    end
    puts "-------- Casas Bahia ----------"
    if Partner.find_by_name('Casas Bahia').blank?
      Partner.create(name: 'Casas Bahia', commission: 3.5, user_commission: 1.5, code: 5756)
      puts "-------- Casas Bahia Criado ----------"
    end
    puts "-------- Cd Point ----------"
    if Partner.find_by_name('Cd Point').blank?
      Partner.create(name: 'Cd Point', commission: 4.24, user_commission: 2, code: 10)
      puts "-------- Cd Point Criado ----------"
    end
    puts "-------- Cestas Michelli ----------"
    if Partner.find_by_name('Cestas Michelli').blank?
      Partner.create(name: 'Cestas Michelli', commission: 0, user_commission: 0, code: 5706)
      puts "-------- Cestas Michelli Criado ----------"
    end
    puts "-------- Compra Fácil ----------"
    if Partner.find_by_name('Compra Fácil').blank?
      Partner.create(name: 'Compra Fácil', commission: 0, user_commission: 0, code: nil)
      puts "-------- Compra Fácil Criado ----------"
    end
    puts "-------- CVC ----------"
    if Partner.find_by_name('CVC').blank?
      Partner.create(name: 'CVC', commission: 8, user_commission: 3.5, code: 5708)
      puts "-------- CVC Criado ----------"
    end
    puts "-------- CyberDiet ----------"
    if Partner.find_by_name('CyberDiet').blank?
      Partner.create(name: 'CyberDiet', commission: 15, user_commission: 7, code: 5)
      puts "-------- CyberDiet Criado ----------"
    end
    puts "-------- Dafiti ----------"
    if Partner.find_by_name('Dafiti').blank?
      Partner.create(name: 'Dafiti', commission: 10, user_commission: 5, code: 5549)
      puts "-------- Dafiti Criado ----------"
    end
    puts "-------- Dell ----------"
    if Partner.find_by_name('Dell').blank?
      Partner.create(name: 'Dell', commission: 4, user_commission: 1.5, code: 4)
      puts "-------- Dell Criado ----------"
    end
    puts "-------- Época Cosméticos ----------"
    if Partner.find_by_name('Época Cosméticos').blank?
      Partner.create(name: 'Época Cosméticos', commission: 8, user_commission: 4, code: 5761)
      puts "-------- Época Cosméticos Criado ----------"
    end
    puts "-------- Extra ----------"
    if Partner.find_by_name('Extra').blank?
      Partner.create(name: 'Extra', commission: 3.5, user_commission: 1.5, code: 5755)
      puts "-------- Extra Criado ----------"
    end
    puts "-------- Fnac ----------"
    if Partner.find_by_name('Fnac').blank?
      Partner.create(name: 'Fnac', commission: 6, user_commission: 2.5, code: 5731)
      puts "-------- Fnac Criado ----------"
    end
    puts "-------- Gimba ----------"
    if Partner.find_by_name('Gimba').blank?
      Partner.create(name: 'Gimba', commission: 1.5, user_commission: 1, code: 5544)
      puts "-------- Gimba Criado ----------"
    end
    puts "-------- Girafa ----------"
    if Partner.find_by_name('Girafa').blank?
      Partner.create(name: 'Girafa', commission: 5, user_commission: 2, code: 5727)
      puts "-------- Girafa Criado ----------"
    end
    puts "-------- Giuliana Flores ----------"
    if Partner.find_by_name('Giuliana Flores').blank?
      Partner.create(name: 'Giuliana Flores', commission: 10.6, user_commission: 5, code: 5707)
      puts "-------- Giuliana Flores Criado ----------"
    end
    puts "-------- Grubster ----------"
    if Partner.find_by_name('Grubster').blank?
      Partner.create(name: 'Grubster', commission: 50, user_commission: 20, code: 5720)
      puts "-------- Grubster Criado ----------"
    end
    puts "-------- Hopi Hari ----------"
    if Partner.find_by_name('Hopi Hari').blank?
      Partner.create(name: 'Hopi Hari', commission: 3.71, user_commission: 1.5, code: 5638)
      puts "-------- Hopi Hari Criado ----------"
    end
    puts "-------- Kanui ----------"
    if Partner.find_by_name('Kanui').blank?
      Partner.create(name: 'Kanui', commission: 10, user_commission: 5, code: 5750)
      puts "-------- Kanui Criado ----------"
    end
    puts "-------- Livraria da Folha ----------"
    if Partner.find_by_name('Livraria da Folha').blank?
      Partner.create(name: 'Livraria da Folha', commission: 7, user_commission: 3, code: 5772)
      puts "-------- Livraria da Folha Criado ----------"
    end
    puts "-------- Livraria Saraiva ----------"
    if Partner.find_by_name('Livraria Saraiva').blank?
      Partner.create(name: 'Livraria Saraiva', commission: 4, user_commission: 1.5, code: 27)
      puts "-------- Livraria Saraiva Criado ----------"
    end
    puts "-------- Lojas KD ----------"
    if Partner.find_by_name('Lojas  KD').blank?
      Partner.create(name: 'Lojas KD', commission: 10, user_commission: 4.5, code: 5664)
      puts "-------- Lojas KD Criado ----------"
    end
    puts "-------- Lojas MM ----------"
    if Partner.find_by_name('Lojas MM').blank?
      Partner.create(name: 'Lojas MM', commission: 4, user_commission: 1.5, code: 150)
      puts "-------- Lojas MM Criado ----------"
    end
    puts "-------- Marisa ----------"
    if Partner.find_by_name('Marisa').blank?
      Partner.create(name: 'Marisa', commission: 7, user_commission: 3, code: 5728)
      puts "-------- Marisa Criado ----------"
    end
    puts "-------- Martins Fontes ----------"
    if Partner.find_by_name('Martins Fontes').blank?
      Partner.create(name: 'Martins Fontes', commission: 6.5, user_commission: 3, code: 5745)
      puts "-------- Martins Fontes Criado ----------"
    end
    puts "-------- Mobly ----------"
    if Partner.find_by_name('Mobly').blank?
      Partner.create(name: 'Mobly', commission: 8, user_commission: 4, code: 5751)
      puts "-------- Mobly Criado ----------"
    end
    puts "-------- Netshoes ----------"
    if Partner.find_by_name('Netshoes').blank?
      Partner.create(name: 'Netshoes', commission: 5, user_commission: 2.5, code: 5783)
      puts "-------- Netshoes Criado ----------"
    end
    puts "-------- Nova Flor ----------"
    if Partner.find_by_name('Nova Flor').blank?
      Partner.create(name: 'Nova Flor', commission: 0, user_commission: 0, code: 5705)
      puts "-------- Nova Flor Criado ----------"
    end
    puts "-------- Ofertas Tam Compra Coletiva ----------"
    if Partner.find_by_name('Ofertas Tam Compra Coletiva').blank?
      Partner.create(name: 'Ofertas Tam Compra Coletiva', commission: 6, user_commission: 3, code: 5741)
      puts "-------- ofertas Tam Compra Coletiva Criado ----------"
    end
    puts "-------- OPPA ----------"
    if Partner.find_by_name('OPPA').blank?
      Partner.create(name: 'OPPA', commission: 8, user_commission: 4, code: 5794)
      puts "-------- OPPA Criado ----------"
    end
    puts "-------- Perfumaria Época Cosméticos ----------"
    if Partner.find_by_name('Perfumaria Época Cosméticos').blank?
      Partner.create(name: 'Perfumaria Época Cosméticos', commission: 9, user_commission: 4, code: 5761)
      puts "-------- Perfumaria Época Cosméticos Criado ----------"
    end
    puts "-------- Polishop ----------"
    if Partner.find_by_name('Polishop').blank?
      Partner.create(name: 'Polishop', commission: 5.5, user_commission: 2.5, code: 158)
      puts "-------- Polishop Criado ----------"
    end
    puts "-------- Ponto Frio ----------"
    if Partner.find_by_name('Ponto Frio').blank?
      Partner.create(name: 'Ponto Frio', commission: 3.5, user_commission: 1.5, code: 5754)
      puts "-------- Ponto Frio Criado ----------"
    end
    puts "-------- SaveMe Cupons ----------"
    if Partner.find_by_name('SaveMe Cupons').blank?
      Partner.create(name: 'SaveMe Cupons', commission: 8, user_commission: 4, code: 5726)
      puts "-------- SaveMe Cupons Criado ----------"
    end
    puts "-------- Shoebiz ----------"
    if Partner.find_by_name('Shoebiz').blank?
      Partner.create(name: 'Shoebiz', commission: 7, user_commission: 3, code: 5765)
      puts "-------- Shoebiz Criado ----------"
    end
    puts "-------- Shopfato ----------"
    if Partner.find_by_name('Shopfato').blank?
      Partner.create(name: 'Shopfato', commission: 4, user_commission: 1.5, code: 5737)
      puts "-------- Shopfato Criado ----------"
    end
    puts "-------- Shoptime ----------"
    if Partner.find_by_name('Shoptime').blank?
      Partner.create(name: 'Shoptime', commission: 3, user_commission: 1.5, code: 5644)
      puts "-------- Shoptime Criado ----------"
    end
    puts "-------- Submarino ----------"
    if Partner.find_by_name('Submarino').blank?
      Partner.create(name: 'Submarino', commission: 4, user_commission: 1.5, code: 5766)
      puts "-------- Submarino Criado ----------"
    end
    puts "-------- Submarino Viagens ----------"
    if Partner.find_by_name('Submarino Viagens').blank?
      Partner.create(name: 'Submarino Viagens', commission: 3, user_commission: 1, code: 5760)
      puts "-------- Submarino Viagens Criado ----------"
    end
    puts "-------- Tam Passagens ----------"
    if Partner.find_by_name('Tam Passagens').blank?
      Partner.create(name: 'Tam Passagens', commission: 1.1, user_commission: 0.5, code: 5589)
      puts "-------- Tam Passagens Criado ----------"
    end
    puts "-------- Tam Viagens ----------"
    if Partner.find_by_name('Tam Viagens').blank?
      Partner.create(name: 'Tam Viagens', commission: 6, user_commission: 2.5, code: 5590)
      puts "-------- Tam Viagens Criado ----------"
    end
    puts "-------- Toy Mania ----------"
    if Partner.find_by_name('Toy Mania').blank?
      Partner.create(name: 'Toy Mania', commission: 5, user_commission: 2, code: 168)
      puts "-------- Toy Mania Criado ----------"
    end
    puts "-------- Tricae ----------"
    if Partner.find_by_name('Tricae').blank?
      Partner.create(name: 'Tricae', commission: 10, user_commission: 5, code: 5752)
      puts "-------- Tricae Criado ----------"
    end
    puts "-------- UZ Games ----------"
    if Partner.find_by_name('UZ Games').blank?
      Partner.create(name: 'UZ Games', commission: 4, user_commission: 2, code: 5780)
      puts "-------- UZ Games Criado ----------"
    end
    puts "-------- Viajar Barato ----------"
    if Partner.find_by_name('Viajar Barato').blank?
      Partner.create(name: 'Viajar Barato', commission: 7, user_commission: 3, code: 5831)
      puts "-------- Viajar Barato Criado ----------"
    end
    puts "-------- Walmart ----------"
    if Partner.find_by_name('Walmart').blank?
      Partner.create(name: 'Walmart', commission: 4, user_commission: 1.5, code: 5576)
      puts "-------- Walmart Criado ----------"
    end
    puts '-------- Parceiros criados --------'
  end
end
