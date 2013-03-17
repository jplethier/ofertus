# == Schema Information
#
# Table name: partners
#
#  id                   :integer          not null, primary key
#  commission           :float
#  name                 :string(255)
#  code                 :integer
#  created_at           :datetime
#  updated_at           :datetime
#  user_commission      :float
#  image_url            :string(255)
#  small_image_url      :string(255)
#  mini_image_url       :string(255)
#  active               :boolean          default(FALSE)
#  url                  :string(255)
#  promotion            :boolean          default(FALSE)
#  promotion_commission :float            default(0.0)
#

class Partner < ActiveRecord::Base
  attr_protected :id

  scope :active,    where(active: true)
  scope :inactive,  where(active: false)
  scope :promotion, where(promotion: true)
end
