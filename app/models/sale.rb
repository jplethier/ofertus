# coding: utf-8
class Sale < ActiveRecord::Base
  attr_protected :id
  has_paper_trail

  belongs_to :user

  has_many :products

  validates :value, :numericality => true
  validates :commission, :presence => true
  validates :user_commission, :presence => true

  # http://ofertus.com.br:3000/lomadee?id_pedido=ABC123&id_programa=4&pais=BR&mdasc=1&total=100.00&desc1=penDrive1GB&%20categoria1=1&qtde1=1&valor1=30.00&desc2=PenDrive2GB&%20categoria2=1&qtde2=1&valor2=70.00
  # params = { :controller_name => 'application', :action_name => 'lomadee', :id_pedido => '111', :id_programa => '4', :pais => 'BR', :mdasc => '1', :total => '110.11', :desc1 => 'descricao produto 1', :valor1 => '55.50', :desc2 => 'descricao produto 2', :valor2 => '54.61'}
  def self.register_lomadee(params)
    return { :error => 'Parâmetro total não enviado' } unless params[:total]
    sale = Sale.new
    user = User.find_by_id(params[:mdasc])
    sale.user = user if user
    sale.value = params[:total]
    sale.commission = 5#Partner.find_by_code(params[:id_programa]).commission
    sale.user_commission = 2.5#Partner.find_by_code(params[:id_programa]).user_commission
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
end
