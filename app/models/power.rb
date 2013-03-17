# == Schema Information
#
# Table name: powers
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  quantity   :integer
#  status     :integer
#  created_at :datetime
#  updated_at :datetime
#

class Power < ActiveRecord::Base
  has_paper_trail

  attr_protected :id

  AVAILABLE = 1
  WITHDRAW = 9
  UNAVAILABLE = 10
  
  STATUS = [ AVAILABLE, WITHDRAW, UNAVAILABLE ]

  belongs_to :user

  validates :user_id, :status, :quantity, presence: true

  scope :available, where(status: 1)
  scope :wijthdraw, where(status: 9)
  scope :unavailable, where(status: 10)

  def self.i18n_status(status)
    I18n.t("models.power.status.#{status}")
  end
end
