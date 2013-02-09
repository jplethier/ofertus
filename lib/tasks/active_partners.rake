#encoding: utf-8

namespace :db do

  desc "Fill database with first partners"

  task :active_partners => :environment do
    puts "-------- Ativando parceiros -----------"
    # puts "-------- Americanas ----------"
    # Partner.find_by_name('Americanas').update_attributes(active: true)
    puts "-------- AmoMuito ----------"
    Partner.find_by_name('AmoMuito').update_attributes(active: true)
    puts "-------- Ana Hickmann ----------"
    Partner.find_by_name('Ana Hickmann').update_attributes(active: true)
    # puts "-------- Apple Store ----------"
    # Partner.find_by_name('Apple Store').update_attributes(active: true)
    # puts "-------- Assine Abril ----------"
    # Partner.find_by_name('Assine Abril').update_attributes(active: true)
    # puts "-------- Brandsclub ----------"
    # Partner.find_by_name('Brandsclub').update_attributes(active: true)
    puts "-------- Brinquedos Laura ----------"
    Partner.find_by_name('Brinquedos Laura').update_attributes(active: true)
    puts "-------- ByTennis ----------"
    Partner.find_by_name('ByTennis').update_attributes(active: true)
    # puts "-------- Camiseteria ----------"
    # Partner.find_by_name('Camiseteria').update_attributes(active: true)
    # puts "-------- Carrefour ----------"
    # Partner.find_by_name('Carrefour').update_attributes(active: true)
    # puts "-------- CarZ ----------"
    # Partner.find_by_name('CarZ').update_attributes(active: true)
    puts "-------- Casas Bahia ----------"
    Partner.find_by_name('Casas Bahia').update_attributes(active: true)
    # puts "-------- Cd Point ----------"
    # Partner.find_by_name('Cd Point').update_attributes(active: true)
    # puts "-------- Cestas Michelli ----------"
    # Partner.find_by_name('Cestas Michelli').update_attributes(active: true)
    puts "-------- Compra Fácil ----------"
    Partner.find_by_name('Compra Fácil').update_attributes(active: true)
    # puts "-------- CVC ----------"
    # Partner.find_by_name('CVC').update_attributes(active: true)
    # puts "-------- CyberDiet ----------"
    # Partner.find_by_name('CyberDiet').update_attributes(active: true)
    puts "-------- Dafiti ----------"
    Partner.find_by_name('Dafiti').update_attributes(active: true)
    # puts "-------- Dell ----------"
    # Partner.find_by_name('Dell').update_attributes(active: true)
    # puts "-------- Época Cosméticos ----------"
    # Partner.find_by_name('Época Cosméticos').update_attributes(active: true)
    puts "-------- Extra ----------"
    Partner.find_by_name('Extra').update_attributes(active: true)
    puts "-------- Fnac ----------"
    Partner.find_by_name('Fnac').update_attributes(active: true)
    puts "-------- Gimba ----------"
    Partner.find_by_name('Gimba').update_attributes(active: true)
    puts "-------- Girafa ----------"
    Partner.find_by_name('Girafa').update_attributes(active: true)
    puts "-------- Giuliana Flores ----------"
    Partner.find_by_name('Giuliana Flores').update_attributes(active: true)
    # puts "-------- Grubster ----------"
    # Partner.find_by_name('Grubster').update_attributes(active: true)
    # puts "-------- Hopi Hari ----------"
    # Partner.find_by_name('Hopi Hari').update_attributes(active: true)
    puts "-------- Kanui ----------"
    Partner.find_by_name('Kanui').update_attributes(active: true)
    # puts "-------- Livraria da Folha ----------"
    # Partner.find_by_name('Livraria da Folha').update_attributes(active: true)
    puts "-------- Livraria Saraiva ----------"
    Partner.find_by_name('Livraria Saraiva').update_attributes(active: true)
    # puts "-------- Lojas KD ----------"
    # Partner.find_by_name('Lojas KD').update_attributes(active: true)
    puts "-------- Lojas MM ----------"
    Partner.find_by_name('Lojas MM').update_attributes(active: true)
    puts "-------- Marisa ----------"
    Partner.find_by_name('Marisa').update_attributes(active: true)
    # puts "-------- Martins Fontes ----------"
    # Partner.find_by_name('Martins Fontes').update_attributes(active: true)
    puts "-------- Mobly ----------"
    Partner.find_by_name('Mobly').update_attributes(active: true)
    # puts "-------- Netshoes ----------"
    # Partner.find_by_name('Netshoes').update_attributes(active: true)
    # puts "-------- Nova Flor ----------"
    # Partner.find_by_name('Nova Flor').update_attributes(active: true)
    # puts "-------- Ofertas Tam Compra Coletiva ----------"
    # Partner.find_by_name('Ofertas Tam Compra Coletiva').update_attributes(active: true)
    # puts "-------- OPPA ----------"
    # Partner.find_by_name('OPPA').update_attributes(active: true)
    # puts "-------- Perfumaria Época Cosméticos ----------"
    # Partner.find_by_name('Perfumaria Época Cosméticos').update_attributes(active: true)
    puts "-------- Polishop ----------"
    Partner.find_by_name('Polishop').update_attributes(active: true)
    puts "-------- Ponto Frio ----------"
    Partner.find_by_name('Ponto Frio').update_attributes(active: true)
    # puts "-------- SaveMe Cupons ----------"
    # Partner.find_by_name('SaveMe Cupons').update_attributes(active: true)
    # puts "-------- Shoebiz ----------"
    # Partner.find_by_name('Shoebiz').update_attributes(active: true)
    # puts "-------- Shopfato ----------"
    # Partner.find_by_name('Shopfato').update_attributes(active: true)
    # puts "-------- Shoptime ----------"
    # Partner.find_by_name('Shoptime').update_attributes(active: true)
    # puts "-------- Submarino ----------"
    # Partner.find_by_name('Submarino').update_attributes(active: true)
    # puts "-------- Submarino Viagens ----------"
    # Partner.find_by_name('Submarino Viagens').update_attributes(active: true)
    # puts "-------- Tam Passagens ----------"
    # Partner.find_by_name('Tam Passagens').update_attributes(active: true)
    # puts "-------- Tam Viagens ----------"
    # Partner.find_by_name('Tam Viagens').update_attributes(active: true)
    puts "-------- Toy Mania ----------"
    Partner.find_by_name('Toy Mania').update_attributes(active: true)
    # puts "-------- Tricae ----------"
    # Partner.find_by_name('Tricae').update_attributes(active: true)
    # puts "-------- UZ Games ----------"
    # Partner.find_by_name('UZ Games').update_attributes(active: true)
    # puts "-------- Viajar Barato ----------"
    # Partner.find_by_name('Viajar Barato').update_attributes(active: true)
    puts "-------- Walmart ----------"
    Partner.find_by_name('Walmart').update_attributes(active: true)
    puts '-------- Parceiros Ativados --------'
  end
end
