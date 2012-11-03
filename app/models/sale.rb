# coding: utf-8
class Sale < ActiveRecord::Base
  attr_protected :id
  has_paper_trail

  PENDING = 1
  BONUS = 2
  CONFIRMED = 3
  CANCELLED = 4
  WITHDRAW = 5
  
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

  scope :recent,    order("sales.created_at DESC")

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
    partner = Partner.find_by_code(params[:id_programa])
    if partner
      sale.partner = partner
      sale.commission = partner.commission
      sale.user_commission = partner.user_commission
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