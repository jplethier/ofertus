class Product < ActiveRecord::Base
  attr_protected :id
  has_paper_trail

  belongs_to :sale

  validates :quantity, :presence => true
  validates :value, :numericality => true
end
