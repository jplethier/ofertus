class Gimba
  def self.fill_deal_fields(link)
    page = Share.open_page(link)

    deal = Deal.new
    unless page.nil?
      deal.title = page.at_css("h1 .produto-nome").try(:text).try(:strip)[0,255] if page.at_css("h1 .produto-nome")
      deal.real_price_mask = page.at_css('.produto-opcoes-linha1 .produto-precos p span.preco_de').try(:text).split('R$')[1].try(:strip) if page.at_css('.produto-opcoes-linha1 .produto-precos p span.preco_de').try(:text)
      deal.price_mask = page.xpath("//div[@class='produto-opcoes-linha1']//div[@class='produto-precos']//p//span[contains(@class, 'red')]")[1].try(:text).try(:strip) if page.xpath("//div[@class='produto-opcoes-linha1']//div[@class='produto-precos']//p//span[contains(@class, 'red')]") && page.xpath("//div[@class='produto-opcoes-linha1']//div[@class='produto-precos']//p//span[contains(@class, 'red')]")[1].try(:text)

      deal.description = page.at_css(".produto-detalhe-container").try(:text).try(:strip) if page.at_css(".produto-detalhe-container")
      deal.image_url = "http://www.gimba.com.br/" + page.at_css("#zoom1 img")["src"].try(:strip) if page.at_css("#zoom1 img")
      # deal.category = Deal::CATEGORY_TRAVEL
    end
    deal.link = link.to_s.gsub('%25','%')
    deal.company = "Gimba"

    deal
  end
end