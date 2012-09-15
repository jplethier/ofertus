# coding: utf-8
class Sale < ActiveRecord::Base
  attr_protected :id

  belongs_to :user

  has_many :products

  validates :value, :numericality => true
  validates :commission, :presence => true
  validates :user_commission, :presence => true
end
