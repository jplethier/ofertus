# coding: utf-8
class Deal < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, use: :slugged

  acts_as_commentable

  make_voteable

  has_paper_trail

  self.per_page = 10

  DEFAULT_IMAGE = 'http://localhost:3000/deal_with_no_image.png'

  CATEGORY_RESTAURANT = 1
  CATEGORY_BEAUTY_AND_HEALTH = 2
  CATEGORY_CULTURE = 3
  CATEGORY_HOME_AND_APPLIANCE = 4
  CATEGORY_COMPUTER = 5
  CATEGORY_CLOTHES = 6
  CATEGORY_TRAVEL = 7
  CATEGORY_CAR = 8
  CATEGORY_OTHER = 9
  CATEGORY_HOME_AND_DECORATION = 10
  CATEGORY_ENTERTAINMENT = 11

  CATEGORIES = [ CATEGORY_RESTAURANT, CATEGORY_BEAUTY_AND_HEALTH, CATEGORY_CULTURE,CATEGORY_HOME_AND_APPLIANCE, CATEGORY_COMPUTER, CATEGORY_CLOTHES, CATEGORY_TRAVEL,CATEGORY_CAR, CATEGORY_OTHER,CATEGORY_HOME_AND_DECORATION, CATEGORY_ENTERTAINMENT ]

  #Pra que esse dicionário?
  #TODO: refatorar para utilizar a tradução para buscar por id
  CATEGORIES_DICTIONARY = {"restaurant" => CATEGORY_RESTAURANT, "beauty_and_health" => CATEGORY_BEAUTY_AND_HEALTH, "culture" => CATEGORY_CULTURE, "home_and_appliance" => CATEGORY_HOME_AND_APPLIANCE, "computer" => CATEGORY_COMPUTER, "clothes" => CATEGORY_CLOTHES, "travel" => CATEGORY_TRAVEL, "car" => CATEGORY_CAR, "others" => CATEGORY_OTHER, "home_and_decoration" => CATEGORY_HOME_AND_DECORATION, "entertainment" => CATEGORY_ENTERTAINMENT}

  belongs_to :city
  belongs_to :user

  validates :category,        :presence => true,       :inclusion => CATEGORIES
  validates :company,         :presence => true
  validates :description,     :presence => true,       :length => { :maximum => 7000 }
  validates :end_date,        :presence => true,       :date => {:after_or_equal_to => Time.zone.now.beginning_of_day}, :if => 'self.new_record?'
  validates :image_url,       :format => /(^$)|(^https?:\/\/.+)/
  validates :link,            :presence => true,       :format => /^https?:\/\/.+/
  # validates :link,            :uniqueness => true,     :if => 'already_shared?'
  validates :price,           :numericality => true
  validates :real_price,      :numericality => true
  validates :real_price,      :greater_than => :price, :if => "self.price && self.real_price"

  validates :title,       :presence => true, :length => { :maximum => 255 }
  validates :city_id,     :presence => true
  validates :user,        :presence => true

  # VALIDAÇÕES PARA A MÁSCARA DE PREÇO
  validates :price_mask,  :presence => true, :if => 'self.new_record?'
  validates :real_price_mask,  :presence => true, :if => 'self.new_record?'

  after_validation :calculate_discount, :if => "real_price? and price?"
  before_validation :prices_to_number
  before_validation :set_national_offer, :if => "self.city_id.nil?"
  before_create :add_affiliate_code_to_link
  before_validation :set_default_date, :if => "self.end_date.nil?"

  attr_accessor :price_mask, :real_price_mask
  attr_accessible :address, :category, :city_id, :company, :description, :discount, :end_date, :image_url, :link, :price, :price_mask, :real_price, :real_price_mask, :title, :user_id, :ofertus_top, :visits, :give_power

  scope :recent, order("deals.created_at DESC")
  scope :lowest_price, order("deals.price ASC")
  scope :highest_price, order("deals.price DESC")
  scope :highest_discount, order("deals.discount DESC")
  scope :likes, order("deals.up_votes DESC")
  scope :most_commented, order("(select count(comments.id) from comments where comments.commentable_id = deals.id) DESC")
  scope :most_visited, order('visits DESC')
  scope :random, order('RANDOM()')

  scope :today,           where("deals.created_at >= ?", Time.zone.now.beginning_of_day)
  scope :end_today,       where("deals.end_date <= ?", Time.zone.now.end_of_day)
  scope :active,          where("deals.end_date >= ?", Time.zone.now.beginning_of_day)
  scope :voted,           where("(deals.up_votes + deals.down_votes) > 0")
  scope :inactive,        where("deals.end_date < ?", Time.zone.now.beginning_of_day)
  scope :top,             where(:ofertus_top => true)
  scope :by_user_ids,     lambda { |user_ids| where(user_id: user_ids) }
  scope :by_price_range,  lambda { |min, max| where('price >= ? and price <= ?', min, max) }

  def self.best_deals
    self.voted.order("(deals.up_votes / (deals.up_votes + deals.down_votes)) DESC, deals.up_votes DESC")
  end

  def who_likes
    who_likes = []
    self.votings.each do |vote|
      who_likes << vote.voter if vote.up_vote? && !vote.voter.blank?
    end
    who_likes
  end

  def user_provider?
    Rails.cache.fetch(['provider', self.user.id]) do
      self.user.provider?
    end
  end

  def string_description
    self.description.gsub(/<.*>/,'')
  end

  def update_visit_count
    if self.visits.blank?
      self.visits = 1
    else
      self.visits = self.visits + 1
    end
    self.save(:validate => false)
  end

  def check_likes_count
    if self.up_votes == 5 && !self.give_power
      Power.create(user: self.user, quantity: 1, status: Power::AVAILABLE)
      self.update_attributes(give_power: true)
    end
  end

  def similar_offers
    similar_offers = []
    who_likes.each do |user|
      user.votings.each do |vote|
        unless vote.voteable == self
          similar_offers << vote.voteable if vote.up_vote? && vote.voteable
        end
      end
    end
    similar_offers.uniq
  end

  def self.by_category(category)
    where(:category => category)
  end

  #TODO: refatorar para utilizar a tradução para buscar por id
  def self.by_category_string(category)
    where(:category => CATEGORIES_DICTIONARY[category])
  end

  def self.by_cities(cities_id)
    where(:city_id => cities_id)
  end

  def self.by_link(link)
    where(:link => link).first
  end

  def self.search(search)
    where("deals.title ILIKE :search OR deals.description ILIKE :search", :search => "%#{search}%")
  end

  def self.by_username_and_following(username)
    user_id = User.find_by_username(username).id
    users = [user_id] + Relationship.followed_ids(user_id)
    where(:user_id => users)
  end

  def self.i18n_category(category)
    I18n.t("models.deal.category.#{category}")
  end

  def self.i18n_categories
    Deal::CATEGORIES.collect {|id| [Deal.i18n_category(id), id]}
  end

  def already_shared?
    Deal.active.find_by_original_link(self.original_link) || self.original_link.match('ofertus.com.br') || Deal.active.find_by_link(self.original_link) || Deal.active.find_by_original_link(self.original_link.split('?')[0])
  end

  def average
    ((self.up_votes * 100)/self.votings.length).to_i if self.votings.length != 0
  end

  def get_image_url
    return self.image_url if self.image_url
    DEFAULT_IMAGE
  end

  def discount_to_percentage
    ((self.discount / self.real_price) * 100).to_i if self.real_price?
  end

  def calculate_discount
    (self.discount = ((self.real_price - self.price)/self.real_price * 100).to_i) if self.real_price?
  end

  def prices_to_number
    self.price = to_number(self.price_mask) if self.price_mask
    self.real_price = to_number(self.real_price_mask) if self.real_price_mask
  end

  def set_default_date
    self.end_date = Time.zone.now.beginning_of_day if self.end_date.nil?
  end

  def favourite!
    self.ofertus_top = true
    self.save(:validate => false)
  end

  def unfavourite!
    self.ofertus_top = false
    self.save(:validate => false)
  end

  def add_affiliate_code_to_link
    if self.link.match(Share::COMPRA_FACIL)
      self.link = self.link.strip + "&a_aid=OfertuSCF"
    elsif self.link.match(Share::LIVRARIA_CULTURA)
      self.link = add_cultura_affiliate_code(self.link)
    # || self.link.match(Share::CARREFOUR)
    elsif (self.link.match(Share::SARAIVA) || self.link.match(Share::APPLE) || self.link.match(Share::CAMISETERIA) || self.link.match(Share::DUKS) || self.link.match(Share::SEPHA) || self.link.match(Share::DAFITI) || self.link.match(Share::POLISHOP) || self.link.match(Share::GIRAFA) || self.link.match(Share::FNAC) || self.link.match(Share::AMERICANAS) || self.link.match(Share::GIULIANA_FLORES) || self.link.match(Share::DISANTINNI) || self.link.match(Share::LOJAS_MM) || self.link.match(Share::TOY_MANIA) || self.link.match(Share::MOBLY) || self.link.match(Share::ANA_HICKMANN) || self.link.match(Share::BRINQUEDOS_LAURA) || self.link.match(Share::KANUI) || self.link.match(Share::WALMART) || self.link.match(Share::BY_TENNIS) || self.link.match(Share::EXTRA) || self.link.match(Share::SUBMARINO) || self.link.match(Share::AMOMUITO) || self.link.match(Share::CASAS_BAHIA))
      self.link = lomadee_link(self.link) + "?mdasc=#{self.user.id}"
    end
  end

  def set_national_offer
    self.city_id = City.find_by_name('Oferta Nacional').id if self.city_id.nil?
  end

  private

  def to_number(mask)
    return mask.gsub(/[^\d]/,'').to_f/100
  end

  def add_cultura_affiliate_code(link)
    "http://www.livrariacultura.com.br/scripts/cultura/externo/index.asp?id_link=9151&tipo=25&nitem=#{link.split("?")[1].split("&")[0].split("=")[1]}"
  end

  def lomadee_link(link)
    agent = Mechanize.new
    agent.get("https://wwws.lomadee.com/appsfront/direto/create.html?applicationId=176&sourceName=ofertus_#{self.user.username}&siteId=33562998&siteName=&publisherId=22509651&campaignList=&locale=pt_BR&t=48566c6e5a3762306b35396e38784d796b657962704c59684f694f633136444c66346175497544535a56733d&dimensionId=-1&ga=UA-5739472-10&directLink=&advertiserId=&lomadeeCountryId=1&countryCode=BR")
   # form_login = agent.form_with
    form = agent.page.forms.first
    form.field_with(:name => 'sourceLinkadorVO.url').value = link
    form.submit
    lomadee_link = agent.page.search(".//textarea[@id='sourceGenerated']").text
    lomadee_link
  end
end
