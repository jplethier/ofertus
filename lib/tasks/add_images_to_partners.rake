#encoding: utf-8

namespace :db do

  desc "Fill database with first partners"

  task :add_images_to_partners => :environment do
    puts "-------- Adicionando logos dos parceiros -----------"
    puts "-------- Americanas ----------"
    Partner.find_by_name('Americanas').update_attributes(image_url: '/assets/partners/americanas.png', small_image_url: '/assets/partners/americanas_small.png', mini_image_url: '/assets/partners/americanas_mini.png')
    puts "-------- AmoMuito ----------"
    Partner.find_by_name('AmoMuito').update_attributes(image_url: '/assets/partners/amomuito.png', small_image_url: '/assets/partners/amomuito_small.png', mini_image_url: '/assets/partners/amomuito.png')
    puts "-------- Ana Hickmann ----------"
    Partner.find_by_name('Ana Hickmann').update_attributes(image_url: '/assets/partners/anahickmann.png', small_image_url: '/assets/partners/anahickmann_small.png', mini_image_url: '/assets/partners/anahickmann_mini.png')
    puts "-------- Apple Store ----------"
    Partner.find_by_name('Apple Store').update_attributes(image_url: '/assets/partners/applestore.png', small_image_url: '/assets/partners/applestore_small.png', mini_image_url: '/assets/partners/applestore_mini.png')
    puts "-------- Assine Abril ----------"
    Partner.find_by_name('Assine Abril').update_attributes(image_url: '/assets/partners/assineabril.png', small_image_url: '/assets/partners/assineabril_small.png', mini_image_url: '/assets/partners/assineabril_mini.png')
    puts "-------- Brandsclub ----------"
    Partner.find_by_name('Brandsclub').update_attributes(image_url: '/assets/partners/brandsclub.png', small_image_url: '/assets/partners/brandsclub_small.png', mini_image_url: '/assets/partners/brandsclub_mini.png')
    puts "-------- Brinquedos Laura ----------"
    Partner.find_by_name('Brinquedos Laura').update_attributes(image_url: '/assets/partners/americanas.png', small_image_url: '/assets/partners/americanas_small.png', mini_image_url: '/assets/partners/americanas_mini.png')
    puts "-------- ByTennis ----------"
    Partner.find_by_name('ByTennis').update_attributes(image_url: '/assets/partners/bytennis.png', small_image_url: '/assets/partners/bytennis_small.png', mini_image_url: '/assets/partners/bytennis_mini.png')
    puts "-------- Camiseteria ----------"
    Partner.find_by_name('Camiseteria').update_attributes(image_url: '/assets/partners/camiseteria.png', small_image_url: '/assets/partners/camiseteria_small.png', mini_image_url: '/assets/partners/camiseteria_mini.png')
    puts "-------- Carrefour ----------"
    Partner.find_by_name('Carrefour').update_attributes(image_url: '/assets/partners/carrefour.png', small_image_url: '/assets/partners/carrefour_small.png', mini_image_url: '/assets/partners/carrefour_mini.png')
    puts "-------- CarZ ----------"
    Partner.find_by_name('CarZ').update_attributes(image_url: '/assets/partners/carz.png', small_image_url: '/assets/partners/carz_small.png', mini_image_url: '/assets/partners/carz_mini.png')
    puts "-------- Casas Bahia ----------"
    Partner.find_by_name('Casas Bahia').update_attributes(image_url: '/assets/partners/casasbahia.png', small_image_url: '/assets/partners/casasbahia_small.png', mini_image_url: '/assets/partners/casasbahia_mini.png')
    puts "-------- Cd Point ----------"
    Partner.find_by_name('Cd Point').update_attributes(image_url: '/assets/partners/cdpoint.png', small_image_url: '/assets/partners/cdpoint_small.png', mini_image_url: '/assets/partners/cdpoint_mini.png')
    puts "-------- Cestas Michelli ----------"
    Partner.find_by_name('Cestas Michelli').update_attributes(image_url: '/assets/partners/cestasmichelli.png', small_image_url: '/assets/partners/cestasmichelli_small.png', mini_image_url: '/assets/partners/cestasmichelli_mini.png')
    puts "-------- Compra Fácil ----------"
    Partner.find_by_name('Compra Fácil').update_attributes(image_url: '/assets/partners/comprafacil.png', small_image_url: '/assets/partners/comprafacil_small.png', mini_image_url: '/assets/partners/comprafacil_mini.png')
    puts "-------- CVC ----------"
    Partner.find_by_name('CVC').update_attributes(image_url: '/assets/partners/cvc.png', small_image_url: '/assets/partners/cvc_small.png', mini_image_url: '/assets/partners/cvc_mini.png')
    puts "-------- CyberDiet ----------"
    Partner.find_by_name('CyberDiet').update_attributes(image_url: '/assets/partners/cyberdiet.png', small_image_url: '/assets/partners/cyberdiet_small.png', mini_image_url: '/assets/partners/cyberdiet_mini.png')
    puts "-------- Dafiti ----------"
    Partner.find_by_name('Dafiti').update_attributes(image_url: '/assets/partners/dafiti.png', small_image_url: '/assets/partners/dafiti_small.png', mini_image_url: '/assets/partners/dafiti_mini.png')
    puts "-------- Dell ----------"
    Partner.find_by_name('Dell').update_attributes(image_url: '/assets/partners/dell.png', small_image_url: '/assets/partners/dell_small.png', mini_image_url: '/assets/partners/dell_mini.png')
    puts "-------- Época Cosméticos ----------"
    Partner.find_by_name('Época Cosméticos').update_attributes(image_url: '/assets/partners/epocacosmeticos.png', small_image_url: '/assets/partners/epocacosmeticos_small.png', mini_image_url: '/assets/partners/epocacosmetivos_mini.png')
    puts "-------- Extra ----------"
    Partner.find_by_name('Extra').update_attributes(image_url: '/assets/partners/extra.png', small_image_url: '/assets/partners/extra_small.png', mini_image_url: '/assets/partners/extra_mini.png')
    puts "-------- Fnac ----------"
    Partner.find_by_name('Fnac').update_attributes(image_url: '/assets/partners/fnac.png', small_image_url: '/assets/partners/fnac_small.png', mini_image_url: '/assets/partners/fnac_mini.png')
    puts "-------- Gimba ----------"
    Partner.find_by_name('Gimba').update_attributes(image_url: '/assets/partners/gimba.png', small_image_url: '/assets/partners/gimba_small.png', mini_image_url: '/assets/partners/gimba_mini.png')
    puts "-------- Girafa ----------"
    Partner.find_by_name('Girafa').update_attributes(image_url: '/assets/partners/girafa.png', small_image_url: '/assets/partners/girafa_small.png', mini_image_url: '/assets/partners/girafa_mini.png')
    puts "-------- Giuliana Flores ----------"
    Partner.find_by_name('Giuliana Flores').update_attributes(image_url: '/assets/partners/giulianaflores.png', small_image_url: '/assets/partners/giulianaflores_small.png', mini_image_url: '/assets/partners/giulianaflores_mini.png')
    puts "-------- Grubster ----------"
    Partner.find_by_name('Grubster').update_attributes(image_url: '/assets/partners/grubster.png', small_image_url: '/assets/partners/grubster_small.png', mini_image_url: '/assets/partners/grubster_mini.png')
    puts "-------- Hopi Hari ----------"
    Partner.find_by_name('Hopi Hari').update_attributes(image_url: '/assets/partners/hopihari.png', small_image_url: '/assets/partners/hopihari_small.png', mini_image_url: '/assets/partners/hopihari_mini.png')
    puts "-------- Kanui ----------"
    Partner.find_by_name('Kanui').update_attributes(image_url: '/assets/partners/kanui.png', small_image_url: '/assets/partners/kanui_small.png', mini_image_url: '/assets/partners/kanui_mini.png')
    puts "-------- Livraria da Folha ----------"
    Partner.find_by_name('Livraria da Folha').update_attributes(image_url: '/assets/partners/livrariadafolha.png', small_image_url: '/assets/partners/livrariadafolha_small.png', mini_image_url: '/assets/partners/livrariadafolha_mini.png')
    puts "-------- Livraria Saraiva ----------"
    Partner.find_by_name('Livraria Saraiva').update_attributes(image_url: '/assets/partners/livrariasaraiva.png', small_image_url: '/assets/partners/livrariasaraiva_small.png', mini_image_url: '/assets/partners/livrariasaraiva_mini.png')
    puts "-------- Lojas KD ----------"
    Partner.find_by_name('Lojas KD').update_attributes(image_url: '/assets/partners/lojaskd.png', small_image_url: '/assets/partners/lojaskd_small.png', mini_image_url: '/assets/partners/lojaskd_mini.png')
    puts "-------- Lojas MM ----------"
    Partner.find_by_name('Lojas MM').update_attributes(image_url: '/assets/partners/lojasmm.png', small_image_url: '/assets/partners/lojasmm_small.png', mini_image_url: '/assets/partners/lojasmm_mini.png')
    puts "-------- Marisa ----------"
    Partner.find_by_name('Marisa').update_attributes(image_url: '/assets/partners/marisa.png', small_image_url: '/assets/partners/marisa_small.png', mini_image_url: '/assets/partners/marisa_mini.png')
    puts "-------- Martins Fontes ----------"
    Partner.find_by_name('Martins Fontes').update_attributes(image_url: '/assets/partners/martinsfontes.png', small_image_url: '/assets/partners/martinsfontes_small.png', mini_image_url: '/assets/partners/martinsfontes_mini.png')
    puts "-------- Mobly ----------"
    Partner.find_by_name('Mobly').update_attributes(image_url: '/assets/partners/mobly.png', small_image_url: '/assets/partners/mobly_small.png', mini_image_url: '/assets/partners/mobly_mini.png')
    puts "-------- Netshoes ----------"
    Partner.find_by_name('Netshoes').update_attributes(image_url: '/assets/partners/netshoes.png', small_image_url: '/assets/partners/netshoes_small.png', mini_image_url: '/assets/partners/netshoes_mini.png')
    puts "-------- Nova Flor ----------"
    Partner.find_by_name('Nova Flor').update_attributes(image_url: '/assets/partners/novaflor.png', small_image_url: '/assets/partners/novaflor_small.png', mini_image_url: '/assets/partners/novaflor_mini.png')
    puts "-------- Ofertas Tam Compra Coletiva ----------"
    Partner.find_by_name('Ofertas Tam Compra Coletiva').update_attributes(image_url: '/assets/partners/ofertastamcompracoletiva.png', small_image_url: '/assets/partners/ofertastamcompracoletiva_small.png', mini_image_url: '/assets/partners/ofertastamcompracoletiva_mini.png')
    puts "-------- OPPA ----------"
    Partner.find_by_name('OPPA').update_attributes(image_url: '/assets/partners/oppa.png', small_image_url: '/assets/partners/oppa_small.png', mini_image_url: '/assets/partners/oppa_mini.png')
    puts "-------- Perfumaria Época Cosméticos ----------"
    Partner.find_by_name('Perfumaria Época Cosméticos').update_attributes(image_url: '/assets/partners/perfumariaepocacosmeticos.png', small_image_url: '/assets/partners/perfumariaepocacosmeticos_small.png', mini_image_url: '/assets/partners/perfumariaepocacosmeticos_mini.png')
    puts "-------- Polishop ----------"
    Partner.find_by_name('Polishop').update_attributes(image_url: '/assets/partners/polishop.png', small_image_url: '/assets/partners/polishop_small.png', mini_image_url: '/assets/partners/polishop_mini.png')
    puts "-------- Ponto Frio ----------"
    Partner.find_by_name('Ponto Frio').update_attributes(image_url: '/assets/partners/pontofrio.png', small_image_url: '/assets/partners/pontofrio_small.png', mini_image_url: '/assets/partners/pontofrio_mini.png')
    puts "-------- SaveMe Cupons ----------"
    Partner.find_by_name('SaveMe Cupons').update_attributes(image_url: '/assets/partners/savemecupons.png', small_image_url: '/assets/partners/savemecupons_small.png', mini_image_url: '/assets/partners/savemecupons_mini.png')
    puts "-------- Shoebiz ----------"
    Partner.find_by_name('Shoebiz').update_attributes(image_url: '/assets/partners/shoebiz.png', small_image_url: '/assets/partners/shoebiz_small.png', mini_image_url: '/assets/partners/shoebiz_mini.png')
    puts "-------- Shopfato ----------"
    Partner.find_by_name('Shopfato').update_attributes(image_url: '/assets/partners/shopfato.png', small_image_url: '/assets/partners/shopfato_small.png', mini_image_url: '/assets/partners/shopfato_mini.png')
    puts "-------- Shoptime ----------"
    Partner.find_by_name('Shoptime').update_attributes(image_url: '/assets/partners/shoptime.png', small_image_url: '/assets/partners/shoptime_small.png', mini_image_url: '/assets/partners/shoptime_mini.png')
    puts "-------- Submarino ----------"
    Partner.find_by_name('Submarino').update_attributes(image_url: '/assets/partners/submarino.png', small_image_url: '/assets/partners/submarino_small.png', mini_image_url: '/assets/partners/submarino_mini.png')
    puts "-------- Submarino Viagens ----------"
    Partner.find_by_name('Submarino Viagens').update_attributes(image_url: '/assets/partners/submarinoviagens.png', small_image_url: '/assets/partners/submarinoviagens_small.png', mini_image_url: '/assets/partners/submarinoviagens_mini.png')
    puts "-------- Tam Passagens ----------"
    Partner.find_by_name('Tam Passagens').update_attributes(image_url: '/assets/partners/tampassagens.png', small_image_url: '/assets/partners/tampassagens_small.png', mini_image_url: '/assets/partners/tampassagens_mini.png')
    puts "-------- Tam Viagens ----------"
    Partner.find_by_name('Tam Viagens').update_attributes(image_url: '/assets/partners/tamviagens.png', small_image_url: '/assets/partners/tamviagens_small.png', mini_image_url: '/assets/partners/tamviagens_mini.png')
    puts "-------- Toy Mania ----------"
    Partner.find_by_name('Toy Mania').update_attributes(image_url: '/assets/partners/toymania.png', small_image_url: '/assets/partners/toymania_small.png', mini_image_url: '/assets/partners/toymania_mini.png')
    puts "-------- Tricae ----------"
    Partner.find_by_name('Tricae').update_attributes(image_url: '/assets/partners/tricae.png', small_image_url: '/assets/partners/tricae_small.png', mini_image_url: '/assets/partners/tricae_mini.png')
    puts "-------- UZ Games ----------"
    Partner.find_by_name('UZ Games').update_attributes(image_url: '/assets/partners/uzgames.png', small_image_url: '/assets/partners/uzgames_small.png', mini_image_url: '/assets/partners/uzgames_mini.png')
    puts "-------- Viajar Barato ----------"
    Partner.find_by_name('Viajar Barato').update_attributes(image_url: '/assets/partners/viajarbarato.png', small_image_url: '/assets/partners/viajarbarato_small.png', mini_image_url: '/assets/partners/viajarbarato_mini.png')
    puts "-------- Walmart ----------"
    Partner.find_by_name('Walmart').update_attributes(image_url: '/assets/partners/walmart.png', small_image_url: '/assets/partners/walmart_small.png', mini_image_url: '/assets/partners/walmart_mini.png')
    puts '-------- Logos adicionados --------'
  end
end
