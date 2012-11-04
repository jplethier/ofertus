# coding: UTF-8
class DealsController < AuthorizedController
  skip_before_filter :authenticate_user!, :only => [:index, :show, :feed]
  prepend_before_filter :find_deals, :only => [:index]
  before_filter :define_title, :only => :show
  before_filter :populate_cities_name, :only => [:new, :share]

  def index
    if params[:search]
      @message = "Não foi encontrada nenhuma oferta com '#{params[:search]}'" if @deals.empty? && !(params[:search].blank?) && params[:search_city].blank?
      @message = "Não foi encontrada nenhuma oferta para a cidade selecionada" if @deals.empty? && params[:search].empty? && !params[:search_city].blank?
      @message = "Não foi encontrada nenhuma oferta para a cidade selecionada com '#{params[:search]}'" if @deals.empty? && !params[:search_city].blank? && !params[:search].blank?
    else
      @message = 'Não há ofertas ativas'
    end
    # if params[:category]
    #   @title = Deal.i18n_category(Deal::CATEGORIES_DICTIONARY[params[:category]]).to_s
    #   @description = Deal.i18n_category(Deal::CATEGORIES_DICTIONARY[params[:category]])
    # end
  end

  def new
  end

  def create
    @deal.user = current_user
    @deal.original_link = @deal.link
    if @deal.already_shared?
      if @deal.link.match('ofertus.com.br')
        redirect_to @deal.link, :alert => "A oferta abaixo já foi compartilhada por outro usuário"
      else
        @deal = Deal.find_by_original_link(@deal.original_link) || @deal.find_by_original_link(@deal.original_link.split('?')[0])
        redirect_to deal_path(@deal), :alert => "A oferta abaixo já foi compartilhada por outro usuário"
      end
    else
      if @deal.save
        if current_user.provider? && current_user.facebook_share_offer && FbGraph::User.me(current_user.access_token).permissions.include?(:status_update)
          me = FbGraph::User.me(current_user.access_token)
          me.feed!( :message => current_user.name + " acabou de compartilhar uma oferta no Ofertus", :link => deal_url(@deal), :description => @deal.string_description, :picture => (@deal.image_url ? @deal.image_url : "http://www.ofertus.com.br/assets/logo_beta.png") )
        end
        redirect_to deals_path, :notice => "Oferta criada com sucesso!"
      else
        populate_cities_name

        flash.now[:error] = "Foram encontrados erros ao criar a oferta."
        render :new
      end
    end
  end

  def show
    @comment = Comment.new
    @title = @deal.title
    @description = @deal.title + ' - ' + Deal.i18n_category(@deal.category)
    @deal.update_visit_count if @deal.user != current_user
  end

  def share
    @deal = Deal.new
    @deal.original_link = params[:share]
    if @deal.already_shared?
      if @deal.original_link.match('ofertus.com.br')
        redirect_to @deal.original_link, :alert => "A oferta abaixo já foi compartilhada por outro usuário"
      else
        @deal = Deal.find_by_original_link(@deal.original_link) || @deal.find_by_original_link(@deal.original_link.split('?')[0])
        redirect_to deal_path(@deal), :alert => "A oferta abaixo já foi compartilhada por outro usuário"
      end
    else
      @deal = Share.create_deal params[:share]

      render :new
    end
  rescue Errno::ETIMEDOUT
    flash.now[:alert] = "Não foi possível ler as informações da oferta no site indicado."
    @deal = Deal.new :link => params[:share]
    render :new
  end

  def unvote
    current_user.unvote!(@deal)
    redirect_to deal_path(@deal), :notice => "Voto apagado com sucesso!"
  end

  def upvote
    if current_user.up_vote(@deal)
      if current_user.provider? && current_user.facebook_vote_offer && FbGraph::User.me(current_user.access_token).permissions.include?(:status_update)
        me = FbGraph::User.me(current_user.access_token)
        me.feed!(:message => current_user.name + " adorou uma oferta no Ofertus", :link => deal_url(@deal), :description => @deal.string_description, :picture => ( @deal.image_url ? @deal.image_url : "http://www.ofertus.com.br/assets/logo_beta.png"))
      end
      redirect_to deal_path(@deal), :notice => "Oferta adorada com sucesso."
    else
      redirect_to deal_path(@deal), :error => "Desculpe, ocorreu um erro ao tentar adorar a oferta, nos comunique para que possamos corrigir."
    end
  rescue MakeVoteable::Exceptions::AlreadyVotedError
    redirect_to deal_path(@deal), :error => "Oferta já adorada."
  end

  def downvote
    if current_user.down_vote(@deal)
      if current_user.provider? && current_user.facebook_vote_offer && FbGraph::User.me(current_user.access_token).permissions.include?(:status_update)
        me = FbGraph::User.me(current_user.access_token)
        me.feed!(:message => current_user.name + " denunciou uma oferta no Ofertus", :link => deal_url(@deal), :description => @deal.string_description, :picture => ( @deal.image_url ? @deal.image_url : "http://www.ofertus.com.br/assets/logo_beta.png"))
      end
      redirect_to deal_path(@deal), :notice => "Oferta denunciada com sucesso."
    else
      redirect_to deal_path(@deal), :error => "Desculpe, ocorreu um erro ao tentar denunciar a oferta, nos comunique para que possamor corrigir."
    end
  rescue MakeVoteable::Exceptions::AlreadyVotedError
    redirect_to deal_path(@deal), :error => "Oferta já denunciada."
  end

  def feed
    # this will be the name of the feed displayed on the feed reader
    @title = "Ofertas Ativas"

    # the news items
    @news_items = Deal.active

    # this will be our Feed's update timestamp
    # @updated = @news_items.first.updated_at unless @news_items.empty?

    respond_to do |format|
      format.atom { render :layout => false }

      # we want the RSS feed to redirect permanently to the ATOM feed
      format.rss { render :layout => false }
    end
  end

  private

  def find_deals
    @deals = Deal.paginate(:page => params[:page], :per_page => 12)
    @deals = @deals.send(params[:search_scope].to_sym) if params[:search_scope]
    @deals = @deals.by_category_string(params[:category]) if params[:category]
    @deals = @deals.search(params[:search]) unless params[:search].blank?
    @deals = @deals.by_cities(params[:search_city]) unless params[:search_city].blank?
    @deals = @deals.by_price_range(params[:price_range].split('-')[0].gsub('R$','').to_i, params[:price_range].split('-')[1].gsub('R$','').to_i) if params[:price_range]
    @deals = @deals.send(params[:search_order]) if params[:search_order]
    @deals = @deals.active
  end

  def populate_cities_name
    @cities_state_hash = City.hash_by_states
    @cities_name = City.order_by_state#.collect { |c| [c.name, c.id] }
  end

  def search_order(scope, params)
    case params[:search_order]
    when "most_recent"
      scope.recent
    when "lowest_price"
      scope.lowest_price
    when "highest_price"
      scope.highest_price
    when "highest_discount"
      scope.highest_discount
    else
      scope.recent
    end
  end

  def define_title
    @title = @deal.title
    @description = @deal.title
  end

  def fill_in_old_deals
    @old_deals = Deal.inactive
    @old_deals = search_order(@old_deals, params)
    @old_deals = @old_deals.by_category_string(params[:category]) if params[:category]
    @old_deals = @old_deals.search(params[:search]) if params[:search]
    @old_deals = @old_deals.by_cities(params[:search_city]) if params[:search_city] && not(params[:search_city].empty?)
    @old_deals = @old_deals.limit(3)
  end
end
