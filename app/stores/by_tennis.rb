# encoding: UTF-8
class ByTennis
  def self.fill_deal_fields(link)
    # page = Share.open_page(link)
    request = HTTPI::Request.new
    request.url = link
    body = HTTPI.get(request).body
    page = Nokogiri::HTML(body.html_safe)

    deal = Deal.new

    unless page.nil?
      deal.link = link
      infos = page.at_css('.produto-item script').to_s
      i = 0
      img_ready = false
      infos.split(',').each do |info|
        if info.match('nome') && !info.split(':').blank? && info.split(':')[1]
          deal.title = info.split(':')[1].gsub('"','') if deal.title.blank?
          deal.description = info.split(':')[1].gsub('"','') if deal.description.blank?
        elsif info.match('preco') && !info.split(':').blank? && info.split(':').last && deal.real_price_mask.blank?
          deal.real_price_mask = info.split(':').last.gsub('"','') + ','
          if infos.split(',')[i+1].gsub('"','').size == 2
            deal.real_price_mask = deal.real_price_mask + infos.split(',')[i+1].gsub('"','')
          else
            deal.real_price_mask = deal.real_price_mask + '00'
          end
        elsif info.match('atual') && !info.split(':').blank? && info.split(':').last && deal.price_mask.blank?
          deal.price_mask = info.split(':').last.gsub('"','') + ','
          if infos.split(',')[i+1].gsub('"', '').size == 2
            deal.price_mask = deal.price_mask + infos.split(',')[i+1].gsub('"','')
          else
            deal.price_mask = deal.price_mask + '00'
          end
        elsif info.match('imagem') && !img_ready && !info.split(':').blank?
          deal.image_url = info.split(':')[info.split(':').size-2].to_s.gsub('"','') + ':' + info.split(':').last.to_s.gsub('"','')
        elsif info.match('dimensao') && info.match('principal') && !img_ready && !info.split(':').blank?
          deal.image_url = deal.image_url + info.split(':').last.to_s + 'x' + info.split(':').last.to_s + '/'
        elsif info.match('imagens') && !img_ready && !info.split(':').blank?
          deal.image_url = deal.image_url + info.split(':').last.gsub('"','').gsub('[','')
          img_ready = true
        end
        i = i + 1
      end
    end
    deal.category = Deal::CATEGORY_CLOTHES
    deal.company = "ByTennis"

    partner = Partner.find_by_name('ByTennis')
    unless partner.blank?
      deal.partner = partner
    end

    deal
  end
end