# == Schema Information
#
# Table name: products
#
#  id          :integer          not null, primary key
#  description :string(255)
#  category    :string(255)
#  quantity    :integer
#  value       :float
#  created_at  :datetime
#  updated_at  :datetime
#  sale_id     :integer
#

class Product < ActiveRecord::Base
  attr_protected :id
  has_paper_trail

  belongs_to :sale

  validates :quantity, :presence => true
  validates :value, :numericality => true
end
