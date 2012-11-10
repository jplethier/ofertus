class Power < ActiveRecord::Base
  has_paper_trail

  attr_protected :id

  AVAILABLE = 1
  WITHDRAW = 9
  UNAVAILABLE = 10
  
  STATUS = [ AVAILABLE, WITHDRAW, UNAVAILABLE ]

  belongs_to :user

  validates :user_id, :status, :quantity, presence: true

  scope :pending, where(status: 1)
  scope :withdraw, where(status: 9)

  def self.i18n_status(status)
    I18n.t("models.power.status.#{status}")
  end
end
