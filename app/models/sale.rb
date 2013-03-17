# coding: utf-8
# == Schema Information
#
# Table name: sales
#
#  id                    :integer          not null, primary key
#  value                 :float
#  store                 :integer
#  affiliate             :string(255)
#  country               :string(255)
#  created_at            :datetime
#  updated_at            :datetime
#  affiliate_transaction :integer
#  user_id               :integer
#  commission            :float
#  user_commission       :float
#  status                :integer
#  partner_id            :integer
#  partner_code          :string(255)
#  id_pedido             :string(255)
#

class Sale < ActiveRecord::Base
  attr_protected :id
  has_paper_trail

  PENDING = 1
  BONUS = 2
  CONFIRMED = 3
  CANCELLED = 4
  WITHDRAW_PENDING = 5
  WITHDRAW = 6

  STATUS = [ PENDING, BONUS, CONFIRMED, CANCELLED, WITHDRAW ]

  belongs_to :user
  belongs_to :partner

  has_many :products

  validates :value, :numericality => true
  validates :commission, :presence => true
  validates :user_commission, :presence => true

  scope :pending,   where(status: 1)
  scope :bonus,     where(status: 2)
  scope :confirmed, where(status: 3)
  scope :cancelled, where(status: 4)
  scope :withdraw,  where(status: 5)

  scope :recent,      order("sales.created_at DESC")
  scope :this_month,  where("created_at >= ?", Date.today.to_time.beginning_of_month.beginning_of_day)

  #statistic scopes
  scope :today,     where("sales.created_at >= ?", Time.zone.now.beginning_of_day)
  scope :yesterday, where("sales.created_at >= ? and sales.created_at < ?", (Time.zone.now - 1.day).beginning_of_day, Time.zone.now.beginning_of_day)
  scope :by_month,  lambda { |date| where("sales.created_at >= ? and sales.created_at <= ?", date.beginning_of_month.beginning_of_day, date.end_of_month.end_of_day) }
  scope :by_year,   lambda { |date| where("sales.created_at >= ? and sales.created_at <= ?", date.beginning_of_year.beginning_of_day, date.end_of_year.end_of_day) }

  after_save :recalculate_user_credit

  def recalculate_user_credit
    if self.user
      user.recalculate_credit
    end
  end

  def self.calculate_total_value(sales, method)
    sum = 0
    sales.each do |s|
      sum = sum + s.send(method)
    end
    sum
  end

  # http://ofertus.com.br:3000/lomadee?id_pedido=ABC123&id_programa=4&pais=BR&mdasc=1&total=100.00&desc1=penDrive1GB&%20categoria1=1&qtde1=1&valor1=30.00&desc2=PenDrive2GB&%20categoria2=1&qtde2=1&valor2=70.00
  # params = { :controller_name => 'application', :action_name => 'lomadee', :id_pedido => '111', :id_programa => '4', :pais => 'BR', :mdasc => '1', :total => '110.11', :desc1 => 'descricao produto 1', :valor1 => '55.50', :desc2 => 'descricao produto 2', :valor2 => '54.61'}
  def self.register_lomadee(params)
    if params[:total].blank?
      Error.create(model_name: 'Vendas', message: "Parâmetro total não enviado")
      return { :error => 'Parâmetro total não enviado' }
    end
    sale = Sale.new
    sale.status = 1
    user = User.find_by_id(params[:mdasc])
    sale.user = user if user
    sale.value = params[:total]
    sale.partner_code = params[:id_programa]
    sale.id_pedido = params[:id_pedido]
    partner = Partner.find_by_code(params[:id_programa])
    if partner
      sale.partner = partner
      sale.commission = partner.commission
      if partner.promotion
        sale.user_commission = partner.promotion_commission
      else
        sale.user_commission = partner.user_commission
      end
      # SOMENTE PARA A BLACK FRIDAY
      # sale.user_commission = partner.user_commission * 2
    else
      sale.commission = 0
      sale.user_commission = 0
    end
    for i in (1..(params.size/4))
      puts 'falta setar os produtos'
    end
    sale.save
    sale
  end

  def commission_value
    (self.value/100)*self.commission
  end

  def user_commission_value
    (self.value/100)*self.user_commission
  end

  def self.i18n_status(status)
    I18n.t("models.sale.status.#{status}")
  end

  def partner_name
    return self.partner.name if self.partner
    '-'
  end
end
