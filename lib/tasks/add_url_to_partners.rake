#encoding: utf-8

namespace :db do

  desc "Fill database with first partners"

  task :add_url_to_partners => :environment do
    puts "-------- Adicionando url dos parceiros -----------"
    puts "-------- Americanas ----------"
    Partner.find_by_name('Americanas').update_attributes(url: 'http://el2.me/jERr')
    puts "-------- AmoMuito ----------"
    Partner.find_by_name('AmoMuito').update_attributes(url: 'http://el2.me/wLJW')
    puts "-------- Ana Hickmann ----------"
    Partner.find_by_name('Ana Hickmann').update_attributes(url: 'http://el2.me/uKfM')
    # puts "-------- Apple Store ----------"
    # Partner.find_by_name('Apple Store').update_attributes(url: '')
    puts "-------- Assine Abril ----------"
    Partner.find_by_name('Assine Abril').update_attributes(url: 'http://el2.me/Anlg')
    puts "-------- Brandsclub ----------"
    Partner.find_by_name('Brandsclub').update_attributes(url: 'http://el2.me/Anoc')
    puts "-------- Brinquedos Laura ----------"
    Partner.find_by_name('Brinquedos Laura').update_attributes(url: 'http://el2.me/uKr6')
    puts "-------- ByTennis ----------"
    Partner.find_by_name('ByTennis').update_attributes(url: 'http://el2.me/wFbR')
    puts "-------- Camiseteria ----------"
    Partner.find_by_name('Camiseteria').update_attributes(url: 'http://el2.me/AnoR')
    # puts "-------- Carrefour ----------"
    # Partner.find_by_name('Carrefour').update_attributes(url: 'http://el2.me/jERr')
    # puts "-------- CarZ ----------"
    # Partner.find_by_name('CarZ').update_attributes(url: 'http://el2.me/jERr')
    puts "-------- Casas Bahia ----------"
    Partner.find_by_name('Casas Bahia').update_attributes(url: 'http://el2.me/wPpm')
    # puts "-------- Cd Point ----------"
    # Partner.find_by_name('Cd Point').update_attributes(url: '')
    # puts "-------- Cestas Michelli ----------"
    # Partner.find_by_name('Cestas Michelli').update_attributes(url: 'http://el2.me/jERr')
    puts "-------- Compra Fácil ----------"
    Partner.find_by_name('Compra Fácil').update_attributes(url: 'http://www.comprafacil.com.br/afiliadoscf')
    puts "-------- CVC ----------"
    Partner.find_by_name('CVC').update_attributes(url: 'http://el2.me/AnqZ')
    puts "-------- CyberDiet ----------"
    Partner.find_by_name('CyberDiet').update_attributes(url: 'http://el2.me/Antt')
    puts "-------- Dafiti ----------"
    Partner.find_by_name('Dafiti').update_attributes(url: 'http://el2.me/jG1I')
    puts "-------- Dell ----------"
    Partner.find_by_name('Dell').update_attributes(url: 'http://el2.me/Anul')
    # puts "-------- Época Cosméticos ----------"
    # Partner.find_by_name('Época Cosméticos').update_attributes(url: 'http://el2.me/jERr')
    puts "-------- Extra ----------"
    Partner.find_by_name('Extra').update_attributes(url: 'http://el2.me/wFcb')
    puts "-------- Fnac ----------"
    Partner.find_by_name('Fnac').update_attributes(url: 'http://el2.me/jG4t')
    puts "-------- Gimba ----------"
    Partner.find_by_name('Gimba').update_attributes(url: 'http://el2.me/yhgH')
    puts "-------- Girafa ----------"
    Partner.find_by_name('Girafa').update_attributes(url: 'http://el2.me/jG5i')
    puts "-------- Giuliana Flores ----------"
    Partner.find_by_name('Giuliana Flores').update_attributes(url: 'http://el2.me/jG67')
    puts "-------- Grubster ----------"
    Partner.find_by_name('Grubster').update_attributes(url: 'http://el2.me/Anuz')
    puts "-------- Hopi Hari ----------"
    Partner.find_by_name('Hopi Hari').update_attributes(url: 'http://el2.me/AnuQ')
    puts "-------- Kanui ----------"
    Partner.find_by_name('Kanui').update_attributes(url: 'http://el2.me/vn7z')
    puts "-------- Livraria da Folha ----------"
    Partner.find_by_name('Livraria da Folha').update_attributes(url: 'http://el2.me/Anv7')
    puts "-------- Livraria Saraiva ----------"
    Partner.find_by_name('Livraria Saraiva').update_attributes(url: 'http://el2.me/jG7z')
    puts "-------- Lojas KD ----------"
    Partner.find_by_name('Lojas KD').update_attributes(url: 'http://el2.me/AnvA')
    puts "-------- Lojas MM ----------"
    Partner.find_by_name('Lojas MM').update_attributes(url: 'http://el2.me/k7FV')
    puts "-------- Marisa ----------"
    Partner.find_by_name('Marisa').update_attributes(url: 'http://el2.me/yhhY')
    puts "-------- Martins Fontes ----------"
    Partner.find_by_name('Martins Fontes').update_attributes(url: 'http://el2.me/AnwD')
    puts "-------- Mobly ----------"
    Partner.find_by_name('Mobly').update_attributes(url: 'http://el2.me/m6eB')
    puts "-------- Netshoes ----------"
    Partner.find_by_name('Netshoes').update_attributes(url: 'http://el2.me/Anxx')
    # puts "-------- Nova Flor ----------"
    # Partner.find_by_name('Nova Flor').update_attributes(url: 'http://el2.me/jERr')
    puts "-------- Ofertas Tam Compra Coletiva ----------"
    Partner.find_by_name('Ofertas Tam Compra Coletiva').update_attributes(url: 'http://el2.me/Anxq')
    # puts "-------- OPPA ----------"
    # Partner.find_by_name('OPPA').update_attributes(url: 'http://el2.me/jERr')
    puts "-------- Perfumaria Época Cosméticos ----------"
    Partner.find_by_name('Perfumaria Época Cosméticos').update_attributes(url: 'http://el2.me/AnxI')
    puts "-------- Polishop ----------"
    Partner.find_by_name('Polishop').update_attributes(url: 'http://el2.me/jG8h')
    puts "-------- Ponto Frio ----------"
    Partner.find_by_name('Ponto Frio').update_attributes(url: 'http://el2.me/yhec')
    # puts "-------- SaveMe Cupons ----------"
    # Partner.find_by_name('SaveMe Cupons').update_attributes(url: 'http://el2.me/jERr')
    puts "-------- Shoebiz ----------"
    Partner.find_by_name('Shoebiz').update_attributes(url: 'http://el2.me/AnxS')
    puts "-------- Shopfato ----------"
    Partner.find_by_name('Shopfato').update_attributes(url: 'http://el2.me/Anyi')
    # puts "-------- Shoptime ----------"
    # Partner.find_by_name('Shoptime').update_attributes(url: 'http://el2.me/jERr')
    puts "-------- Submarino ----------"
    Partner.find_by_name('Submarino').update_attributes(url: 'http://el2.me/wGja')
    # puts "-------- Submarino Viagens ----------"
    # Partner.find_by_name('Submarino Viagens').update_attributes(url: 'http://el2.me/jERr')
    puts "-------- Tam Passagens ----------"
    Partner.find_by_name('Tam Passagens').update_attributes(url: 'http://el2.me/AnyP')
    puts "-------- Tam Viagens ----------"
    Partner.find_by_name('Tam Viagens').update_attributes(url: 'http://el2.me/Anz3')
    puts "-------- Toy Mania ----------"
    Partner.find_by_name('Toy Mania').update_attributes(url: 'http://el2.me/kN6Q')
    puts "-------- Tricae ----------"
    Partner.find_by_name('Tricae').update_attributes(url: 'http://el2.me/Anzg')
    puts "-------- UZ Games ----------"
    Partner.find_by_name('UZ Games').update_attributes(url: 'http://el2.me/Anzn')
    puts "-------- Viajar Barato ----------"
    Partner.find_by_name('Viajar Barato').update_attributes(url: 'http://el2.me/yhfB')
    puts "-------- Walmart ----------"
    Partner.find_by_name('Walmart').update_attributes(url: 'http://el2.me/vn8E')
    puts '-------- Url dos parceiros adicionadas --------'
  end
end
