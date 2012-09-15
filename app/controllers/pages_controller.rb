#coding: UTF-8
class PagesController < ApplicationController

  def home
    @current_tab = 'home'
    @deals = Deal.active.top.limit(6)
    @users = User.random.limit(3)
  end

  def show_video
    render :layout => false
  end

  def whoarewe
    @description = 'Saiba quem é a equipe que está por trás do Ofertus, e descubro como ele funciona.'
  end

  def help
    @description = 'Alguma dúvida sobre o Ofertus? Talvez você encontre a resposta para a sua dúvida aqui.'
  end

  def privacypolicy
    @description = 'Política de Privacidade do Ofertus. Saiba como o Ofertus cuida dos dados dos seus usuários.'
  end

  def termsofuse
    @description = 'Todos os usuários do Ofertus concordam com os Termos de Uso aqui dispostos.'
  end

  def how_it_works
    @description = 'Descubra como o Ofertus funciona e como é fácil você compartilhar e ganhar comissão através das suas ofertas.'
  end
end
