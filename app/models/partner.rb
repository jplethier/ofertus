class Partner < ActiveRecord::Base
  attr_protected :id

  scope :active,    where(active: true)
  scope :inactive,  where(active: false)
  scope :promotion, where(promotion: true)
end