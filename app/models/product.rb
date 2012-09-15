class Product < ActiveRecord::Base
  attr_protected :id

  belongs_to :sale

  validates :quantity, :presence => true
  validates :value, :numericality => true
end
