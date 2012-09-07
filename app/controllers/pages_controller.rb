#coding: UTF-8
class PagesController < ApplicationController

  def home
    @current_tab = 'home'
    deals = Deal.active
    @best_deals = deals.voted.best_deals.limit(3)
    @newest_deals = deals.recent.limit(3)
    @most_comment_deals = deals.most_commented.limit(3)
  
    @deals = Deal.paginate(:page => params[:page])
    @deals = @deals.active
  end

  def whoarewe
    @description = 'Saiba quem é a equipe que está por trás do Ofertus, e descubro como ele funciona.'
  end

  def help
    @description = 'Alguma dúvida sobre o Ofertus? Talvez você encontre a resposta para a sua dúvida aqui.'
  end

  def privacypolicy
    @description = 'Política de Privacidade do Ofertus'
  end

  def termsofuse
    @description = 'Termos de uso do Ofertus.'
  end

  def how_it_works
    @description = 'Descubra como o Ofertus funciona e como é fácil você compartilhar e ganhar comissão através das suas ofertas.'
  end
end
