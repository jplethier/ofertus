xml.instruct!
xml.rss "version" => "2.0", "xmlns:dc" => "http://purl.org/dc/elements/1.1/" do
  xml.channel do
    xml.title @title
    xml.description 'Ofertas Ativas'

    @deals.each do |deal|
      xml.item do
        xml.title deal.title
        xml.description deal.description.html_safe
        xml.link deal_url(deal)
      end
    end
  end
end
