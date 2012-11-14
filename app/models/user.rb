class User < ActiveRecord::Base
  include  Gravtastic

  make_voter

  devise :confirmable, :database_authenticatable, :omniauthable, :recoverable, :registerable, :rememberable, :trackable, :validatable
  gravtastic :size => 150, :default => "mm"
  has_paper_trail

  has_and_belongs_to_many :cities
  has_many :deals,                  :order => "deals.created_at DESC"
  has_many :relationships,          :foreign_key => "follower_id"
  has_many :followers,              :through => :reverse_relationships, :source => :follower
  has_many :following,              :through => :relationships,         :source => :followed
  has_many :reverse_relationships,  :foreign_key => "followed_id",      :class_name => "Relationship"
  has_many :sales
  has_many :powers
  has_many :notifications

  validates :username,  :presence => true,  :uniqueness => true,  :format => /^[a-zA-Z0-9_]{5,20}$/
  validates :credit,    :presence => true

  attr_accessible :access_token, :avatar_url, :credit, :facebook_follow_user, :facebook_vote_offer, :facebook_share_offer, :email, :login, :name, :password, :password_confirmation, :provider, :remember_me, :uid, :username, :invited_by_id

  before_validation :set_credit_to_zero

  belongs_to :invited_by, :class_name => 'User'
  has_many :inviteds, :class_name => 'User', :foreign_key => :invited_by_id

  scope :more_deals,        order("(select count(deals.id) from deals where deals.user_id = users.id) DESC")
  scope :more_active,       order("(select count(deals.id) from deals where deals.user_id = users.id) + (select count(comments.id) from comments where comments.user_id = users.id) + (select count(votings.id) from votings where votings.voter_id = users.id) DESC")
  scope :more_popular,      order('(select count(relationships.id) from relationships where relationships.followed_id = users.id) DESC')
  scope :random,            order('RANDOM()')
  scope :facebook_users,    where(:provider => "facebook")
  scope :admin_users,       where(:admin => true)
  scope :month_points_rank, where('1 = 1')
  scope :more_points,       where('1 = 1')

  # Virtual attribute for authenticating by either username or email
  attr_accessor :login

  def set_credit_to_zero
    self.credit = 0 if not credit
  end

  def recalculate_credit
    new_credit = 0
    self.sales.each do |sale|
      case sale.status
      when Sale::CONFIRMED
        new_credit = new_credit + sale.user_commission_value
      when Sale::WITHDRAW
        new_credit = new_credit - sale.user_commission_value
      end
    end
    self.update_attributes(credit: new_credit)
  end

  def guest?
    self.new_record?
  end

  def following_ids
    friends = []
    self.following.each do |friend|
      friends << friend.id
    end
    friends
  end

  def set_invited_by(username)
    self.invited_by = User.find_by_username(username)
    self.save
  end

  def self.check_inviteds_quantity(username)
    who_invites = User.find_by_username(username)
    case who_invites.inviteds.count
    when 1
      Power.create(user: who_invites, quantity: 1, status: Power::AVAILABLE)
    when 5
      Power.create(user: who_invites, quantity: 2, status: Power::AVAILABLE)
    when 10
      Power.create(user: who_invites, quantity: 3, status: Power::AVAILABLE)
    when 20
      Power.create(user: who_invites, quantity: 4, status: Power::AVAILABLE)
    when 30
      Power.create(user: who_invites, quantity: 5, status: Power::AVAILABLE)
    when 50
      Power.create(user: who_invites, quantity: 6, status: Power::AVAILABLE)
    when 75
      Power.create(user: who_invites, quantity: 7, status: Power::AVAILABLE)
    when 100
      Power.create(user: who_invites, quantity: 8, status: Power::AVAILABLE)
    when 150
      Power.create(user: who_invites, quantity: 9, status: Power::AVAILABLE)
    when 200
      Power.create(user: who_invites, quantity: 20, status: Power::AVAILABLE)
    end
  end

  def picture
    if self.provider
      self.facebook_profile_picture
    else
      self.gravatar_url
    end 
  end

  def medium_picture
    if self.provider
      self.facebook_profile_picture(:normal)
    else
      self.gravatar_url(size: 100)
    end
  end

  def small_picture
    if self.provider
      self.facebook_profile_picture(:small)
    else
      self.gravatar_url(size: 50)
    end
  end

  def total_powers
    total = 0
    self.powers.each do |p|
      case p.status
      when Power::AVAILABLE
        total = total + p.quantity
      when Power::WITHDRAW
        total = total - p.quantity
      end
    end
    total
  end

  def follow!(another_user)
    relationships.create! :followed_id => another_user.id
  end

  def unfollow!(another_user)
    relationships.find_by_followed_id(another_user.id).destroy
  end

  def follow?(another_user)
    relationships.exists? :followed_id => another_user.id
  end

  def facebook_profile_picture(size = "large")
    begin
      FbGraph::User.fetch(uid).picture(size)
    rescue Exception
      nil
    end
  end

  def self.by_username(username)
    User.find_by_username(username)
  end

  def self.search(search)
    where("users.name ILIKE :search OR users.username ILIKE :search", :search => "%#{search}%")
  end

  def self.find_for_facebook_oauth(access_token, signed_in_resource=nil)
    data = access_token.info
    if user = User.find_by_email(data.email)
      user.update_attributes!(:name => data.name, :avatar_url => data.image, :access_token => access_token.credentials.token)
      user
    end
  end

  def self.apply_omniauth(data)
    user_info = data.info
    User.new(:email => user_info.email, :name => user_info.name, :username => user_info.nickname, :provider => "facebook", :uid => data.uid, :avatar_url => user_info.image, :confirmed_at => Date.today, :access_token => data.credentials.token)
  end

  #TODO: testar e consertar
  def password_required?
    (provider.nil? || !password.blank?) && super
  end

  #TODO: testar
  def email_required?
    provider.nil?
  end

  def admin?
    self.admin
  end

  def wishes
    deals_wishes = []
    self.votings.each do |vote|
      deals_wishes << vote.voteable if vote.up_vote? && vote.voteable
    end
    deals_wishes
  end
  
  protected

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    login = conditions.delete(:login)
    where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
  end

  # Attempt to find a user by it's email. If a record is found, send new
  # password instructions to it. If not user is found, returns a new user
  # with an email not found error.
  def self.send_reset_password_instructions(attributes={})
    recoverable = find_recoverable_or_initialize_with_errors(reset_password_keys, attributes, :not_found)
    recoverable.send_reset_password_instructions if recoverable.persisted?
    recoverable
  end

  def self.find_recoverable_or_initialize_with_errors(required_attributes, attributes, error=:invalid)
    (case_insensitive_keys || []).each { |k| attributes[k].try(:downcase!) }

    attributes = attributes.slice(*required_attributes)
    attributes.delete_if { |key, value| value.blank? }

    if attributes.size == required_attributes.size
      if attributes.has_key?(:login)
        login = attributes.delete(:login)
        record = find_record(login)
      else
        record = where(attributes).first
      end
    end

    unless record
      record = new

      required_attributes.each do |key|
        value = attributes[key]
        record.send("#{key}=", value)
        record.errors.add(key, value.present? ? error : :blank)
      end
    end

    record
  end

  def self.find_record(login)
    where(["username = :value OR email = :value", { :value => login }]).first
  end
end
