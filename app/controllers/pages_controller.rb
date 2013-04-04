#coding: UTF-8
class PagesController < ApplicationController

  def home
    @current_tab = 'home'
    Rails.cache.fetch("top_deals_#{Date.today.day}_#{Date.today.month}_#{Date.today.year}", expires_in: 1.hour) do
      Deal.active.top.limit(6).includes(:user).includes(:partner).select('deal.*, users.*, partners.name as partner_name, partners.mini_image_url as partner_mini_image_url, partners.id as partner_id').all
    end
    @top_deals = Rails.cache.read("top_deals_#{Date.today.day}_#{Date.today.month}_#{Date.today.year}")
    @best_deals = Deal.active.likes.where('up_votes > 0').limit(8).includes(:user).includes(:partner)
    @recent_deals = Deal.active.recent.limit(8).includes(:user).includes(:partner)
    @users = User.has_deals.random.limit(3)
  end

  def subscribe_to_newsletter
    if params[:subscribe_to_newsletter].blank? || params[:subscribe_to_newsletter][:email].blank?
      flash[:error] = "Informe um email para assinar a newsletter."
    else
      mc_api = Mailchimp::API
      mc_api.list_subscribe(id: 'b17830ec2c', email_address: params[:subscribe_to_newsletter][:email])
      flash[:notice] = 'Foi enviado um email para confirmação da assinatura da newsletter.'
    end
    redirect_to root_path
  end

  def show_video
    render :layout => false
  end

  def bank_codes
    render layout: false
  end

  def powers_popup
    render :layout => false
  end

  def natal
    render :layout => false
  end

  def whoarewe
    @title = 'Quem somos'
    @description = 'Saiba quem é a equipe que está por trás do Ofertus, e descubro como ele funciona.'
  end

  def help
    @title = 'Ajuda/FAQ'
    @description = 'Alguma dúvida sobre o Ofertus? Talvez você encontre a resposta para a sua dúvida aqui.'
  end

  def privacypolicy
    @title = 'Política de Privacidade'
    @description = 'Política de Privacidade do Ofertus. Saiba como o Ofertus cuida dos dados dos seus usuários.'
  end

  def termsofuse
    @title = 'Termos de Uso'
    @description = 'Todos os usuários do Ofertus concordam com os Termos de Uso aqui dispostos.'
  end

  def how_it_works
    @title = 'Como funciona'
    @description = 'Descubra como o Ofertus funciona e como é fácil você compartilhar e ganhar comissão através das suas ofertas.'
  end

  def partners

  end
end
