# encoding: UTF-8
class LojasMm
  
  def self.fill_deal_fields(link)
    deal = Deal.new :link => link
    page = Share.open_page(link)

    deal.title = page.at_css(".titProduto").try(:text).try(:strip)[0,255] if page.at_css(".titProduto")
    deal.price_mask = page.at_css("#spanPrecoPor").try(:text).try(:strip).split(" ")[2].try(:strip) if page.at_css("#spanPrecoPor") && page.at_css("#spanPrecoPor").try(:text)
    deal.real_price_mask = page.at_css("#spanPreco").try(:text).try(:strip).split(" ")[2].try(:strip) if page.at_css("#spanPreco") && page.at_css("#spanPreco").try(:text)
    deal.description = page.at_css("#descricao").to_s.truncate(4000) if page.at_css("#descricao")
    # deal.category = CATEGORIES[page.at_css(".category").try(:text).try(:strip).sub(">","")] if page.at_css(".category")
    deal.image_url = page.at_css("#ProdutoImagemAux")["src"].try(:strip) if page.at_css("#ProdutoImagemAux")
    deal.company = "Lojas MM"
    deal.kind = Deal::KIND_OFFER

    deal
  end
end